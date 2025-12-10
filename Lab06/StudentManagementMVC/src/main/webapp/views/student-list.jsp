<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student List - MVC</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        }

        h1 {
            color: #333;
            margin-bottom: 10px;
            font-size: 32px;
        }

        .subtitle {
            color: #666;
            margin-bottom: 30px;
            font-style: italic;
        }

        .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-weight: 500;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 500;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-danger {
            background-color: #dc3545;
            color: white;
            padding: 8px 16px;
            font-size: 13px;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        /* 🔍 Search area */
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
        }

        .search-form {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 12px;
            border-radius: 6px;
            background-color: #f8f9fa;
            border: 1px solid #e0e0e0;
        }

        .search-input {
            padding: 8px 12px;
            border-radius: 4px;
            border: 1px solid #ccc;
            min-width: 260px;
            font-size: 14px;
        }

        .search-info {
            margin-bottom: 10px;
            color: #555;
            font-style: italic;
        }

        /* 🔽 Filter area */
        .filter-box {
            margin: 10px 0 15px 0;
            padding: 10px 12px;
            border-radius: 6px;
            background-color: #f8f9fa;
            border: 1px solid #e0e0e0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .filter-box label {
            font-size: 14px;
            color: #555;
            font-weight: 500;
        }

        .filter-select {
            padding: 8px 12px;
            border-radius: 4px;
            border: 1px solid #ccc;
            min-width: 220px;
            font-size: 14px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            font-weight: 600;
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 0.5px;
        }

        tbody tr {
            transition: background-color 0.2s;
        }

        tbody tr:hover {
            background-color: #f8f9fa;
        }

        .actions {
            display: flex;
            gap: 10px;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }

        .empty-state-icon {
            font-size: 64px;
            margin-bottom: 20px;
        }

        /* Sort link styling */
        .sort-link {
            color: white;
            text-decoration: none;
        }

        .sort-link:hover {
            text-decoration: underline;
        }

        .sort-indicator {
            margin-left: 4px;
            font-size: 12px;
        }

        .navbar {
            background: #2c3e50;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .navbar-right {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .role-badge {
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
            background: #3498db;
        }

        .btn-nav, .btn-logout {
            padding: 8px 16px;
            border-radius: 6px;
            text-decoration: none;
            color: white;
            font-weight: 600;
        }

        .btn-nav { background: #3498db; }
        .btn-nav:hover { background: #2980b9; }
        .btn-logout { background: #e74c3c; }
        .btn-logout:hover { background: #c0392b; }

        .btn-add {
            display: inline-block;
            padding: 10px 18px;
            background: #27ae60;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 600;
        }
        .btn-add:hover { background: #1e8a4c; }
    </style>
</head>
<body>
            <div class="container">
        <div class="navbar">
            <h2>📚 Student Management System</h2>
            <div class="navbar-right">
                <div class="user-info">
                    <span>Welcome, ${sessionScope.fullName}</span>
                    <span class="role-badge role-${sessionScope.role}">
                        ${sessionScope.role}
                    </span>
                </div>
                <a href="dashboard" class="btn-nav">Dashboard</a>
                <a href="logout" class="btn-logout">Logout</a>
            </div>
        </div>

                <!-- Top bar: Add button + Search form -->
        <div class="top-bar">
            <!-- Add New Student Button (admin only) -->
            <c:if test="${sessionScope.role eq 'admin'}">
                <a href="student?action=new" class="btn-add">➕ Add New Student</a>
            </c:if>

            <!-- Search Form (GET to student servlet) -->
            <form class="search-form" action="student" method="get">
                <input type="hidden" name="action" value="search">
                <input
                    type="text"
                    name="keyword"
                    class="search-input"
                    placeholder="Search by code, name, or email..."
                    value="${keyword}"
                />
                <button type="submit" class="btn btn-primary">Search</button>

                <!-- Show All button ONLY when searching -->
                <c:if test="${not empty keyword}">
                    <a href="student?action=list" class="btn btn-secondary">
                        Show All
                    </a>
                </c:if>
            </form>
        </div>

        <!-- Search info -->
        <c:if test="${not empty keyword}">
            <div class="search-info">
                Search results for: "<strong>${keyword}</strong>"
            </div>
        </c:if>

        <!-- 🔽 Major Filter Dropdown -->
        <div class="filter-box">
            <form action="student" method="get">
                <input type="hidden" name="action" value="filter">
                <label for="major">Filter by Major:</label>
                <select id="major" name="major" class="filter-select">
                    <option value="">All Majors</option>
                    <option value="Computer Science"
                        ${filterMajor == 'Computer Science' 'selected' : ''}>
                        Computer Science
                    </option>
                    <option value="Information Technology"
                        ${filterMajor == 'Information Technology' 'selected' : ''}>
                        Information Technology
                    </option>
                    <option value="Software Engineering"
                        ${filterMajor == 'Software Engineering' 'selected' : ''}>
                        Software Engineering
                    </option>
                    <option value="Business Administration"
                        ${filterMajor == 'Business Administration' 'selected' : ''}>
                        Business Administration
                    </option>
                </select>

                <button type="submit" class="btn btn-primary">Apply Filter</button>

                <!-- Clear filter only when filtering -->
                <c:if test="${not empty filterMajor}">
                    <a href="student?action=list" class="btn btn-secondary">Clear Filter</a>
                </c:if>
            </form>
        </div>

        <!-- Student Table -->
        <c:choose>
            <c:when test="${not empty students}">

                <!-- Prepare next order values for each column -->
                <c:set var="currentSort" value="${sortBy}" />
                <c:set var="currentOrder" value="${order}" />

                <c:set var="idOrder" value="asc" />
                <c:if test="${currentSort == 'id' && currentOrder == 'asc'}">
                    <c:set var="idOrder" value="desc" />
                </c:if>

                <c:set var="codeOrder" value="asc" />
                <c:if test="${currentSort == 'student_code' && currentOrder == 'asc'}">
                    <c:set var="codeOrder" value="desc" />
                </c:if>

                <c:set var="nameOrder" value="asc" />
                <c:if test="${currentSort == 'full_name' && currentOrder == 'asc'}">
                    <c:set var="nameOrder" value="desc" />
                </c:if>

                <c:set var="emailOrder" value="asc" />
                <c:if test="${currentSort == 'email' && currentOrder == 'asc'}">
                    <c:set var="emailOrder" value="desc" />
                </c:if>

                <c:set var="majorOrder" value="asc" />
                <c:if test="${currentSort == 'major' && currentOrder == 'asc'}">
                    <c:set var="majorOrder" value="desc" />
                </c:if>

                <table>
                    <thead>
                        <tr>
                            <th>
                                <a class="sort-link"
                                   href="student?action=sort&sortBy=id&order=${idOrder}">
                                    ID
                                    <c:if test="${currentSort == 'id'}">
                                        <span class="sort-indicator">
                                            ${currentOrder == 'asc' '▲' : '▼'}
                                        </span>
                                    </c:if>
                                </a>
                            </th>
                            <th>
                                <a class="sort-link"
                                   href="student?action=sort&sortBy=student_code&order=${codeOrder}">
                                    Student Code
                                    <c:if test="${currentSort == 'student_code'}">
                                        <span class="sort-indicator">
                                            ${currentOrder == 'asc' '▲' : '▼'}
                                        </span>
                                    </c:if>
                                </a>
                            </th>
                            <th>
                                <a class="sort-link"
                                   href="student?action=sort&sortBy=full_name&order=${nameOrder}">
                                    Full Name
                                    <c:if test="${currentSort == 'full_name'}">
                                        <span class="sort-indicator">
                                            ${currentOrder == 'asc' '▲' : '▼'}
                                        </span>
                                    </c:if>
                                </a>
                            </th>
                            <th>
                                <a class="sort-link"
                                   href="student?action=sort&sortBy=email&order=${emailOrder}">
                                    Email
                                    <c:if test="${currentSort == 'email'}">
                                        <span class="sort-indicator">
                                            ${currentOrder == 'asc' '▲' : '▼'}
                                        </span>
                                    </c:if>
                                </a>
                            </th>
                            <th>
                                <a class="sort-link"
                                   href="student?action=sort&sortBy=major&order=${majorOrder}">
                                    Major
                                    <c:if test="${currentSort == 'major'}">
                                        <span class="sort-indicator">
                                            ${currentOrder == 'asc' '▲' : '▼'}
                                        </span>
                                    </c:if>
                                </a>
                            </th>
                            <c:if test="${sessionScope.role eq 'admin'}">
                                <th>Actions</th>
                            </c:if>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="student" items="${students}">
                            <tr>
                                <td>${student.id}</td>
                                <td><strong>${student.studentCode}</strong></td>
                                <td>${student.fullName}</td>
                                <td>${student.email}</td>
                                <td>${student.major}</td>
                                                                <c:if test="${sessionScope.role eq 'admin'}">
                                    <td>
                                        <div class="actions">
                                            <a href="student?action=edit&id=${student.id}" class="btn btn-secondary">
                                                Edit
                                            </a>
                                            <a href="student?action=delete&id=${student.id}"
                                               class="btn btn-danger"
                                               onclick="return confirm('Are you sure you want to delete this student?')">
                                                Delete
                                            </a>
                                        </div>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-state-icon">📭</div>
                    <h3>No students found</h3>
                    <p>Start by adding a new student</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>







