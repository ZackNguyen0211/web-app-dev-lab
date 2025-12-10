package com.student.controller;

import com.student.dao.UserDAO;
import com.student.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;

@WebServlet("/change-password")
public class ChangePasswordController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Forward to change password form
        request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validation
        String error = null;

        // Validate current password
        if (currentPassword == null || currentPassword.trim().isEmpty()) {
            error = "Current password is required";
        } else {
            // Verify current password against database
            User dbUser = userDAO.getUserById(user.getId());
            if (dbUser == null || !BCrypt.checkpw(currentPassword, dbUser.getPassword())) {
                error = "Current password is incorrect";
            }
        }

        // Validate new password
        if (error == null) {
            if (newPassword == null || newPassword.trim().isEmpty()) {
                error = "New password is required";
            } else if (newPassword.length() < 8) {
                error = "New password must be at least 8 characters long";
            }
        }

        // Validate confirm password
        if (error == null) {
            if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
                error = "Confirm password is required";
            } else if (!newPassword.equals(confirmPassword)) {
                error = "New password and confirm password do not match";
            }
        }

        if (error != null) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
            return;
        }

        // Hash new password
        String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

        // Update password in database
        boolean updated = userDAO.updatePassword(user.getId(), hashedPassword);

        if (updated) {
            response.sendRedirect(request.getContextPath() +
                    "/dashboard?message=Password changed successfully");
        } else {
            request.setAttribute("error", "Failed to update password. Please try again.");
            request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
        }
    }
}
