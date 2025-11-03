<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String studentCode = request.getParameter("student_code");
    String fullName    = request.getParameter("full_name");
    String email       = request.getParameter("email");
    String major       = request.getParameter("major");

    if (studentCode == null || studentCode.trim().isEmpty()
        || fullName == null || fullName.trim().isEmpty()) {

        response.sendRedirect("add_student.jsp?error=Student+Code+and+Full+Name+are+required");
        return;
    }

    studentCode = studentCode.trim();
    fullName    = fullName.trim();
    if (email != null)  email = email.trim();
    if (major != null)  major = major.trim();

    String jdbcURL = "jdbc:mysql://localhost:3306/student_management";
    String jdbcUser = "root";
    String jdbcPass = "123456";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);

        String sql = "INSERT INTO students (student_code, full_name, email, major) "
                   + "VALUES (?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, studentCode);
        pstmt.setString(2, fullName);
        pstmt.setString(3, (email == null || email.isEmpty()) ? null : email);
        pstmt.setString(4, (major == null || major.isEmpty()) ? null : major);

        int rows = pstmt.executeUpdate();

        if (rows > 0) {
            response.sendRedirect("list_students.jsp?msg=Student+added+successfully");
        } else {
            response.sendRedirect("add_student.jsp?error=Failed+to+add+student");
        }

    } catch (SQLIntegrityConstraintViolationException dupEx) {
        response.sendRedirect(
            "add_student.jsp?error=Student+Code+already+exists"
        );

    } catch (Exception e) {
        response.sendRedirect(
            "add_student.jsp?error=Database+error:+"
            + e.getMessage().replace(" ", "+")
        );

    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (SQLException ignore) {}
        try { if (conn  != null) conn.close();  } catch (SQLException ignore) {}
    }
%>
