<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="course.model.Course" %>
<%@ page import="course.utils.CourseFileUtil" %>
<%@ page import="tutor.model.Tutor" %>
<%
    Tutor tutor = (Tutor) session.getAttribute("tutor");
    if (tutor == null) {
        response.sendRedirect("loginTutor.jsp");
        return;
    }
    String tutorId = tutor.getTutorId();
    String courseFilePath = application.getRealPath("/WEB-INF/courses.txt");
    List<Course> courses = CourseFileUtil.getCoursesByTutor(tutorId, courseFilePath);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Courses - MetaTutor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #5624d0;
            --secondary-color: #f7f9fa;
            --accent-color: #a435f0;
            --sidebar-color: #1c1d1f;
        }

        body {
            background-color: var(--secondary-color);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-top: 0;
        }

        .navbar {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        .navbar-brand {
            font-weight: 700;
            color: var(--primary-color) !important;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-primary:hover {
            background-color: #4a1fb3;
            border-color: #4a1fb3;
        }

        .btn-outline-primary {
            color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-outline-primary:hover {
            background-color: var(--primary-color);
            color: white;
        }

        .course-container {
            max-width: 1200px;
            margin: 30px auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .page-title {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #eee;
        }

        .action-buttons {
            margin-bottom: 20px;
        }

        .table th {
            background-color: var(--primary-color);
            color: white;
        }

        .badge-subject {
            background-color: var(--accent-color);
            font-size: 0.85em;
            font-weight: 500;
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light sticky-top">
    <div class="container">
        <a class="navbar-brand" href="home-page.jsp">
            <i class="fas fa-graduation-cap me-2"></i>MetaTutor
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <div class="ms-auto d-flex align-items-center">
                <a href="tutor_dashboard.jsp" class="btn btn-outline-secondary me-2">
                    <i class="fas fa-arrow-left me-1"></i> Back to Dashboard
                </a>
                <a href="logoutTutor.jsp" class="btn btn-outline-danger">
                    <i class="fas fa-sign-out-alt me-1"></i> Logout
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- Course Content -->
<div class="course-container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="page-title"><i class="fas fa-book me-2"></i>My Courses</h2>
        <a href="add_course.jsp" class="btn btn-primary">
            <i class="fas fa-plus me-1"></i> Add Course
        </a>
    </div>

    <% if (courses.isEmpty()) { %>
    <div class="alert alert-info text-center">
        <i class="fas fa-info-circle me-2"></i>No courses found. Would you like to add one?
        <a href="add_course.jsp" class="btn btn-sm btn-primary ms-2">
            <i class="fas fa-plus me-1"></i> Add Course
        </a>
    </div>
    <% } else { %>
    <div class="table-responsive">
        <table class="table table-hover align-middle">
            <thead>
            <tr>
                <th>Image</th>
                <th>Name</th>
                <th>Description</th>
                <th>Level</th>
                <th>Price</th>
                <th>Duration</th>
                <th>Subject</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for (Course c : courses) { %>
            <tr>
                <td><img src="images/<%= c.getImage() %>" alt="Course" style="width: 100px; height: 60px; object-fit: cover;"></td>
                <td><%= c.getName() %></td>
                <td><%= c.getDescription() %></td>
                <td><%= c.getLevel() %></td>
                <td>$<%= c.getPrice() %></td>
                <td><%= c.getDuration() %></td>
                <td><span class="badge badge-subject"><%= c.getTutorSubject() %></span></td>
                <td>
                    <div class="d-flex gap-2">
                        <a href="edit_course.jsp?id=<%= c.getCourseId() %>" class="btn btn-sm btn-warning">
                            <i class="fas fa-edit"></i> Edit
                        </a>
                        <a href="DeleteCourseServlet?id=<%= c.getCourseId() %>" class="btn btn-sm btn-danger">
                            <i class="fas fa-trash-alt"></i> Delete
                        </a>
                    </div>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
    <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>