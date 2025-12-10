<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <% // Get theme from cookie, default to 'light' String
currentTheme = "light"; Cookie[] cookies = request.getCookies(); if (cookies !=
null) { for (Cookie cookie : cookies) { if
("user_theme".equals(cookie.getName())) { currentTheme = cookie.getValue();
break; } } } %>
<!DOCTYPE html>
<html data-bs-theme="<%= currentTheme %>">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Change Password - Student Management System</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"
    />
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 20px;
      }

      [data-bs-theme="light"] body {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      }

      [data-bs-theme="dark"] body {
        background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
      }

      .container {
        background: white;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
        width: 100%;
        max-width: 450px;
      }

      [data-bs-theme="dark"] .container {
        background: #2d2d2d;
        color: #e0e0e0;
      }

      .header {
        text-align: center;
        margin-bottom: 30px;
      }

      .header h1 {
        color: #333;
        font-size: 28px;
        margin-bottom: 10px;
      }

      [data-bs-theme="dark"] .header h1 {
        color: #e0e0e0;
      }

      .header p {
        color: #666;
        font-size: 14px;
      }

      [data-bs-theme="dark"] .header p {
        color: #b0b0b0;
      }

      .form-group {
        margin-bottom: 20px;
      }

      .form-group label {
        display: block;
        margin-bottom: 8px;
        color: #333;
        font-weight: 500;
        font-size: 14px;
      }

      [data-bs-theme="dark"] .form-group label {
        color: #e0e0e0;
      }

      .form-group input[type="password"],
      .form-group input[type="text"] {
        width: 100%;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 14px;
        transition: border-color 0.3s;
        background: white;
        color: #333;
      }

      [data-bs-theme="dark"] .form-group input[type="password"],
      [data-bs-theme="dark"] .form-group input[type="text"] {
        background: #3d3d3d;
        color: #e0e0e0;
        border-color: #505050;
      }

      .form-group input:focus {
        outline: none;
        border-color: #667eea;
        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
      }

      .password-requirements {
        background: #f8f9fa;
        padding: 12px;
        border-radius: 5px;
        margin-bottom: 20px;
        font-size: 13px;
        color: #666;
      }

      [data-bs-theme="dark"] .password-requirements {
        background: #3d3d3d;
        color: #b0b0b0;
      }

      .password-requirements ul {
        margin-left: 20px;
        margin-top: 8px;
      }

      .password-requirements li {
        margin: 4px 0;
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

      .button-group {
        display: flex;
        gap: 12px;
        margin-top: 30px;
      }

      .btn {
        flex: 1;
        padding: 12px;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s;
      }

      .btn-submit {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
      }

      .btn-submit:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
      }

      .btn-cancel {
        background: #e0e0e0;
        color: #333;
      }

      [data-bs-theme="dark"] .btn-cancel {
        background: #505050;
        color: #e0e0e0;
      }

      .btn-cancel:hover {
        background: #d0d0d0;
      }

      [data-bs-theme="dark"] .btn-cancel:hover {
        background: #606060;
      }

      .back-link {
        text-align: center;
        margin-top: 20px;
      }

      .back-link a {
        color: #667eea;
        text-decoration: none;
        font-size: 14px;
      }

      [data-bs-theme="dark"] .back-link a {
        color: #88b0ff;
      }

      .back-link a:hover {
        text-decoration: underline;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="header">
        <h1>🔐 Change Password</h1>
        <p>Update your account password</p>
      </div>

      <!-- Error message -->
      <c:if test="${not empty error}">
        <div class="alert alert-error">❌ ${error}</div>
      </c:if>

      <!-- Password requirements -->
      <div class="password-requirements">
        <strong>Password Requirements:</strong>
        <ul>
          <li>Minimum 8 characters</li>
          <li>Current password must match</li>
          <li>New passwords must match</li>
        </ul>
      </div>

      <form action="change-password" method="post">
        <!-- Current Password -->
        <div class="form-group">
          <label for="currentPassword">Current Password</label>
          <input
            type="password"
            id="currentPassword"
            name="currentPassword"
            placeholder="Enter your current password"
            required
            autofocus
          />
        </div>

        <!-- New Password -->
        <div class="form-group">
          <label for="newPassword">New Password</label>
          <input
            type="password"
            id="newPassword"
            name="newPassword"
            placeholder="Enter your new password (min. 8 characters)"
            required
            minlength="8"
          />
        </div>

        <!-- Confirm Password -->
        <div class="form-group">
          <label for="confirmPassword">Confirm Password</label>
          <input
            type="password"
            id="confirmPassword"
            name="confirmPassword"
            placeholder="Re-enter your new password"
            required
            minlength="8"
          />
        </div>

        <!-- Buttons -->
        <div class="button-group">
          <button type="submit" class="btn btn-submit">Change Password</button>
          <a
            href="dashboard"
            style="
              display: flex;
              align-items: center;
              justify-content: center;
              text-decoration: none;
            "
          >
            <button type="button" class="btn btn-cancel">Cancel</button>
          </a>
        </div>
      </form>

      <div class="back-link">
        <a href="dashboard">← Back to Dashboard</a>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
