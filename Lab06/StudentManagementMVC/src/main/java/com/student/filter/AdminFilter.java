package com.student.filter;

import com.student.model.User;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(filterName = "AdminFilter", urlPatterns = {"/student"})
public class AdminFilter implements Filter {

    private static final String[] ADMIN_ACTIONS = {
            "new",
            "insert",
            "edit",
            "update",
            "delete"
    };

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("AdminFilter initialized");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String action = httpRequest.getParameter("action");

        if (isAdminAction(action)) {
            HttpSession session = httpRequest.getSession(false);

            if (session != null) {
                User user = (User) session.getAttribute("user");

                if (user != null && user.isAdmin()) {
                    chain.doFilter(request, response);
                } else {
                    httpResponse.sendRedirect(httpRequest.getContextPath() +
                            "/student?action=list&error=Access denied. Admin privileges required.");
                }
            } else {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            }
        } else {
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
        System.out.println("AdminFilter destroyed");
    }

    private boolean isAdminAction(String action) {
        if (action == null) return false;

        for (String adminAction : ADMIN_ACTIONS) {
            if (adminAction.equals(action)) {
                return true;
            }
        }
        return false;
    }
}
