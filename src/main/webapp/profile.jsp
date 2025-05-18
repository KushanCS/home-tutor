<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="student.model.Student" %>
<%@ page import="java.net.URLEncoder" %>
<%
    Student student = (Student) session.getAttribute("student");
    if (student == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MetaTutor - Online Learning Platform</title>
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
            height: 160px;
            object-fit: cover;
        }

        .rating {
            color: #f4c150;
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
                    <a class="nav-link" href="student-course.jsp"><i class="bi bi-collection-play me-1"></i> My Courses</a>
                </li>
            </ul>
            <%
                String user = (String) session.getAttribute("username"); // Assuming username is stored in session
                if (user == null) {
            %>
            <div class="d-flex">
                <a href="login.jsp" class="btn btn-outline-primary me-2">Log in</a>
                <a href="register.jsp" class="btn btn-primary">Sign up</a>
            </div>
            <%
            } else {
            %>
            <div>
                <a href="student.jsp" class="btn btn-primary">Dashboard</a>
                <a href="logout.jsp" class="btn btn-outline-primary">Log out</a>
            </div>
            <%} %>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="row">
        <div class="col-md-4">
            <div class="card">
                <div class="card-body text-center">
                    <%
                        // pick profile pic if set, otherwise fall back to a ui-avatars.com URL
                        String pic;
                        if (student.getProfilePicPath() != null && !student.getProfilePicPath().isEmpty()) {
                            pic = student.getProfilePicPath();
                        } else {
                            // URL-encode the name so spaces, etc. don’t break the URL
                            String nameEncoded = URLEncoder.encode(student.getName(), "UTF-8");
                            pic = "https://ui-avatars.com/api/?name=" + nameEncoded + "&background=random&size=150";
                        }
                    %>
                    <img src="<%= pic %>"
                         class="rounded-circle profile-img mb-3 w-50 h-50"
                         alt="Profile picture of <%= student.getName() %>"/>
                    <h3><%= student.getName() %></h3>
                    <p class="text-muted"><%= student.getCourse() %></p>
                    <a href="editProfile.jsp" class="btn btn-primary">Edit Profile</a>
                </div>
            </div>
        </div>
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h4>Profile Information</h4>
                </div>
                <div class="card-body">
                    <table class="table">
                        <tr>
                            <th>Student ID</th>
                            <td><%= student.getStdId() %></td>
                        </tr>
                        <tr>
                            <th>Username</th>
                            <td><%= student.getUserName() %></td>
                        </tr>
                        <tr>
                            <th>Email</th>
                            <td><%= student.getEmail() %></td>
                        </tr>
                        <tr>
                            <th>Phone</th>
                            <td><%= student.getPhone() %></td>
                        </tr>
                        <tr>
                            <th>Address</th>
                            <td><%= student.getAddress() %></td>
                        </tr>
                        <tr>
                            <th>Date of Birth</th>
                            <td><%= student.getDob() %></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>