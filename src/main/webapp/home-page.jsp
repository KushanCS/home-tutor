<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="course.model.Course" %>
<%@ page import="course.utils.CourseFileUtil" %>
<%
    String courseFilePath = application.getRealPath("/WEB-INF/courses.txt");
    List<Course> courses = CourseFileUtil.readCoursesFromFile(courseFilePath);
    String user = (String) session.getAttribute("username");

    // Filter courses based on search query
    String query = request.getParameter("search");
    if (query != null && !query.trim().isEmpty()) {
        query = query.toLowerCase();
        Iterator<Course> iterator = courses.iterator();
        while (iterator.hasNext()) {
            Course course = iterator.next();
            if (!course.getName().toLowerCase().contains(query) &&
                    !course.getDescription().toLowerCase().contains(query) &&
                    !course.getTutor().toLowerCase().contains(query)) {
                iterator.remove();
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MetaTutor - Online Learning Platform</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #5624d0;
            --secondary-color: #f7f9fa;
            --accent-color: #a435f0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .navbar {
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .nav-link {
            font-weight: 500;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-outline-primary {
            color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-outline-primary:hover {
            background-color: var(--primary-color);
        }

        .hero-section {
            background-color: var(--secondary-color);
            padding: 80px 0;
        }

        .course-card {
            transition: transform 0.3s;
            border: none;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .course-card:hover {
            transform: translateY(-5px);
        }

        .course-img {
            height: 180px;
            object-fit: cover;
        }

        footer {
            background-color: #1c1d1f;
            color: white;
            padding: 40px 0;
        }

        .footer-link {
            color: #cec0fc;
            text-decoration: none;
        }

        .footer-link:hover {
            color: white;
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
            <ul class="navbar-nav me-auto">
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
                <div class="dropdown">
                    <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle"
                       id="profileDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        <span class="d-none d-sm-inline"><%= user %></span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
                        <li><a class="dropdown-item" href="profile.jsp"><i class="fas fa-user me-2"></i>Profile</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="logout.jsp"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                    </ul>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero-section">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6">
                <h1 class="display-4 fw-bold mb-4">Learn on your schedule</h1>
                <p class="lead mb-4">Study any topic, anytime. Choose from thousands of expert-led courses now.</p>
                <form method="get" action="home-page.jsp" class="input-group mb-3">
                    <input type="text" name="search" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>"
                           class="form-control form-control-lg" placeholder="Search for courses...">
                    <button class="btn btn-primary" type="submit">Search</button>
                </form>
            </div>
            <div class="col-lg-6 d-none d-lg-block">
                <img src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=80"
                     alt="Learning together" class="img-fluid rounded">
            </div>
        </div>
    </div>
</section>
<!-- Courses Section -->
<section id="courses" class="py-5">
    <div class="container">
        <h2 class="fw-bold mb-5">Available Courses</h2>
        <div class="row">
            <% if (courses != null && !courses.isEmpty()) {
                for (Course course : courses) {
            %>
            <div class="col-md-4">
                <div class="card course-card h-100">
                    <!-- Icon instead of image -->
                    <div>
                        <img src="uploads/course_banner.png" class="card-img-top" alt="Course Image">
                    </div>
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title text-center"><%= course.getName() %></h5>
                        <p class="text-muted mb-1"><strong>Instructor:</strong> <%= course.getTutor() %></p>
                        <p class="card-text small mb-2"><%= course.getDescription() %></p>
                        <p class="mt-auto">
                            <strong>Price:</strong> $<%= course.getPrice() %><br>
                            <strong>Duration:</strong> <%= course.getDuration() %>
                        </p>
                        <a href="enroll.jsp?name=<%= course.getName() %>" class="btn btn-outline-primary mt-2 w-100">Enroll</a>
                    </div>
                </div>
            </div>
            <% }} else { %>
            <div class="col-12">
                <div class="alert alert-info text-center">No courses found for your search.</div>
            </div>
            <% } %>
        </div>
    </div>
</section>


<!-- Footer -->
<footer>
    <div class="container">
        <div class="row">
            <div class="col-md-4 mb-4">
                <h5 class="mb-3">MetaTutor</h5>
                <p>MetaTutor is a leading online learning platform, offering expert-led courses to help you grow your skills.</p>
            </div>
            <div class="col-md-2 mb-4">
                <h5 class="mb-3">Company</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="#" class="footer-link">About</a></li>
                    <li class="mb-2"><a href="#" class="footer-link">Careers</a></li>
                    <li class="mb-2"><a href="#" class="footer-link">Blog</a></li>
                </ul>
            </div>
            <div class="col-md-2 mb-4">
                <h5 class="mb-3">Support</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="#" class="footer-link">Help Center</a></li>
                    <li class="mb-2"><a href="#" class="footer-link">Contact Us</a></li>
                    <li class="mb-2"><a href="#" class="footer-link">FAQ</a></li>
                </ul>
            </div>
            <div class="col-md-4 mb-4">
                <h5 class="mb-3">Connect With Us</h5>
                <a href="#" class="footer-link me-3"><i class="fab fa-facebook-f fa-lg"></i></a>
                <a href="#" class="footer-link me-3"><i class="fab fa-twitter fa-lg"></i></a>
                <a href="#" class="footer-link me-3"><i class="fab fa-instagram fa-lg"></i></a>
                <a href="#" class="footer-link"><i class="fab fa-linkedin-in fa-lg"></i></a>
            </div>
        </div>
        <hr class="my-4" style="border-color: #3e4143;">
        <div class="row">
            <div class="col-md-6">
                <p class="small">&copy; 2025 MetaTutor. All rights reserved.</p>
            </div>
            <div class="col-md-6 text-md-end">
                <a href="#" class="footer-link small me-3">Terms</a>
                <a href="#" class="footer-link small me-3">Privacy</a>
                <a href="#" class="footer-link small">Cookie Policy</a>
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
