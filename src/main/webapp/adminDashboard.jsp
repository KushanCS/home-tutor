<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Meta Tutor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #3498db;
            --admin-color: #6c757d;
            --danger-color: #dc3545;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }

        .sidebar {
            background-color: #343a40;
            min-height: 100vh;
            color: white;
        }

        .sidebar .nav-link {
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 5px;
        }

        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            color: white;
            background-color: rgba(255, 255, 255, 0.1);
        }

        .sidebar .nav-link i {
            margin-right: 10px;
        }

        .dashboard-header {
            background-color: white;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card-icon {
            font-size: 2rem;
            margin-bottom: 15px;
        }

        .bg-admin {
            background-color: var(--admin-color);
        }

        .badge-admin {
            background-color: var(--admin-color);
            color: white;
        }

        .action-btn {
            padding: 5px 10px;
            font-size: 0.8rem;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3 col-lg-2 d-md-block sidebar bg-dark">
            <div class="text-center py-4">
                <h4>Meta Tutor Admin</h4>
            </div>
            <ul class="nav flex-column px-3">
                <li class="nav-item">
                    <a class="nav-link active" href="adminDashboard.jsp">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="StudentManagement.jsp">
                        <i class="fas fa-users"></i> Students
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="TutorManagement.jsp">
                        <i class="fas fa-chalkboard-teacher"></i> Tutors
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="courseManagement.jsp">
                        <i class="fas fa-book"></i> Courses
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="fas fa-cog"></i> Settings
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="logout.jsp">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </li>
            </ul>
        </div>

        <!-- Main Content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="dashboard-header d-flex justify-content-between align-items-center mb-4">
                <h2>Admin Dashboard</h2>
                <span class="badge badge-admin p-2">
                    Welcome, ${fullName} <i class="fas fa-user-shield ms-2"></i>
                </span>
            </div>

            <!-- Messages -->
            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <!-- Stats Cards -->
            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="card text-white bg-primary h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-users card-icon"></i>
                            <h5 class="card-title">Total Students</h5>
                            <h2 class="card-text">${studentCount}</h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-white bg-success h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-book card-icon"></i>
                            <h5 class="card-title">Courses</h5>
                            <h2 class="card-text">12</h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-white bg-admin h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-user-shield card-icon"></i>
                            <h5 class="card-title">Admin Privileges</h5>
                            <h2 class="card-text">Active</h2>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Students Table -->
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Student Management</h5>
                    <a href="addStudent.jsp" class="btn btn-sm btn-primary">
                        <i class="fas fa-plus"></i> Add Student
                    </a>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Course</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${students}" var="student">
                                <tr>
                                    <td>${student.stdId}</td>
                                    <td>${student.name}</td>
                                    <td>${student.userName}</td>
                                    <td>${student.email}</td>
                                    <td>${student.course}</td>
                                    <td>
                                        <a href="editStudent.jsp?id=${student.stdId}"
                                           class="btn btn-sm btn-outline-primary action-btn">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                        <form action="AdminDashboardServlet" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="deleteStudent">
                                            <input type="hidden" name="studentId" value="${student.stdId}">
                                            <button type="submit" class="btn btn-sm btn-outline-danger action-btn"
                                                    onclick="return confirm('Are you sure you want to delete this student?')">
                                                <i class="fas fa-trash-alt"></i> Delete
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Activate current nav link
    document.querySelectorAll('.nav-link').forEach(link => {
        if (link.href === window.location.href) {
            link.classList.add('active');
        }
    });
</script>
</body>
</html>