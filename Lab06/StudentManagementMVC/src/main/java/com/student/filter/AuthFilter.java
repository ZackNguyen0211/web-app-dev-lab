package com.student.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/*"})
public class AuthFilter implements Filter {

    private static final String[] PUBLIC_URLS = {
            "/login",
            "/logout",
            ".css",
            ".js",
            ".png",
            ".jpg",
            ".jpeg",
            ".gif"
    };

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("AuthFilter initialized");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = requestURI.substring(contextPath.length());

        if (isPublicUrl(path)) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);

        if (!isLoggedIn) {
            // Check for remember token cookie
            String token = null;
            Cookie[] cookies = httpRequest.getCookies();

            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("remember_token".equals(cookie.getName())) {
                        token = cookie.getValue();
                        break;
                    }
                }
            }

            // If remember token exists, try auto-login
            if (token != null) {
                com.student.dao.UserDAO userDAO = new com.student.dao.UserDAO();
                com.student.model.User user = userDAO.getUserByToken(token);

                if (user != null) {
                    // Token is valid - auto-login user
                    session = httpRequest.getSession(true);
                    session.setAttribute("user", user);
                    session.setAttribute("userId", user.getId());
                    session.setAttribute("username", user.getUsername());
                    session.setAttribute("role", user.getRole());
                    session.setAttribute("fullName", user.getFullName());
                    session.setMaxInactiveInterval(30 * 60);

                    // Continue to requested page
                    chain.doFilter(request, response);
                    return;
                } else {
                    // Token invalid/expired - delete cookie
                    Cookie deleteCookie = new Cookie("remember_token", "");
                    deleteCookie.setMaxAge(0);
                    deleteCookie.setPath("/");
                    httpResponse.addCookie(deleteCookie);
                }
            }
        }

        if (isLoggedIn) {
            chain.doFilter(request, response);
        } else {
            String loginURL = contextPath + "/login";
            httpResponse.sendRedirect(loginURL);
        }
    }

    @Override
    public void destroy() {
        System.out.println("AuthFilter destroyed");
    }

    private boolean isPublicUrl(String path) {
        for (String publicUrl : PUBLIC_URLS) {
            if (path.contains(publicUrl)) {
                return true;
            }
        }
        return false;
    }
}
