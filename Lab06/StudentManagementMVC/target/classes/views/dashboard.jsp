<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Get theme from cookie, default to 'light'
    String currentTheme = "light";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("user_theme".equals(cookie.getName())) {
                currentTheme = cookie.getValue();
                break;
            }
        }
    }
%>
<!DOCTYPE html>
<html data-bs-theme="<%= currentTheme %>">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        [data-bs-theme="light"] {
            --bs-body-bg: #f5f5f5;
            --bs-body-color: #212529;
        }
        
        [data-bs-theme="dark"] {
            --bs-body-bg: #1a1a1a;
            --bs-body-color: #e0e0e0;
        }
        
        .navbar {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
        }
        
        [data-bs-theme="dark"] .navbar {
            background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 100%);
            border-bottom: 1px solid #404040;
        }
        
        .navbar h2 {
            font-size: 20px;
            margin: 0;
        }
        
        .navbar-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .role-badge {
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
            color: white;
        }
        
        .role-admin {
            background: #e74c3c;
        }
        
        .role-user {
            background: #3498db;
        }
        
        .theme-dropdown {
            position: relative;
        }
        
        .btn-theme {
            padding: 8px 16px;
            background: rgba(255,255,255,0.2);
            color: white;
            border: 1px solid rgba(255,255,255,0.3);
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        
        .btn-theme:hover {
            background: rgba(255,255,255,0.3);
        }
        
        .theme-menu {
            position: absolute;
            top: 100%;
            right: 0;
            background: white;
            border: 1px solid #ddd;
            border-radius: 5px;
            min-width: 150px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            margin-top: 8px;
            display: none;
            z-index: 1000;
        }
        
        [data-bs-theme="dark"] .theme-menu {
            background: #2d2d2d;
            border-color: #404040;
            color: #e0e0e0;
        }
        
        .theme-menu.show {
            display: block;
        }
        
        .theme-menu a {
            display: block;
            padding: 12px 16px;
            color: #333;
            text-decoration: none;
            border: none;
            background: none;
            cursor: pointer;
            width: 100%;
            text-align: left;
            transition: background 0.2s;
        }
        
        [data-bs-theme="dark"] .theme-menu a {
            color: #e0e0e0;
        }
        
        .theme-menu a:hover {
            background: #f5f5f5;
        }
        
        [data-bs-theme="dark"] .theme-menu a:hover {
            background: #3d3d3d;
        }
        
        .theme-menu a.active {
            background: #e8f4fd;
            color: #0066cc;
            font-weight: 600;
        }
        
        [data-bs-theme="dark"] .theme-menu a.active {
            background: #1a3a4a;
            color: #66b3ff;
        }
        
        .btn-logout {
            padding: 8px 20px;
            background: #e74c3c;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
            transition: background 0.3s;
            border: none;
            cursor: pointer;
        }
        
        .btn-logout:hover {
            background: #c0392b;
            color: white;
        }
        
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .welcome-card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        [data-bs-theme="dark"] .welcome-card {
            background: #2d2d2d;
            box-shadow: 0 2px 10px rgba(0,0,0,0.3);
        }
        
        .welcome-card h1 {
            color: #2c3e50;
            margin-bottom: 10px;
        }
        
        [data-bs-theme="dark"] .welcome-card h1 {
            color: #e0e0e0;
        }
        
        .welcome-card p {
            color: #7f8c8d;
        }
        
        [data-bs-theme="dark"] .welcome-card p {
            color: #b0b0b0;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        [data-bs-theme="dark"] .stat-card {
            background: #2d2d2d;
            box-shadow: 0 2px 10px rgba(0,0,0,0.3);
        }
        
        .stat-icon {
            font-size: 40px;
            width: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
        }
        
        .stat-icon-students {
            background: #e8f4fd;
        }
        
        [data-bs-theme="dark"] .stat-icon-students {
            background: #1a3a4a;
        }
        
        .stat-content h3 {
            font-size: 28px;
            color: #2c3e50;
            margin-bottom: 5px;
        }
        
        [data-bs-theme="dark"] .stat-content h3 {
            color: #e0e0e0;
        }
        
        .stat-content p {
            color: #7f8c8d;
            font-size: 14px;
        }
        
        [data-bs-theme="dark"] .stat-content p {
            color: #b0b0b0;
        }
        
        .quick-actions {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        [data-bs-theme="dark"] .quick-actions {
            background: #2d2d2d;
            box-shadow: 0 2px 10px rgba(0,0,0,0.3);
        }
        
        .quick-actions h2 {
            color: #2c3e50;
            margin-bottom: 20px;
        }
        
        [data-bs-theme="dark"] .quick-actions h2 {
            color: #e0e0e0;
        }
        
        .action-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }
        
        .action-btn {
            padding: 20px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            text-align: center;
            transition: all 0.3s;
            display: block;
        }
        
        .action-btn:hover {
            background: #2980b9;
            transform: translateY(-2px);
            color: white;
        }
        
        .action-btn-primary {
            background: #3498db;
        }
        
        .action-btn-success {
            background: #27ae60;
        }
        
        .action-btn-warning {
            background: #f39c12;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <div class="navbar">
        <h2>📚 Student Management System</h2>
        <div class="navbar-right">
            <div class="user-info">
                <span>${sessionScope.fullName}</span>
                <span class="role-badge role-${sessionScope.role}">
                    ${sessionScope.role}
                </span>
            </div>
            
            <!-- Theme Switcher Dropdown -->
            <div class="theme-dropdown">
                <button class="btn-theme" onclick="toggleThemeMenu(event)">
                    <i class="bi bi-palette"></i> 
                    Theme: <%= currentTheme.substring(0, 1).toUpperCase() + currentTheme.substring(1) %>
                </button>
                <div class="theme-menu" id="themeMenu">
                    <a href="theme?mode=light" class="<%= "light".equals(currentTheme) ? "active" : "" %>">
                        <i class="bi bi-sun"></i> Light
                    </a>
                    <a href="theme?mode=dark" class="<%= "dark".equals(currentTheme) ? "active" : "" %>">
                        <i class="bi bi-moon-stars"></i> Dark
                    </a>
                </div>
            </div>
            
            <a href="logout" class="btn-logout">
                <i class="bi bi-box-arrow-right"></i> Logout
            </a>
        </div>
    </div>
    
    <!-- Main Content -->
    <div class="container">
        <!-- Welcome Card -->
        <div class="welcome-card">
            <h1>${welcomeMessage}</h1>
            <p>Here's what's happening with your students today.</p>
        </div>
        
        <!-- Statistics -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon stat-icon-students">
                    👨🎓
                </div>
                <div class="stat-content">
                    <h3>${totalStudents}</h3>
                    <p>Total Students</p>
                </div>
            </div>
        </div>
        
        <!-- Quick Actions -->
        <div class="quick-actions">
            <h2>Quick Actions</h2>
            <div class="action-grid">
                <a href="student?action=list" class="action-btn action-btn-primary">
                    📋 View All Students
                </a>
                
                <c:if test="${sessionScope.role eq 'admin'}">
                    <a href="student?action=new" class="action-btn action-btn-success">
                        ➕ Add New Student
                    </a>
                </c:if>
                
                <a href="student?action=search" class="action-btn action-btn-warning">
                    🔍 Search Students
                </a>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleThemeMenu(event) {
            event.preventDefault();
            event.stopPropagation();
            const menu = document.getElementById('themeMenu');
            menu.classList.toggle('show');
        }
        
        // Close menu when clicking outside
        document.addEventListener('click', function(event) {
            const menu = document.getElementById('themeMenu');
            const btn = event.target.closest('.btn-theme');
            if (!btn) {
                menu.classList.remove('show');
            }
        });
    </script>
</body>
</html>
