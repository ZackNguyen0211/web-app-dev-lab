<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String idParam = request.getParameter("id");
    String jdbcURL = "jdbc:mysql://localhost:3306/student_management";
    String jdbcUser = "root";
    String jdbcPass = "123456";

    if (idParam == null || idParam.trim().isEmpty()) {
        response.sendRedirect("list_students.jsp?msg=Student+not+found");
        return;
    }

    int studentId = -1;
    try {
        studentId = Integer.parseInt(idParam);
    } catch (NumberFormatException e) {
        response.sendRedirect("list_students.jsp?msg=Student+not+found");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);

        String sql = "DELETE FROM students WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, studentId);

        int rows = pstmt.executeUpdate();

        if (rows > 0) {
            response.sendRedirect("list_students.jsp?msg=Student+deleted+successfully");
        } else {
            response.sendRedirect("list_students.jsp?msg=Student+not+found");
        }

    } catch (Exception e) {
        response.sendRedirect(
            "list_students.jsp?msg=Database+error:+"
            + e.getMessage().replace(" ", "+")
        );
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (SQLException ignored) {}
        try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
    }
%>
