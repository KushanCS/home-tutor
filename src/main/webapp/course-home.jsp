<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="course.utils.CourseFileUtil" %>
<%@ page import="course.model.Course" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MetaTutor - All Courses</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            color: #2d3748;
        }
        .navbar-brand {
            color: #6c63ff !important;
            font-weight: bold;
        }
        .course-card {
            margin-bottom: 1.5rem;
            border: none;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: transform .2s;
        }
        .course-card:hover {
            transform: translateY(-3px);
        }
        .course-card img {
            height: 180px;
            object-fit: cover;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="home-page.jsp">
            <i class="fas fa-graduation-cap me-2"></i>MetaTutor
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="student-course.jsp">My Courses</a>
                </li>
            </ul>
            <div class="d-flex">
                <%
                    String user = (String) session.getAttribute("username");
                    if (user == null) {
                %>
                <a href="login.jsp" class="btn btn-outline-primary me-2">Log in</a>
                <a href="register.jsp" class="btn btn-primary">Sign up</a>
                <%
                } else {
                %>
                <a href="student.jsp" class="btn btn-outline-primary me-2">Dashboard</a>
                <a href="logout.jsp" class="btn btn-outline-primary">Log out</a>
                <% } %>
            </div>
        </div>
    </div>
</nav>

<!-- Course List -->
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h3 mb-0">All Courses</h1>
    </div>
    <div class="row">
        <%
            String filePath = application.getRealPath("/WEB-INF/courses.txt");
            List<Course> courses = CourseFileUtil.readCoursesFromFile(filePath);
            for (Course course : courses) {
        %>
        <div class="col-md-4">
            <div class="card course-card h-100">
                <img src="https://via.placeholder.com/400x180" class="card-img-top" alt="Course image">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title"><%= course.getName() %></h5>
                    <p class="card-text small text-muted mb-2"><%= course.getDescription() %></p>
                    <p class="mt-auto mb-2">
                        <strong>Tutor:</strong> <%= course.getTutor() %><br>
                        <strong>Price:</strong> $<%= String.format("%.2f", course.getPrice()) %><br>
                        <strong>Duration:</strong> <%= course.getDuration() %>
                    </p>
                    <a href="enroll.jsp?name=<%= course.getName() %>" class="btn btn-sm btn-outline-primary">Enroll</a>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
