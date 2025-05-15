<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="course.utils.CourseFileUtil" %>
<%@ page import="course.model.Course" %>
<%@ page import="java.util.List" %>
<%
    String filePath = application.getRealPath("/WEB-INF/courses.txt");
    List<Course> courses = CourseFileUtil.readCoursesFromFile(filePath);
    String user = (String) session.getAttribute("username");
%>
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
            width: 100%;
            object-fit: cover;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="home-page.jsp" style="color: var(--primary-color);">
            <i class="fas fa-graduation-cap me-2"></i>MetaTutor
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="course-home.jsp">Courses</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="MyCoursesServlet">My Courses</a>
                </li>
            </ul>
            <% if (user == null) { %>
            <div class="d-flex">
                <a href="login.jsp" class="btn btn-outline-primary me-2">Log in</a>
                <a href="register.jsp" class="btn btn-primary">Sign up</a>
            </div>
            <% } else { %>
            <div class="d-flex align-items-center">
                <a href="student.jsp" class="btn btn-primary me-2">Dashboard</a>
                <a href="logout.jsp" class="btn btn-outline-primary">Log out</a>
            </div>
            <% } %>
        </div>
    </div>
</nav>

<!-- Course List -->
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h3 mb-0">All Courses</h1>
    </div>
    <div class="row">
        <% for (Course course : courses) { %>
        <div class="col-md-4">
            <div class="card course-card h-100">
                <!-- Replace placeholder with actual image -->
                <img src="uploads/course_banner.png" class="card-img-top" alt="Course Image">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title"><%= course.getName() %></h5>
                    <p class="card-text small text-muted mb-2"><%= course.getDescription() %></p>
                    <p class="mt-auto mb-2">
                        <strong>Tutor:</strong> <%= course.getTutor() %><br>
                        <strong>Price:</strong> $<%= String.format("%.2f", course.getPrice()) %><br>
                        <strong>Duration:</strong> <%= course.getDuration() %>
                    </p>
                    <a href="enroll.jsp?name=<%= course.getName() %>" class="btn btn-sm btn-outline-primary mt-2">Enroll</a>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
