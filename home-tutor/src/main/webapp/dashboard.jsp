<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Student Management Dashboard</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <style>
        body {
            display: flex;
            min-height: 100vh;
        }
        .sidebar {
            width: 250px;
            background: #2C3E50;
            color: white;
            padding: 20px;
            position: fixed;
            height: 100%;
        }
        .sidebar a {
            color: white;
            text-decoration: none;
            display: block;
            padding: 12px;
            border-radius: 5px;
        }
        .sidebar a:hover {
            background: #34495E;
        }
        .content {
            margin-left: 250px;
            padding: 20px;
            width: 100%;
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h4 class="text-center">📚 Student Management</h4>
    <hr>
    <a href="#">Dashboard</a>
    <a href="students.jsp">Students</a>
    <a href="tutors.jsp">Tutors</a>
    <a href="courses.jsp">Courses</a>
    <a href="reports.jsp">Reports</a>
    <a href="settings.jsp">Settings</a>
    <a href="user-account.jsp">Account</a>
    <a href="logout.jsp" class="text-danger">Logout</a>
</div>

<!-- Main Content -->
<div class="content">
    <nav class="navbar navbar-light bg-light shadow-sm p-3">
        <span class="navbar-brand mb-0 h4">Welcome, <%= request.getAttribute("username") %>!</span>
    </nav>

    <div class="container mt-4">
        <h2>Dashboard Overview</h2>
        <p>Manage students, tutors, courses, and more from here.</p>

        <div class="row">
            <div class="col-md-4">
                <div class="card text-white bg-info mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Total Students</h5>
                        <p class="card-text"><%= request.getAttribute("totalStudents") %></p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-white mb-3" style="background: #1E88E5;">
                    <div class="card-body">
                        <h5 class="card-title">Total Tutors</h5>
                        <p class="card-text"><%= request.getAttribute("totalTutors") %></p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-white bg-primary mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Courses Available</h5>
                        <p class="card-text"><%= request.getAttribute("totalCourses") %></p>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- Bootstrap JS -->
<script src="js/bootstrap.bundle.min.js"></script>
</body>
</html>
