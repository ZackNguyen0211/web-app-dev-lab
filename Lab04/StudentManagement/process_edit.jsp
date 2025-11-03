<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String idParam      = request.getParameter("id");
    String fullName     = request.getParameter("full_name");
    String email        = request.getParameter("email");
    String major        = request.getParameter("major");

    int studentId = -1;
    boolean valid = true;
    String validationError = null;

    try {
        studentId = Integer.parseInt(idParam);
    } catch (Exception ex) {
        valid = false;
        validationError = "Student not found";
    }

    if (valid) {
        if (fullName == null || fullName.trim().isEmpty()) {
            valid = false;
            validationError = "Required field missing";
        }
    }

    if (!valid) {
        response.sendRedirect(
            "edit_student.jsp?id=" + idParam + "&error=" 
            + validationError.replace(" ", "+")
        );
        return;
    }

    // chuẩn hóa chuỗi
    fullName = fullName.trim();
    if (email != null) email = email.trim();
    if (major != null) major = major.trim();

    // 3. Cập nhật DB
    String jdbcURL  = "jdbc:mysql://localhost:3306/student_management";
    String jdbcUser = "root";
    String jdbcPass = "123456";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);

        String sql = "UPDATE students " +
                     "SET full_name = ?, email = ?, major = ? " +
                     "WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, fullName);
        pstmt.setString(2, (email == null || email.isEmpty()) ? null : email);
        pstmt.setString(3, (major == null || major.isEmpty()) ? null : major);
        pstmt.setInt(4, studentId);

        int rows = pstmt.executeUpdate();

        if (rows > 0) {
            response.sendRedirect(
                "list_students.jsp?msg=Student+updated+successfully"
            );
        } else {
            response.sendRedirect(
                "edit_student.jsp?id=" + idParam +
                "&error=Student+not+found"
            );
        }

    } catch (Exception e) {
        response.sendRedirect(
            "edit_student.jsp?id=" + idParam +
            "&error=Database+error:+"
            + e.getMessage().replace(" ", "+")
        );
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (SQLException ignored) {}
        try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
    }
%>
