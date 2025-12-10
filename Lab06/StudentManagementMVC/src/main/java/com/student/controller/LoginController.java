package com.student.controller;

import com.student.dao.UserDAO;
import com.student.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/views/dashboard.jsp");
            return;
        }

        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("remember");

        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {

            request.setAttribute("error", "Username and password are required");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            return;
        }

        User user = userDAO.authenticate(username, password);

        if (user != null) {
            HttpSession oldSession = request.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }

            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("role", user.getRole());
            session.setAttribute("fullName", user.getFullName());
            session.setAttribute("currentUser", user);
            session.setMaxInactiveInterval(30 * 60);

            if ("on".equals(rememberMe)) {
                // Generate secure random token
                String token = java.util.UUID.randomUUID().toString();

                // Save token to database (expires in 30 days)
                userDAO.saveRememberToken(user.getId(), token);

                // Create secure cookie
                jakarta.servlet.http.Cookie remembercookie = new jakarta.servlet.http.Cookie("remember_token", token);
                remembercookie.setMaxAge(30 * 24 * 60 * 60); // 30 days
                remembercookie.setPath("/");
                remembercookie.setHttpOnly(true);
                remembercookie.setSecure(true);
                response.addCookie(remembercookie);
            }

            if (user.isAdmin()) {
                response.sendRedirect(request.getContextPath() + "/views/dashboard.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/student?action=list");
            }

        } else {
            request.setAttribute("error", "Invalid username or password");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
}
