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
        }
    </style>
</head>
<body>
<div class="container">
    <h1 class="header">Meta Tutor</h1>

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
</body>
</html>
