<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="course.model.Course" %>
<%
    Course course = (Course) request.getAttribute("course");
    Boolean isEnrolled = (Boolean) request.getAttribute("isEnrolled");
    Boolean isPaid = (Boolean) request.getAttribute("isPaid");

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
            background-color: var(--secondary-color);
        }

        .navbar {
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .course-header {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .course-image {
            height: 300px;
            object-fit: cover;
            border-radius: 8px;
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
            color: white;
        }

        .module-card {
            transition: transform 0.3s;
            border: none;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .module-card:hover {
            transform: translateY(-5px);
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top">
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
                    <a class="nav-link" href="MyCoursesServlet"><i class="fas fa-book-open me-1"></i> My Courses</a>
                </li>
            </ul>
            <div>
                <a href="student.jsp" class="btn btn-primary me-2">Dashboard</a>
                <a href="logout.jsp" class="btn btn-outline-primary">Log out</a>
            </div>
        </div>
    </div>
</nav>

<!-- Course Details -->
<div class="container py-5">
    <div class="course-header p-4 mb-4">
        <div class="row">
            <div class="col-md-8">
                <h1 class="fw-bold mb-3"><%= course.getName() %></h1>
                <p class="lead"><%= course.getDescription() %></p>
                <div class="d-flex align-items-center mb-3">
                    <span class="badge bg-primary me-2"><%= course.getLevel() %></span>
                    <span class="text-muted me-3"><i class="fas fa-chalkboard-teacher me-1"></i><%= course.getTutorName() %></span>
                    <span class="text-muted"><i class="fas fa-clock me-1"></i><%= course.getDuration() %></span>
                </div>
                <h4 class="text-primary mb-4">$<%= course.getPrice() %></h4>

                <% if (isEnrolled) { %>
                <% if (isPaid) { %>
                <a href="#" class="btn btn-success me-2">
                    <i class="fas fa-play-circle me-1"></i>Start Learning
                </a>
                <% } else { %>
                <form action="MarkAsPaidServlet" method="post" class="d-inline">
                    <input type="hidden" name="courseId" value="<%= course.getCourseId() %>">
                    <button type="submit" class="btn btn-primary me-2">
                        <i class="fas fa-check-circle me-1"></i>Mark as Paid
                    </button>
                </form>
                <% } %>
                <form action="RemoveEnrollmentServlet" method="post" class="d-inline">
                    <input type="hidden" name="courseId" value="<%= course.getCourseId() %>">
                    <button type="submit" class="btn btn-outline-danger">
                        <i class="fas fa-trash-alt me-1"></i>Remove Course
                    </button>
                </form>
                <% } else { %>
                <form action="EnrollServlet" method="post" class="d-inline">
                    <input type="hidden" name="courseId" value="<%= course.getCourseId() %>">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-plus-circle me-1"></i>Enroll Now
                    </button>
                </form>
                <% } %>
            </div>
            <div class="col-md-4">
                <img src="images/<%= course.getImage() %>" alt="<%= course.getName() %>" class="img-fluid course-image">
            </div>
        </div>
    </div>

    <!-- Course Content -->
    <div class="row">
        <div class="col-lg-8">
            <div class="card mb-4">
                <div class="card-body">
                    <h3 class="card-title fw-bold mb-4">About This Course</h3>
                    <p><%= course.getDescription() %></p>
                    <h4 class="fw-bold mt-4 mb-3">What You'll Learn</h4>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item border-0 ps-0"><i class="fas fa-check text-primary me-2"></i>Master key concepts in <%= course.getTutorSubject() %></li>
                        <li class="list-group-item border-0 ps-0"><i class="fas fa-check text-primary me-2"></i>Hands-on projects and exercises</li>
                        <li class="list-group-item border-0 ps-0"><i class="fas fa-check text-primary me-2"></i>Expert guidance from <%= course.getTutorName() %></li>
                    </ul>
                </div>
            </div>

            <!-- Course Modules - Example Content -->
            <h3 class="fw-bold mb-4">Course Content</h3>
            <div class="accordion mb-5" id="courseModules">
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

        <div class="col-lg-4">
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

<!-- Footer -->
<footer class="bg-dark text-white py-4">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h5 class="mb-3">MetaTutor</h5>
                <p>Your online learning platform for quality education across various subjects.</p>
            </div>
            <div class="col-md-3">
                <h5 class="mb-3">Quick Links</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="course-home.jsp" class="footer-link">Courses</a></li>
                    <li class="mb-2"><a href="#" class="footer-link">About Us</a></li>
                    <li class="mb-2"><a href="#" class="footer-link">Contact</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h5 class="mb-3">Connect</h5>
                <a href="#" class="footer-link me-2"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="footer-link me-2"><i class="fab fa-twitter"></i></a>
                <a href="#" class="footer-link me-2"><i class="fab fa-instagram"></i></a>
                <a href="#" class="footer-link"><i class="fab fa-linkedin-in"></i></a>
            </div>
        </div>
        <hr class="my-4 bg-secondary">
        <div class="text-center">
            <p class="small mb-0">&copy; 2023 MetaTutor. All rights reserved.</p>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>