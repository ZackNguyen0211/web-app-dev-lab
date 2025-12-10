package com.student.util;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Utility class for cookie management
 * Provides static methods for creating, reading, updating, and deleting cookies
 */
public class CookieUtil {

    /**
     * Create and add cookie to response
     * @param response HTTP response
     * @param name Cookie name
     * @param value Cookie value
     * @param maxAge Cookie lifetime in seconds
     */
    public static void createCookie(HttpServletResponse response,
                                   String name,
                                   String value,
                                   int maxAge) {
        if (response == null || name == null) {
            return;
        }

        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAge);
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        response.addCookie(cookie);
    }

    /**
     * Get cookie value by name
     * @param request HTTP request
     * @param name Cookie name
     * @return Cookie value or null if not found
     */
    public static String getCookieValue(HttpServletRequest request, String name) {
        if (request == null || name == null) {
            return null;
        }

        Cookie[] cookies = request.getCookies();

        // Handle case where no cookies exist
        if (cookies == null) {
            return null;
        }

        // Loop through cookies to find matching name
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals(name)) {
                String value = cookie.getValue();
                // Return null if value is empty string
                return value != null && !value.isEmpty() ? value : null;
            }
        }

        return null;
    }

    /**
     * Check if cookie exists
     * @param request HTTP request
     * @param name Cookie name
     * @return true if cookie exists
     */
    public static boolean hasCookie(HttpServletRequest request, String name) {
        return getCookieValue(request, name) != null;
    }

    /**
     * Delete cookie by setting max age to 0
     * @param response HTTP response
     * @param name Cookie name to delete
     */
    public static void deleteCookie(HttpServletResponse response, String name) {
        if (response == null || name == null) {
            return;
        }

        Cookie cookie = new Cookie(name, "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        response.addCookie(cookie);
    }

    /**
     * Update existing cookie
     * @param response HTTP response
     * @param name Cookie name
     * @param newValue New cookie value
     * @param maxAge New max age
     */
    public static void updateCookie(HttpServletResponse response,
                                   String name,
                                   String newValue,
                                   int maxAge) {
        createCookie(response, name, newValue, maxAge);
    }

    /**
     * Get cookie integer value by name
     * @param request HTTP request
     * @param name Cookie name
     * @param defaultValue Default value if cookie not found or invalid
     * @return Cookie value as integer
     */
    public static int getCookieIntValue(HttpServletRequest request, String name, int defaultValue) {
        String value = getCookieValue(request, name);
        if (value == null) {
            return defaultValue;
        }

        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    /**
     * Create secure cookie with specific domain
     * @param response HTTP response
     * @param name Cookie name
     * @param value Cookie value
     * @param maxAge Cookie lifetime in seconds
     * @param domain Cookie domain
     */
    public static void createSecureCookie(HttpServletResponse response,
                                         String name,
                                         String value,
                                         int maxAge,
                                         String domain) {
        if (response == null || name == null) {
            return;
        }

        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAge);
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        if (domain != null && !domain.isEmpty()) {
            cookie.setDomain(domain);
        }
        response.addCookie(cookie);
    }
}
