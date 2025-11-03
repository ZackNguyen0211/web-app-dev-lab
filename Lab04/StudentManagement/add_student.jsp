<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Student</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f8f9fa;
        }
        h2 { color: #333; }

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

        .actions {
            margin-top: 20px;
            display: flex;
            gap: 10px;
        }

        .btn-primary {
            background-color: #007bff;
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

        .error {
            margin-bottom: 10px;
            padding: 10px;
            border-radius: 4px;
            background-color: #ffe5e5;
            border: 1px solid #ff9999;
            color: #a30000;
            font-size: 14px;
        }
    </style>
</head>
<body>

<h2>Add Student</h2>

<%
    String error = request.getParameter("error");
    if (error != null && !error.isEmpty()) {
%>
    <div class="error"><%= error %></div>
<%
    }
%>

<form action="process_add.jsp" method="POST">
    <label>Student Code (required)</label>
    <input type="text" name="student_code" required />

    <label>Full Name (required)</label>
    <input type="text" name="full_name" required />

    <label>Email (optional)</label>
    <input type="email" name="email" />

    <label>Major (optional)</label>
    <input type="text" name="major" />

    <div class="actions">
        <button type="submit" class="btn-primary">Submit</button>
        <a href="list_students.jsp" class="btn-secondary">Cancel</a>
    </div>
</form>

</body>
</html>
