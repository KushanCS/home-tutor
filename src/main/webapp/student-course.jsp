<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="course.model.CourseStatus" %>
<%@ page import="course.model.Course" %>
<%
    List<CourseStatus> courses = (List<CourseStatus>) request.getAttribute("courses");
    String username = (String) session.getAttribute("username");

    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Courses</title>
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
    </style></head>
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
            <% if (username == null) { %>
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

<!-- Main Content -->
<div class="container py-5">
    <h2 class="mb-4 text-primary">Your Enrolled Courses</h2>

    <% if (courses == null || courses.isEmpty()) { %>
    <div class="alert alert-info">You have not enrolled in any courses yet.</div>
    <% } else { %>
    <div class="table-responsive">
        <table class="table table-bordered table-striped align-middle">
            <thead class="table-light">
            <tr>
                <th>Name</th>
                <th>Tutor</th>
                <th>Price</th>
                <th>Duration</th>
                <th>Description</th>
                <th>Paid</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for (CourseStatus status : courses) {
                Course course = status.getCourse();
            %>
            <tr>
                <td><%= course.getName() %></td>
                <td><%= course.getTutor() %></td>
                <td>$<%= String.format("%.2f", course.getPrice()) %></td>
                <td><%= course.getDuration() %></td>
                <td><%= course.getDescription() %></td>
                <td>
                        <span class="badge bg-<%= status.isPaid() ? "success" : "warning text-dark" %>">
                            <%= status.isPaid() ? "Paid" : "Unpaid" %>
                        </span>
                </td>
                <td>
                    <form action="RemoveCourseServlet" method="post" class="d-inline">
                        <input type="hidden" name="course" value="<%= course.getName() %>">
                        <button class="btn btn-sm btn-danger" type="submit">Remove</button>
                    </form>
                    <% if (!status.isPaid()) { %>
                    <form action="MarkAsPaidServlet" method="post" class="d-inline">
                        <input type="hidden" name="course" value="<%= course.getName() %>">
                        <button class="btn btn-sm btn-outline-primary" type="submit">Mark as Paid</button>
                    </form>
                    <% } %>
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
