<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, course.model.Course, course.utils.CourseFileUtil" %>
<%@ page import="rating.util.RatingFileUtil" %>
<%@ page import="rating.model.Rating" %>

<%
    String courseId = request.getParameter("courseId");
    String filePath = application.getRealPath("/WEB-INF/courses.txt");
    List<Course> allCourses = CourseFileUtil.getAllCourses(filePath);

    Course enrolledCourse = null;
    for (Course c : allCourses) {
        if (c.getCourseId().equals(courseId)) {
            enrolledCourse = c;
            break;
        }
    }

    String user = (String) session.getAttribute("username");
    int userRating = 0;
    double averageRating = 0;
    if (enrolledCourse != null) {
        String ratingPath = application.getRealPath("/WEB-INF/ratings.txt");
        averageRating = RatingFileUtil.getAverageRating(enrolledCourse.getCourseId(), ratingPath);
        userRating = user != null ? RatingFileUtil.getUserRating(user, enrolledCourse.getCourseId(), ratingPath) : 0;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Enrollment Successful - MetaTutor</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #5624d0;
            --secondary-color: #f7f9fa;
            --accent-color: #a435f0;
            --success-color: #28a745;
        }

        body {
            background: var(--secondary-color);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .success-card {
            max-width: 800px;
            margin: 2rem auto;
            border: none;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .success-header {
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            color: white;
            padding: 2.5rem;
            text-align: center;
        }

        .success-details {
            padding: 2rem;
            background: white;
        }

        .course-img {
            width: 100%;
            max-height: 200px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            padding: 0.75rem 1.5rem;
            font-size: 1.1rem;
        }

        .btn-outline-primary {
            color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-outline-primary:hover {
            background-color: var(--primary-color);
            color: white;
        }

        .feature-list {
            list-style: none;
            padding: 0;
        }

        .feature-list li {
            margin: 0.5rem 0;
            padding: 0.8rem;
            background: var(--secondary-color);
            border-radius: 8px;
            transition: transform 0.2s;
        }

        .feature-list li:hover {
            transform: translateX(5px);
        }

        .check-icon {
            font-size: 5rem;
            color: white;
            margin-bottom: 1.5rem;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }

        .navbar {
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            font-weight: 700;
            color: var(--primary-color) !important;
        }

        .rating-stars {
            font-size: 0.9rem;
            margin-bottom: 5px;
        }

        .rating-indicator {
            font-size: 0.9rem;
            padding: 0.5rem;
            border-radius: 4px;
            background-color: rgba(255, 193, 7, 0.1);
            margin-top: 1rem;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold" href="home-page.jsp">
            <i class="fas fa-graduation-cap me-2"></i>MetaTutor
        </a>
    </div>
</nav>

<!-- Page Content -->
<div class="container my-5">
    <div class="success-card">
        <div class="success-header">
            <i class="fas fa-check-circle check-icon"></i>
            <h1 class="mb-3">Enrollment Successful!</h1>
            <% if (enrolledCourse != null) { %>
            <p class="lead">You're now enrolled in <strong><%= enrolledCourse.getName() %></strong></p>
            <% } else { %>
            <p class="lead">Your enrollment was successful</p>
            <% } %>
        </div>

        <div class="success-details">
            <div class="row g-4">
                <% if (enrolledCourse != null) { %>
                <div class="col-md-6">
                    <img src="images/<%= enrolledCourse.getImage() %>" alt="Course Image" class="course-img">
                    <h4>What's Next?</h4>
                    <ul class="feature-list">
                        <li>
                            <i class="fas fa-play-circle me-2 text-primary"></i>
                            Start learning immediately
                        </li>
                        <li>
                            <i class="fas fa-book me-2 text-primary"></i>
                            Access course materials
                        </li>
                        <li>
                            <i class="fas fa-certificate me-2 text-primary"></i>
                            Earn your certificate
                        </li>
                    </ul>
                </div>
                <% } %>

                <div class="col-md-6 text-center">
                    <div class="d-flex flex-column h-100 justify-content-center">
                        <% if (enrolledCourse != null) { %>
                        <div class="mb-4">
                            <h4>Course Details</h4>
                            <p><strong>Instructor:</strong> <%= enrolledCourse.getTutorName() %></p>
                            <p><strong>Duration:</strong> <%= enrolledCourse.getDuration() %> weeks</p>
                            <p><strong>Level:</strong> <%= enrolledCourse.getLevel() %></p>

                            <div class="rating-stars">
                                <% for (int i = 1; i <= 5; i++) { %>
                                <i class="fa<%= i <= averageRating ? "s" : i-0.5 <= averageRating ? "s fa-star-half-alt" : "r" %> fa-star text-warning"></i>
                                <% } %>
                                <small class="text-muted">(<%= String.format("%.1f", averageRating) %>)</small>
                            </div>

                            <% if (userRating > 0) { %>
                            <div class="rating-indicator">
                                <i class="fas fa-star text-warning"></i> You rated:
                                <% for (int i = 1; i <= 5; i++) { %>
                                <i class="fa<%= i <= userRating ? "s" : "r" %> fa-star text-warning"></i>
                                <% } %>
                            </div>
                            <% } %>
                        </div>
                        <% } %>

                        <div class="mt-auto">
                            <a href="MyCoursesServlet" class="btn btn-primary btn-lg w-100 mb-3">
                                <i class="fas fa-book-open me-2"></i> Go to My Courses
                            </a>
                            <a href="course-home.jsp" class="btn btn-outline-primary btn-lg w-100">
                                <i class="fas fa-search me-2"></i> Browse More Courses
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>