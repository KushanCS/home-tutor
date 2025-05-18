<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="course.model.Course" %>

<%
    // Retrieve course details and enrollment status from request attributes
    Course course = (Course) request.getAttribute("course");
    Boolean isEnrolled = (Boolean) request.getAttribute("isEnrolled");
    Boolean isPaid = (Boolean) request.getAttribute("isPaid");
    String username = (String) session.getAttribute("username");

    // Redirect if course details are not available
    if (course == null) {
        response.sendRedirect("student-course.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= course.getName() %> - MetaTutor</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* CSS variables for consistent theming */
        :root {
            --primary-color: #5624d0;       /* Main brand color */
            --secondary-color: #f7f9fa;     /* Light background color */
            --accent-color: #a435f0;        /* Secondary accent color */
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

        /* Course header styling */
        .course-header {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        /* Course image styling */
        .course-image {
            height: 300px;
            object-fit: cover;
            border-radius: 8px;
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

        /* Module card with hover effect */
        .module-card {
            transition: transform 0.3s;
            border: none;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .module-card:hover {
            transform: translateY(-5px);
        }

        /* Rating stars styling */
        .rating-stars {
            display: inline-block;
            font-size: 1.5rem;
            cursor: pointer;
        }

        /* Star button styling */
        .star-btn {
            background: none;
            border: none;
            padding: 0 2px;
            color: #ffc107; /* Gold color for stars */
        }

        .star-btn:hover {
            transform: scale(1.2);
        }

        /* Alert notification styling with animation */
        .alert-rating {
            position: fixed;
            top: 80px; /* Position below navbar */
            left: 50%;
            transform: translateX(-50%);
            z-index: 1000;
            animation: fadeInOut 3s ease-in-out;
            opacity: 0;
            min-width: 300px;
            text-align: center;
        }

        /* Keyframes for alert animation */
        @keyframes fadeInOut {
            0% { opacity: 0; transform: translateX(-50%) translateY(-20px); }
            10% { opacity: 1; transform: translateX(-50%) translateY(0); }
            90% { opacity: 1; transform: translateX(-50%) translateY(0); }
            100% { opacity: 0; transform: translateX(-50%) translateY(-20px); }
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
                    <a class="nav-link" href="course-home.jsp">Courses</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="MyCoursesServlet"><i class="fas fa-book-open me-1"></i> My Courses</a>
                </li>
            </ul>

            <!-- User actions -->
            <div>
                <a href="student.jsp" class="btn btn-primary me-2">Dashboard</a>
                <a href="logout.jsp" class="btn btn-outline-primary">Log out</a>
            </div>
        </div>
    </div>
</nav>

<!-- Rating Alert Messages -->
<% if (request.getParameter("rated") != null) {
    String message = "";
    if ("true".equals(request.getParameter("rated"))) {
        message = "Thank you for your rating!";
    } else if ("updated".equals(request.getParameter("rated"))) {
        message = "Your rating has been updated!";
    } else if ("deleted".equals(request.getParameter("rated"))) {
        message = "Your rating has been deleted!";
    }
%>
<div class="alert alert-success alert-rating" role="alert">
    <i class="fas fa-check-circle me-2"></i><%= message %>
</div>
<% } else if (request.getParameter("error") != null) {
    String error = request.getParameter("error");
    String message = "";
    if (error.equals("invalid_rating")) {
        message = "Please select a valid rating (1-5 stars)";
    } else if (error.equals("already_rated")) {
        message = "You have already rated this course";
    }
%>
<div class="alert alert-danger alert-rating" role="alert">
    <i class="fas fa-exclamation-circle me-2"></i><%= message %>
</div>
<% } %>

<!-- Main Course Content -->
<div class="container py-5">
    <!-- Course Header Section -->
    <div class="course-header p-4 mb-4">
        <div class="row">
            <!-- Course Details -->
            <div class="col-md-8">
                <h1 class="fw-bold mb-3"><%= course.getName() %></h1>
                <p class="lead"><%= course.getDescription() %></p>

                <!-- Course Metadata -->
                <div class="d-flex align-items-center mb-3">
                    <span class="badge bg-primary me-2"><%= course.getLevel() %></span>
                    <span class="text-muted me-3"><i class="fas fa-chalkboard-teacher me-1"></i><%= course.getTutorName() %></span>
                    <span class="text-muted"><i class="fas fa-clock me-1"></i><%= course.getDuration() %></span>
                </div>

                <!-- Course Price -->
                <h4 class="text-primary mb-4">$<%= course.getPrice() %></h4>

                <!-- Enrollment Buttons (Conditional based on enrollment status) -->
                <% if (isEnrolled) { %>
                <% if (isPaid) { %>
                <!-- Start Learning button for paid enrollment -->
                <a href="#" class="btn btn-success me-2">
                    <i class="fas fa-play-circle me-1"></i>Start Learning
                </a>
                <% } else { %>
                <!-- Mark as Paid button for unpaid enrollment -->
                <form action="ChoosePaymentMethod.jsp" method="post" class="d-inline">
                    <input type="hidden" name="courseId" value="<%= course.getCourseId() %>">
                    <button type="submit" class="btn btn-primary me-2">
                        <i class="fas fa-check-circle me-1"></i>Mark as Paid
                    </button>
                </form>
                <% } %>
                <!-- Remove Course button -->
                <form action="RemoveEnrollmentServlet" method="post" class="d-inline">
                    <input type="hidden" name="courseId" value="<%= course.getCourseId() %>">
                    <button type="submit" class="btn btn-outline-danger">
                        <i class="fas fa-trash-alt me-1"></i>Remove Course
                    </button>
                </form>
                <% } else { %>
                <!-- Enroll Now button for non-enrolled users -->
                <form action="EnrollServlet" method="post" class="d-inline">
                    <input type="hidden" name="courseId" value="<%= course.getCourseId() %>">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-plus-circle me-1"></i>Enroll Now
                    </button>
                </form>
                <% } %>
            </div>

            <!-- Course Image -->
            <div class="col-md-4">
                <img src="images/<%= course.getImage() %>" alt="<%= course.getName() %>" class="img-fluid course-image">
            </div>
        </div>
    </div>

    <!-- Course Content Sections -->
    <div class="row">
        <!-- Main Course Content (Left Column) -->
        <div class="col-lg-8">
            <!-- About This Course Section -->
            <div class="card mb-4">
                <div class="card-body">
                    <h3 class="card-title fw-bold mb-4">About This Course</h3>
                    <p><%= course.getDescription() %></p>

                    <!-- Learning Outcomes -->
                    <h4 class="fw-bold mt-4 mb-3">What You'll Learn</h4>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item border-0 ps-0"><i class="fas fa-check text-primary me-2"></i>Master key concepts in <%= course.getTutorSubject() %></li>
                        <li class="list-group-item border-0 ps-0"><i class="fas fa-check text-primary me-2"></i>Hands-on projects and exercises</li>
                        <li class="list-group-item border-0 ps-0"><i class="fas fa-check text-primary me-2"></i>Expert guidance from <%= course.getTutorName() %></li>
                    </ul>
                </div>
            </div>

            <!-- Course Modules Section -->
            <h3 class="fw-bold mb-4">Course Content</h3>
            <div class="accordion mb-5" id="courseModules">
                <!-- Module 1 -->
                <div class="accordion-item module-card">
                    <h2 class="accordion-header" id="headingOne">
                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne">
                            Module 1: Introduction to <%= course.getTutorSubject() %>
                        </button>
                    </h2>
                    <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne">
                        <div class="accordion-body">
                            <ul class="list-unstyled">
                                <li class="mb-2"><i class="fas fa-play-circle text-primary me-2"></i>Welcome to the Course</li>
                                <li class="mb-2"><i class="fas fa-play-circle text-primary me-2"></i>Course Overview</li>
                                <li class="mb-2"><i class="fas fa-play-circle text-primary me-2"></i>Setting Up Your Environment</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Module 2 -->
                <div class="accordion-item module-card">
                    <h2 class="accordion-header" id="headingTwo">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo">
                            Module 2: Core Concepts
                        </button>
                    </h2>
                    <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo">
                        <div class="accordion-body">
                            <ul class="list-unstyled">
                                <li class="mb-2"><i class="fas fa-play-circle text-primary me-2"></i>Understanding the Fundamentals</li>
                                <li class="mb-2"><i class="fas fa-play-circle text-primary me-2"></i>Practical Examples</li>
                                <li class="mb-2"><i class="fas fa-play-circle text-primary me-2"></i>Exercises and Quizzes</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Course Sidebar (Right Column) -->
        <div class="col-lg-4">
            <!-- Course Details Card -->
            <div class="card mb-4">
                <div class="card-body">
                    <h4 class="fw-bold mb-3">Course Details</h4>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item border-0 ps-0 d-flex justify-content-between">
                            <span><i class="fas fa-user-tie text-primary me-2"></i>Instructor</span>
                            <span><%= course.getTutorName() %></span>
                        </li>
                        <li class="list-group-item border-0 ps-0 d-flex justify-content-between">
                            <span><i class="fas fa-book text-primary me-2"></i>Subject</span>
                            <span><%= course.getTutorSubject() %></span>
                        </li>
                        <li class="list-group-item border-0 ps-0 d-flex justify-content-between">
                            <span><i class="fas fa-signal text-primary me-2"></i>Level</span>
                            <span><%= course.getLevel() %></span>
                        </li>
                        <li class="list-group-item border-0 ps-0 d-flex justify-content-between">
                            <span><i class="fas fa-clock text-primary me-2"></i>Duration</span>
                            <span><%= course.getDuration() %></span>
                        </li>
                        <li class="list-group-item border-0 ps-0 d-flex justify-content-between">
                            <span><i class="fas fa-money-bill-wave text-primary me-2"></i>Price</span>
                            <span>$<%= course.getPrice() %></span>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Progress Section (Visible only if enrolled) -->
            <% if (isEnrolled) { %>
            <div class="card">
                <div class="card-body text-center">
                    <h5 class="card-title mb-3">Your Progress</h5>
                    <div class="progress mb-3" style="height: 20px;">
                        <div class="progress-bar bg-primary" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">25%</div>
                    </div>
                    <p class="text-muted">You've completed 2 of 8 lessons</p>
                    <% if (isPaid) { %>
                    <a href="#" class="btn btn-primary w-100">
                        <i class="fas fa-play-circle me-1"></i>Continue Learning
                    </a>
                    <% } %>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</div>

<!-- Footer Section -->
<footer class="bg-dark text-white py-4">
    <div class="container">
        <div class="row">
            <!-- Company Info -->
            <div class="col-md-6">
                <h5 class="mb-3">MetaTutor</h5>
                <p>Your online learning platform for quality education across various subjects.</p>
            </div>

            <!-- Quick Links -->
            <div class="col-md-3">
                <h5 class="mb-3">Quick Links</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="course-home.jsp" class="footer-link">Courses</a></li>
                    <li class="mb-2"><a href="#" class="footer-link">About Us</a></li>
                    <li class="mb-2"><a href="#" class="footer-link">Contact</a></li>
                </ul>
            </div>

            <!-- Social Links -->
            <div class="col-md-3">
                <h5 class="mb-3">Connect</h5>
                <a href="#" class="footer-link me-2"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="footer-link me-2"><i class="fab fa-twitter"></i></a>
                <a href="#" class="footer-link me-2"><i class="fab fa-instagram"></i></a>
                <a href="#" class="footer-link"><i class="fab fa-linkedin-in"></i></a>
            </div>
        </div>

        <!-- Copyright Notice -->
        <hr class="my-4 bg-secondary">
        <div class="text-center">
            <p class="small mb-0">&copy; 2023 MetaTutor. All rights reserved.</p>
        </div>
    </div>
</footer>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Initialize when DOM is fully loaded
    document.addEventListener('DOMContentLoaded', function() {
        // Star rating selection functionality
        const stars = document.querySelectorAll('.star-btn');
        const starsInput = document.getElementById('stars-input');

        if (stars && starsInput) {
            stars.forEach(star => {
                star.addEventListener('click', () => {
                    const value = parseInt(star.getAttribute('data-value'));
                    starsInput.value = value;

                    // Update star display
                    stars.forEach((s, i) => {
                        const icon = s.querySelector('i');
                        if (i < value) {
                            icon.classList.remove('far'); // Empty star
                            icon.classList.add('fas');    // Filled star
                        } else {
                            icon.classList.remove('fas');
                            icon.classList.add('far');
                        }
                    });
                });
            });
        }

        // Auto-hide alerts after 3 seconds
        setTimeout(() => {
            const alerts = document.querySelectorAll('.alert-rating');
            alerts.forEach(alert => {
                if (alert) alert.remove();
            });
        }, 3000);
    });
</script>
</body>
</html>