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
    <title>Login - Student Management System</title>
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
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        [data-bs-theme="light"] body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        
        [data-bs-theme="dark"] body {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
        }
        
        .login-header {
            position: absolute;
            top: 20px;
            right: 20px;
            display: flex;
            gap: 10px;
        }
        
        .btn-theme-login {
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
            text-decoration: none;
        }
        
        .btn-theme-login:hover {
            background: rgba(255,255,255,0.3);
            color: white;
        }
        
        .login-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 400px;
        }
        
        [data-bs-theme="dark"] .login-container {
            background: #2d2d2d;
            color: #e0e0e0;
        }
        
        .login-title {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .login-title h1 {
            color: #333;
            font-size: 28px;
            margin-bottom: 10px;
        }
        
        [data-bs-theme="dark"] .login-title h1 {
            color: #e0e0e0;
        }
        
        .login-title p {
            color: #666;
            font-size: 14px;
        }
        
        [data-bs-theme="dark"] .login-title p {
            color: #b0b0b0;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-weight: 500;
        }
        
        [data-bs-theme="dark"] .form-group label {
            color: #e0e0e0;
        }
        
        .form-group input[type="text"],
        .form-group input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
            background: white;
            color: #333;
        }
        
        [data-bs-theme="dark"] .form-group input[type="text"],
        [data-bs-theme="dark"] .form-group input[type="password"] {
            background: #3d3d3d;
            color: #e0e0e0;
            border-color: #505050;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102,126,234,0.1);
        }
        
        .remember-me {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .remember-me input {
            margin-right: 8px;
            cursor: pointer;
        }
        
        .remember-me label {
            color: #666;
            font-size: 14px;
            cursor: pointer;
        }
        
        [data-bs-theme="dark"] .remember-me label {
            color: #b0b0b0;
        }
        
        .btn-login {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            color: white;
        }
        
        .alert {
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        
        .alert-error {
            background: #fee;
            color: #c33;
            border: 1px solid #fcc;
        }
        
        [data-bs-theme="dark"] .alert-error {
            background: #3d1f1f;
            color: #ff6b6b;
            border-color: #5d3f3f;
        }
        
        .alert-success {
            background: #efe;
            color: #3c3;
            border: 1px solid #cfc;
        }
        
        [data-bs-theme="dark"] .alert-success {
            background: #1f3d1f;
            color: #6bff6b;
            border-color: #3f5f3f;
        }
        
        .demo-credentials {
            margin-top: 20px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 5px;
            font-size: 12px;
        }
        
        [data-bs-theme="dark"] .demo-credentials {
            background: #3d3d3d;
            color: #e0e0e0;
        }
        
        .demo-credentials h4 {
            margin-bottom: 10px;
            color: #333;
        }
        
        [data-bs-theme="dark"] .demo-credentials h4 {
            color: #e0e0e0;
        }
        
        .demo-credentials p {
            margin: 5px 0;
            color: #666;
        }
        
        [data-bs-theme="dark"] .demo-credentials p {
            color: #b0b0b0;
        }
    </style>
</head>
<body>
    <!-- Theme Switcher -->
    <div class="login-header">
        <a href="theme?mode=light" class="btn-theme-login <%= "light".equals(currentTheme) ? "active" : "" %>">
            <i class="bi bi-sun"></i> Light
        </a>
        <a href="theme?mode=dark" class="btn-theme-login <%= "dark".equals(currentTheme) ? "active" : "" %>">
            <i class="bi bi-moon-stars"></i> Dark
        </a>
    </div>
    
    <div class="login-container">
        <div class="login-title">
            <h1>🔐 Login</h1>
            <p>Student Management System</p>
        </div>
        
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                ❌ ${error}
            </div>
        </c:if>
        
        <c:if test="${not empty param.message}">
            <div class="alert alert-success">
                ✅ ${param.message}
            </div>
        </c:if>
        
        <form action="login" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" 
                       id="username" 
                       name="username" 
                       value="${username}"
                       placeholder="Enter your username"
                       required
                       autofocus>
            </div>
            
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" 
                       id="password" 
                       name="password" 
                       placeholder="Enter your password"
                       required>
            </div>
            
            <div class="remember-me">
                <input type="checkbox" id="remember" name="remember">
                <label for="remember">Remember me for 30 days</label>
            </div>
            
            <button type="submit" class="btn-login">Login</button>
        </form>
        
        <div class="demo-credentials">
            <h4>Demo Credentials:</h4>
            <p><strong>Admin:</strong> username: admin / password: password123</p>
            <p><strong>User:</strong> username: john / password: password123</p>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
