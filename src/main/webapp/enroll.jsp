<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="course.model.Course" %>
<%@ page import="course.utils.CourseFileUtil" %>

<%
    String courseName = request.getParameter("name");
    String filePath = application.getRealPath("/WEB-INF/courses.txt");
    Course selected = null;
    List<Course> courses = CourseFileUtil.readCoursesFromFile(filePath);
    for (Course c : courses) {
        if (c.getName().equalsIgnoreCase(courseName)) {
            selected = c;
            break;
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Enroll in <%= selected != null ? selected.getName() : "Course" %></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap & Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- Styling -->
    <style>
        :root {
            --primary-color: #6c63ff;
            --secondary-color: #4d44db;
            --light-bg: #f8f9fa;
        }
        body {
            background: var(--light-bg);
            font-family: 'Segoe UI', sans-serif;
        }
        .enrollment-card {
            max-width: 800px;
            margin: 2rem auto;
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .course-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 2rem;
            border-radius: 15px 15px 0 0;
        }
        .course-details {
            padding: 2rem;
            background: white;
            border-radius: 0 0 15px 15px;
        }
        .price-tag {
            font-size: 2rem;
            color: var(--primary-color);
            font-weight: bold;
            margin: 1rem 0;
        }
        .btn-enroll {
            background: var(--primary-color);
            color: white;
            padding: 1rem 2.5rem;
            font-size: 1.1rem;
            border: none;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .btn-enroll:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(108, 99, 255, 0.3);
        }
        .feature-list {
            list-style: none;
            padding: 0;
        }
        .feature-list li {
            margin: 0.5rem 0;
            padding: 0.8rem;
            background: var(--light-bg);
            border-radius: 8px;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="home-page.jsp">
            <i class="fas fa-graduation-cap me-2"></i>MetaTutor
        </a>
    </div>
</nav>

<!-- Page Content -->
<div class="container my-5">
    <% if (selected != null) { %>
    <div class="enrollment-card">
        <div class="course-header text-center">
            <h1 class="mb-3"><%= selected.getName() %></h1>
            <p class="lead"><%= selected.getDescription() %></p>
        </div>

        <div class="course-details">
            <div class="row g-4">
                <div class="col-md-6">
                    <h4 class="mb-4">Course Details</h4>
                    <ul class="feature-list">
                        <li>
                            <i class="fas fa-chalkboard-teacher me-2"></i>
                            <strong>Instructor:</strong> <%= selected.getTutor() %>
                        </li>
                        <li>
                            <i class="fas fa-clock me-2"></i>
                            <strong>Duration:</strong> <%= selected.getDuration() %>
                        </li>
                        <li>
                            <i class="fas fa-certificate me-2"></i>
                            Certificate of Completion
                        </li>
                    </ul>
                </div>

                <div class="col-md-6 text-center">
                    <div class="price-tag">
                        $<%= String.format("%.2f", selected.getPrice()) %>
                    </div>
                    <form method="post" action="enrollCourse" class="mt-4">
                        <input type="hidden" name="name" value="<%= selected.getName() %>">
                        <input type="hidden" name="description" value="<%= selected.getDescription() %>">
                        <input type="hidden" name="tutor" value="<%= selected.getTutor() %>">
                        <input type="hidden" name="price" value="<%= selected.getPrice() %>">
                        <input type="hidden" name="duration" value="<%= selected.getDuration() %>">
                        <button type="submit" class="btn-enroll w-100">
                            <i class="fas fa-lock me-2"></i>Enroll Now
                        </button>
                    </form>
                    <p class="text-muted mt-3 small">
                        <i class="fas fa-shield-alt me-2"></i>Secure payment processing
                    </p>
                </div>
            </div>
        </div>
    </div>
    <% } else { %>
    <div class="alert alert-danger text-center">
        <h4 class="alert-heading">Course Not Found</h4>
        <p>The requested course could not be found.</p>
        <a href="courses.jsp" class="btn btn-outline-primary">Browse Courses</a>
    </div>
    <% } %>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
