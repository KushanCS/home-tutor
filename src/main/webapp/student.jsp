<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="student.model.Student" %>
<%@ page session="true" %>
<%
    // Check for logged-in student
    Student student = (Student) session.getAttribute("student");
    if (student == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Portal - Home Tutor System</title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">

    <!-- Custom Styles -->
    <style>
        :root {
            --primary-color: #5624d0;
            --secondary-color: #4d44db;
            --accent-color: #ff6584;
            --light-bg: #f8f9fa;
            --dark-text: #2d3748;
        }

        body {
            background-color: var(--light-bg);
            color: var(--dark-text);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .navbar {
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            font-weight: 700;
            color: var(--primary-color) !important;
        }

        .nav-link {
            font-weight: 500;
        }

        .nav-link:hover {
            color: var(--primary-color) !important;
        }

        .welcome-box {
            border-left: 5px solid var(--primary-color);
            background-color: #fff;
            padding: 2rem;
            box-shadow: 0 2px 15px rgba(0,0,0,0.05);
            border-radius: 8px;
            margin-top: 2rem;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-primary:hover {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
        }

        footer {
            background-color: #2d3748;
            color: white;
            padding: 2rem 0;
            margin-top: 3rem;
        }

        .social-icons a {
            font-size: 1.2rem;
            margin-right: 15px;
        }

        .footer a {
            color: white;
            text-decoration: none;
        }

        .footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold" href="home-page.jsp">
            <i class="bi bi-mortarboard-fill me-2"></i>Meta Tutor
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navigation Links -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="home-page.jsp"><i class="bi bi-house-door me-1"></i> Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="MyCoursesServlet"><i class="bi bi-collection-play me-1"></i> My Courses</a>
                </li>
            </ul>

            <!-- Profile Dropdown -->
            <div class="d-flex align-items-center">
                <div class="dropdown">
                    <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle"
                       id="profileDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        <span class="d-none d-sm-inline"><%= student.getUserName() %></span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
                        <li><a class="dropdown-item" href="profile.jsp"><i class="bi bi-person me-2"></i>Profile</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="logout.jsp"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>

<!-- Welcome Box -->
<div class="container py-4">
    <div class="welcome-box">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h2 class="fw-bold mb-2">Welcome back, <%= student.getUserName() %></h2>
            </div>
            <a href="course_home.jsp">
                <button class="btn btn-primary">
                    <i class="bi bi-plus-lg me-1"></i> New Session
                </button>
            </a>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <div class="container">
        <div class="row">
            <!-- About -->
            <div class="col-md-4 mb-4 mb-md-0">
                <h5 class="fw-bold mb-3">Meta Tutor</h5>
                <p>Personalized home tutoring for students of all ages and skill levels.</p>
                <div class="social-icons">
                    <a href="#"><i class="bi bi-facebook"></i></a>
                    <a href="#"><i class="bi bi-twitter"></i></a>
                    <a href="#"><i class="bi bi-instagram"></i></a>
                    <a href="#"><i class="bi bi-linkedin"></i></a>
                </div>
            </div>

            <!-- Quick Links -->
            <div class="col-md-2 mb-4 mb-md-0">
                <h5 class="fw-bold mb-3">Quick Links</h5>
                <ul class="list-unstyled">
                    <li><a href="home-page.jsp">Home</a></li>
                    <li><a href="#">Courses</a></li>
                    <li><a href="#">Tutors</a></li>
                    <li><a href="#">Pricing</a></li>
                </ul>
            </div>

            <!-- Support -->
            <div class="col-md-2 mb-4 mb-md-0">
                <h5 class="fw-bold mb-3">Support</h5>
                <ul class="list-unstyled">
                    <li><a href="#">Help Center</a></li>
                    <li><a href="#">Contact Us</a></li>
                    <li><a href="#">FAQs</a></li>
                </ul>
            </div>

            <!-- Newsletter -->
            <div class="col-md-4">
                <h5 class="fw-bold mb-3">Newsletter</h5>
                <p>Subscribe to get updates on new courses and offers.</p>
                <div class="input-group mb-3">
                    <input type="email" class="form-control" placeholder="Your email">
                    <button class="btn btn-primary" type="button">Subscribe</button>
                </div>
            </div>
        </div>

        <!-- Bottom Footer -->
        <hr class="my-4 bg-light">
        <div class="row">
            <div class="col-md-6 text-center text-md-start">
                <p class="mb-0">&copy; 2023 Meta Tutor. All rights reserved.</p>
            </div>
            <div class="col-md-6 text-center text-md-end">
                <a href="#" class="text-white text-decoration-none me-3">Privacy Policy</a>
                <a href="#" class="text-white text-decoration-none">Terms of Service</a>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
