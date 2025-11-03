<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Student</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f8f9fa;
        }
        h2 { color: #333; }

        .error {
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 4px;
            background-color: #ffe5e5;
            border: 1px solid #ff9999;
            color: #a30000;
            font-size: 14px;
            max-width: 400px;
        }

        form {
            background: #fff;
            padding: 20px;
            border: 1px solid #ccc;
            max-width: 400px;
            border-radius: 6px;
        }

        label {
            display: block;
            font-weight: 600;
            margin-top: 12px;
            color: #222;
        }

        input[type="text"],
        input[type="email"] {
            width: 100%;
            padding: 8px 10px;
            margin-top: 4px;
            border: 1px solid #aaa;
            border-radius: 4px;
        }

        input[readonly] {
            background-color: #e9ecef;
            color: #495057;
        }

        .actions {
            margin-top: 20px;
            display: flex;
            gap: 10px;
        }
        .btn-primary {
            background-color: #28a745;
            color: #fff;
            border: none;
            padding: 8px 14px;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: #fff;
            text-decoration: none;
            padding: 8px 14px;
            border-radius: 4px;
            display: inline-block;
        }

    </style>
</head>
<body>

<h2>Edit Student</h2>

<%
    String idParam = request.getParameter("id");

    int studentId   = -1;
    String codeVal  = null;
    String nameVal  = null;
    String emailVal = null;
    String majorVal = null;

    String loadError = null;

    if (idParam == null || idParam.trim().isEmpty()) {
        loadError = "Student not found";
    } else {
        try {
            studentId = Integer.parseInt(idParam);
        } catch (NumberFormatException nfe) {
            loadError = "Student not found";
        }
    }

    if (loadError == null) {
        String jdbcURL  = "jdbc:mysql://localhost:3306/student_management";
        String jdbcUser = "root";
        String jdbcPass = "123456";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);

            String sql = "SELECT id, student_code, full_name, email, major FROM students WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, studentId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                codeVal  = rs.getString("student_code");
                nameVal  = rs.getString("full_name");
                emailVal = rs.getString("email");
                majorVal = rs.getString("major");
            } else {
                loadError = "Student not found";
            }
        } catch (Exception e) {
            loadError = "Database error: " + e.getMessage();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
            try { if (pstmt != null) pstmt.close(); } catch (SQLException ignored) {}
            try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
        }
    }

    if (loadError != null) {
%>
    <div class="error"><%= loadError %></div>
    <p><a href="list_students.jsp" class="btn-secondary">Back to list</a></p>
</body>
</html>
<%
        return;
    }

    String err = request.getParameter("error");
    if (err != null && !err.isEmpty()) {
%>
    <div class="error"><%= err %></div>
<%
    }
%>

<form action="process_edit.jsp" method="POST">
    <!-- hidden id -->
    <input type="hidden" name="id" value="<%= studentId %>" />

    <label>Student Code</label>
    <input type="text" name="student_code" value="<%= codeVal %>" readonly />

    <label>Full Name (required)</label>
    <input type="text" name="full_name" value="<%= nameVal %>" required />

    <label>Email (optional)</label>
    <input type="email" name="email" value="<%= (emailVal != null ? emailVal : "") %>" />

    <label>Major (optional)</label>
    <input type="text" name="major" value="<%= (majorVal != null ? majorVal : "") %>" />

    <div class="actions">
        <button type="submit" class="btn-primary">Update</button>
        <a href="list_students.jsp" class="btn-secondary">Cancel</a>
    </div>
</form>

</body>
</html>
