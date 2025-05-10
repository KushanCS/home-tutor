<<<<<<< HEAD
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="course.utils.CourseFileUtil" %>
<%@ page import="course.model.Course" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Meta Tutor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            padding: 20px;
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
            color: #6c63ff;
        }
        .course-card {
            margin-bottom: 20px;
=======
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MetaTutor - All Courses</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #6c63ff;
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

        .banner {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 2.5rem;
            border-radius: 12px;
            margin-top: 2rem;
            box-shadow: 0 4px 20px rgba(108, 99, 255, 0.3);
            position: relative;
            overflow: hidden;
        }

        .banner::after {
            content: '';
            position: absolute;
            top: -50px;
            right: -50px;
            width: 200px;
            height: 200px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
        }

        .welcome-box {
            border-left: 5px solid var(--primary-color);
            background-color: #fff;
            padding: 2rem;
            box-shadow: 0 2px 15px rgba(0,0,0,0.05);
            border-radius: 8px;
            margin-top: 2rem;
        }

        .course-card {
            transition: all 0.3s ease;
            border: none;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 3px 10px rgba(0,0,0,0.08);
            margin-bottom: 1.5rem;
        }

        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.12);
        }

        .course-card img {
            height: 160px;
            object-fit: cover;
        }

        .progress {
            height: 8px;
            border-radius: 4px;
        }

        .progress-bar {
            background-color: var(--primary-color);
        }

        .badge-primary {
            background-color: var(--primary-color);
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-primary:hover {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
        }

        .btn-outline-primary {
            color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-outline-primary:hover {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .stats-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            text-align: center;
            transition: all 0.3s ease;
        }

        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        .stats-card i {
            font-size: 2rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .stats-card h3 {
            font-weight: 700;
            color: var(--dark-text);
        }

        .stats-card p {
            color: #6c757d;
            margin-bottom: 0;
        }

        .upcoming-session {
            background: white;
            border-left: 4px solid var(--accent-color);
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        footer {
            background-color: #2d3748;
            color: white;
            padding: 2rem 0;
            margin-top: 3rem;
>>>>>>> 7a993c67a31a5f1d793dc008289abfa012eaff15
        }
    </style>
</head>
<body>
<div class="container">
    <h1 class="header">Meta Tutor</h1>

<<<<<<< HEAD
    <div class="action-buttons">
        <a href="add-course.jsp" class="btn btn-primary">Add New Course</a>
    </div>
<br>
    <div class="row">
        <%
            String filePath = application.getRealPath("/WEB-INF/courses.txt");
            List<Course> courses = CourseFileUtil.readCoursesFromFile(filePath);

            for (Course course : courses) {
        %>
        <div class="col-md-4 course-card">
            <div class="card">
                <img src="https://via.placeholder.com/300">
                <div class="card-body">
                    <h5 class="card-title"><%= course.getName() %></h5>
                    <p class="card-text"><%= course.getDescription() %></p>
                    <p><strong>Tutor:</strong> <%= course.getTutor() %></p>
                    <p><strong>Price:</strong> $<%= String.format("%.2f", course.getPrice()) %></p>
                    <p><strong>Duration:</strong> <%= course.getDuration() %></p>
                    <a href="course-details.jsp?id=<%= course.getName() %>" class="btn btn-primary">View </a>
                    <a href="course-details.jsp?id=<%= course.getName() %>" class="btn btn-primary">Edit </a>
                    <a href="course-details.jsp?id=<%= course.getName() %>" class="btn btn-primary">Delete </a>
                </div>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
=======
<!-- Navbar -->
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
                    <a class="nav-link" href="student-course.jsp"><i class="bi bi-collection-play me-1"></i> My Courses</a>
                </li>
            </ul>
            <%
                String user = (String) session.getAttribute("username");
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
                <a href="student.jsp" class="btn btn-primary me-2">Dashboard</a>
                <a href="logout.jsp" class="btn btn-outline-primary">Log out</a>
            </div>
            <% } %>
        </div>
    </div>
</nav>

<!-- Search Bar -->
<div class="container mt-4">
    <div class="row justify-content-between align-items-center">
        <div class="col-md-6">
            <input type="text" id="courseSearch" class="form-control" placeholder="Search courses...">
        </div>
    </div>
</div>

<!-- Courses Section -->
<div class="container mt-4">
    <div class="row" id="courseList">
        <!-- Example Course Card -->
        <div class="col-md-4 mb-4 course-item">
            <div class="card course-card">
                <img src="https://via.placeholder.com/400x160" class="card-img-top course-img" alt="Java">
                <div class="card-body">
                    <h5 class="card-title">Introduction to Java</h5>
                    <p class="card-text">Learn the basics of Java programming with hands-on examples.</p>
                    <a href="#" class="btn btn-primary">Enroll</a>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-4 course-item">
            <div class="card course-card">
                <img src="https://via.placeholder.com/400x160" class="card-img-top course-img" alt="Web Dev">
                <div class="card-body">
                    <h5 class="card-title">Full Stack Web Development</h5>
                    <p class="card-text">Become a full-stack web developer with HTML, CSS, JS & more.</p>
                    <a href="#" class="btn btn-primary">Enroll</a>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-4 course-item">
            <div class="card course-card">
                <img src="https://via.placeholder.com/400x160" class="card-img-top course-img" alt="Networking">
                <div class="card-body">
                    <h5 class="card-title">Computer Networks</h5>
                    <p class="card-text">Understand how data travels over the internet and networks.</p>
                    <a href="#" class="btn btn-primary">Enroll</a>
                </div>
            </div>
        </div>
        <!-- Add more cards as needed -->
    </div>
</div>

<!-- Search Script -->
<script>
    const searchInput = document.getElementById('courseSearch');
    searchInput.addEventListener('keyup', function () {
        const filter = searchInput.value.toLowerCase();
        const courses = document.querySelectorAll('.course-item');
        courses.forEach(course => {
            const text = course.textContent.toLowerCase();
            course.style.display = text.includes(filter) ? 'block' : 'none';
        });
    });
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

>>>>>>> 7a993c67a31a5f1d793dc008289abfa012eaff15
</body>
</html>

