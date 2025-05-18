<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, course.model.Course, course.utils.CourseFileUtil" %>

<%
    // Get the real path to the courses data file
    String filePath = application.getRealPath("/WEB-INF/courses.txt");
    // Load all courses from the file
    List<Course> courses = CourseFileUtil.getAllCourses(filePath);

    // Get search parameter from request and user role from session
    String search = request.getParameter("search");
    String role = (String) session.getAttribute("role");
    String user = (String) session.getAttribute("username");

    // Filter courses based on search term (tutor subject)
    if (search != null && !search.trim().isEmpty()) {
        search = search.toLowerCase();
        Iterator<Course> iterator = courses.iterator();
        while (iterator.hasNext()) {
            Course course = iterator.next();
            if (course.getTutorSubject() == null || !course.getTutorSubject().toLowerCase().contains(search)) {
                iterator.remove();
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Courses - MetaTutor</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* CSS variables for consistent theming */
        :root {
            --primary-color: #5624d0;       /* Main brand purple */
            --secondary-color: #f7f9fa;     /* Light background */
            --accent-color: #a435f0;        /* Secondary purple */
        }

        /* Base body styling */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--secondary-color);
        }

        /* Navbar styling with subtle shadow */
        .navbar {
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        /* Nav link styling */
        .nav-link {
            font-weight: 500;
        }

        /* Primary button styling */
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        /* Outline button styling */
        .btn-outline-primary {
            color: var(--primary-color);
            border-color: var(--primary-color);
        }

        /* Outline button hover state */
        .btn-outline-primary:hover {
            background-color: var(--primary-color);
            color: white;
        }

        /* Course card styling with hover effect */
        .course-card {
            transition: transform 0.3s;
            border: none;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            height: 100%;
        }

        .course-card:hover {
            transform: translateY(-5px);
        }

        /* Course image styling */
        .course-img {
            height: 200px;
            object-fit: cover;
        }

        /* Page header styling */
        .page-header {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 2px solid #eee;
        }

        /* Search container styling */
        .search-container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        /* Tutor info styling */
        .tutor-info {
            font-weight: 500;
            margin-bottom: 5px;
        }

        /* Tutor subject styling */
        .tutor-subject {
            color: var(--accent-color);
            font-size: 0.9em;
        }

        /* Rating stars styling */
        .rating-stars {
            font-size: 0.9rem;
            margin-bottom: 5px;
        }

        /* Rating indicator styling */
        .rating-indicator {
            font-size: 0.9rem;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            background-color: rgba(255, 193, 7, 0.1);
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top">
    <div class="container">
        <!-- Brand logo with icon -->
        <a class="navbar-brand fw-bold" href="home-page.jsp" style="color: var(--primary-color);">
            <i class="fas fa-graduation-cap me-2"></i>MetaTutor
        </a>

        <!-- Mobile menu toggle -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navigation links -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="course-home.jsp">Courses</a>
                </li>

                <!-- Show "My Courses" only for logged-in students -->
                <% if (user != null && "student".equals(role)) { %>
                <li class="nav-item">
                    <a class="nav-link" href="MyCoursesServlet"><i class="fas fa-book me-1"></i> My Courses</a>
                </li>
                <% } %>

                <!-- Show "Become a Tutor" only for guests -->
                <% if (user == null) { %>
                <li class="nav-item">
                    <a class="nav-link" href="become_tutor.jsp">Become a Tutor</a>
                </li>
                <% } %>
            </ul>

            <!-- User actions based on login status -->
            <% if (user == null) { %>
            <!-- Show login/signup for guests -->
            <div class="d-flex">
                <a href="loginOptions.jsp" class="btn btn-outline-primary me-2">Log in</a>
                <a href="register.jsp" class="btn btn-primary">Sign up</a>
            </div>
            <% } else { %>
            <!-- Show profile/logout for logged in users -->
            <div>
                <% if ("student".equals(role)) { %>
                <a href="profile.jsp" class="btn btn-primary">Profile</a>
                <% } else if ("tutor".equals(role)) { %>
                <a href="tutor_dashboard.jsp" class="btn btn-primary">Profile</a>
                <% } %>
                <a href="logout.jsp" class="btn btn-outline-primary ms-2">Log out</a>
            </div>
            <% } %>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container py-5">
    <!-- Page Header -->
    <h2 class="page-header"><i class="fas fa-book-open me-2"></i>Available Courses</h2>

    <!-- Search Section -->
    <div class="search-container">
        <form method="get" class="row g-3 align-items-center">
            <div class="col-md-9">
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-search"></i></span>
                    <input type="text" name="search" class="form-control form-control-lg"
                           placeholder="Search by subject..." value="<%= search != null ? search : "" %>">
                </div>
            </div>
            <div class="col-md-3">
                <button type="submit" class="btn btn-primary w-100">Search</button>
            </div>
        </form>
    </div>

    <!-- Courses Grid -->
    <% if (courses == null || courses.isEmpty()) { %>
    <!-- No courses found message -->
    <div class="alert alert-info text-center py-4">
        <i class="fas fa-info-circle fa-2x mb-3"></i>
        <h4>No courses found</h4>
        <p class="mb-0">We couldn't find any courses matching your search.</p>
    </div>
    <% } else { %>
    <div class="row">
        <% for (Course course : courses) { %>
        <div class="col-lg-4 col-md-6 mb-4">
            <!-- Course Card -->
            <div class="card course-card h-100">
                <!-- Course Image -->
                <img src="image/<%= course.getImage() %>" alt="Course Image" class="img-fluid" style="height: 200px; width: 100%; object-fit: cover;">

                <!-- Course Body -->
                <div class="card-body">
                    <h5 class="card-title"><%= course.getName() %></h5>
                    <p class="card-text text-muted"><%= course.getDescription() %></p>

                    <!-- Tutor Information -->
                    <div class="tutor-info">
                        <i class="fas fa-user-tie me-1"></i><%= course.getTutorName() %>
                        <span class="tutor-subject">(<%= course.getTutorSubject() %>)</span>
                    </div>

                    <!-- Course Details -->
                    <ul class="list-group list-group-flush mb-3">
                        <li class="list-group-item"><strong><i class="fas fa-chart-line me-2"></i>Level:</strong> <%= course.getLevel() %></li>
                        <li class="list-group-item"><strong><i class="fas fa-dollar-sign me-2"></i>Price:</strong> $<%= course.getPrice() %></li>
                        <li class="list-group-item"><strong><i class="fas fa-clock me-2"></i>Duration:</strong> <%= course.getDuration() %> weeks</li>
                    </ul>
                </div>

                <!-- Course Footer with Action Button -->
                <div class="card-footer bg-white border-top-0">
                    <% if (user != null ) { %>
                    <% if ("student".equals(role)) { %>
                    <!-- Enroll button for students -->
                    <form action="EnrollServlet" method="post">
                        <input type="hidden" name="courseId" value="<%= course.getCourseId() %>">
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="fas fa-plus-circle me-1"></i> Enroll Now
                        </button>
                    </form>
                    <% } %>
                    <% } else { %>
                    <!-- Login prompt for guests -->
                    <a href="loginOptions.jsp" class="btn btn-primary w-100">
                        <i class="fas fa-sign-in-alt me-1"></i> Login to Enroll
                    </a>
                    <% } %>
                </div>
            </div>
        </div>
        <% } %>
    </div>
    <% } %>
</div>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>