<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, course.model.CourseStatus" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<CourseStatus> courses = (List<CourseStatus>) request.getAttribute("courses");
    String search = request.getParameter("search");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Courses - MetaTutor</title>
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
            color: white;
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

        .footer-link {
            color: #cec0fc;
            text-decoration: none;
        }

        .footer-link:hover {
            color: white;
        }

        .badge-paid {
            background-color: #28a745;
        }

        .badge-unpaid {
            background-color: #ffc107;
            color: #212529;
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
                    <a class="nav-link active" href="MyCoursesServlet"><i class="fas fa-book-open me-1"></i> My Courses</a>
                </li>
            </ul>
            <div>
                <a href="student.jsp" class="btn btn-primary me-2">Dashboard</a>
                <a href="logout.jsp" class="btn btn-outline-primary">Log out</a>
            </div>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold" style="color: var(--primary-color);">
            <i class="fas fa-book-open me-2"></i>My Enrolled Courses
        </h2>
        <a href="course-home.jsp" class="btn btn-outline-primary">
            <i class="fas fa-plus me-1"></i>Find More Courses
        </a>
    </div>

    <!-- Search Form -->
    <form method="get" class="mb-4">
        <div class="input-group">
            <input type="text" name="search" class="form-control"
                   placeholder="Search by tutor subject..."
                   value="<%= search != null ? search : "" %>">
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-search me-1"></i>Search
            </button>
        </div>
    </form>

    <% if (courses == null || courses.isEmpty()) { %>
    <div class="card course-card">
        <div class="card-body text-center py-5">
            <i class="fas fa-book-open fa-4x mb-3" style="color: var(--primary-color);"></i>
            <h4 class="mb-3">You haven't enrolled in any courses yet</h4>
            <p class="text-muted mb-4">Browse our courses and start learning today!</p>
            <a href="course-home.jsp" class="btn btn-primary px-4">
                <i class="fas fa-search me-1"></i>Explore Courses
            </a>
        </div>
    </div>
    <% } else { %>
    <div class="row">
        <% for (CourseStatus cs : courses) {
            if (search == null || cs.getTutorSubject().toLowerCase().contains(search.toLowerCase())) {
        %>
        <div class="col-md-6 col-lg-4 mb-4">
            <div class="card course-card h-100">
                <div class="card-body">
                    <h5 class="card-title"><%= cs.getCourseName() %></h5>
                    <p class="text-muted mb-2">
                        <i class="fas fa-chalkboard-teacher me-1"></i><%= cs.getTutorSubject() %>
                    </p>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <span class="fw-bold text-primary">$<%= cs.getPrice() %></span>
                        <span class="text-muted"><i class="fas fa-clock me-1"></i><%= cs.getDuration() %> week(s)</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <span class="badge <%= cs.isPaid() ? "bg-success" : "bg-warning text-dark" %>">
                            <%= cs.isPaid() ? "Paid" : "Unpaid" %>
                        </span>
                        <div>
                            <form action="RemoveEnrollmentServlet" method="post" class="d-inline">
                                <input type="hidden" name="courseId" value="<%= cs.getCourseId() %>">
                                <button type="submit" class="btn btn-sm btn-outline-danger">
                                    <i class="fas fa-trash-alt me-1"></i>Remove
                                </button>
                            </form>
                            <% if (!cs.isPaid()) { %>
                            <form action="MarkAsPaidServlet" method="post" class="d-inline">
                                <input type="hidden" name="courseId" value="<%= cs.getCourseId() %>">
                                <button type="submit" class="btn btn-sm btn-primary">
                                    <i class="fas fa-check-circle me-1"></i>Mark Paid
                                </button>
                            </form>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <% }} %>
    </div>
    <% } %>
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