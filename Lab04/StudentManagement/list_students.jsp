<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Student List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f8f9fa;
        }
        h2 {
            color: #333;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            background-color: #fff;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .error {
            color: red;
            font-weight: bold;
        }
        .msg-box {
            background-color:#d4edda;
            border:1px solid #28a745;
            color:#155724;
            padding:10px;
            border-radius:4px;
            max-width:400px;
            margin-bottom:15px;
            font-size:14px;
        }
        .add-btn {
            background:#007bff;
            color:#fff;
            padding:8px 12px;
            border-radius:4px;
            text-decoration:none;
            display:inline-block;
            font-size:14px;
            margin-bottom:15px;
        }
        .edit-link {
            color:#007bff;
            text-decoration:none;
            margin-right:10px;
        }
        .delete-link {
            color:#dc3545;
            text-decoration:none;
        }
    </style>
    <script>
        function confirmDelete() {
            return confirm('Are you sure you want to delete this student?');
        }
    </script>
</head>
<body>
<h2>Student List</h2>

<%
    String msg = request.getParameter("msg");
    if (msg != null && !msg.isEmpty()) {
%>
    <div class="msg-box"><%= msg %></div>
<%
    }
%>

<p>
    <a href="add_student.jsp" class="add-btn">+ Add New Student</a>
</p>

<%
    String jdbcURL = "jdbc:mysql://localhost:3306/student_management";
    String jdbcUser = "root";
    String jdbcPass = "123456";

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);
        String sql = "SELECT id, student_code, full_name, email, major, created_at FROM students";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(sql);
%>

<table>
    <tr>
        <th>ID</th>
        <th>Student Code</th>
        <th>Full Name</th>
        <th>Email</th>
        <th>Major</th>
        <th>Created At</th>
        <th>Actions</th>
    </tr>

<%
        while (rs.next()) {
            int id = rs.getInt("id");
%>
    <tr>
        <td><%= id %></td>
        <td><%= rs.getString("student_code") %></td>
        <td><%= rs.getString("full_name") %></td>
        <td><%= rs.getString("email") %></td>
        <td><%= rs.getString("major") %></td>
        <td><%= rs.getTimestamp("created_at") %></td>
        <td>
            <a class="edit-link" href="edit_student.jsp?id=<%= id %>">Edit</a>
            <a class="delete-link"
               href="delete_student.jsp?id=<%= id %>"
               onclick="return confirmDelete();">
               Delete
            </a>
        </td>
    </tr>
<%
        }
%>
</table>

<%
    } catch (Exception e) {
%>
    <p class="error">Error: <%= e.getMessage() %></p>
<%
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
        try { if (stmt != null) stmt.close(); } catch (SQLException ignored) {}
        try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
    }
%>

</body>
</html>
