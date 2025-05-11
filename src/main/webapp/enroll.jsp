<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List"%>
<%@ page import="course.model.Course"%>
<%@ page import="course.utils.CourseFileUtil"%>

<%
    // 1. Get course name from request
    String nameParam = request.getParameter("name");

    // 2. Read courses
    String filePath = application.getRealPath("/WEB-INF/courses.txt");
    List<Course> courses = CourseFileUtil.readCoursesFromFile(filePath);

    // 3. Find matching course
    Course selected = null;
    for (Course c : courses) {
        if (c.getName().equalsIgnoreCase(nameParam)) {
            selected = c;
            break;
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Enroll in Course</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root { --primary-color: #6c63ff; --secondary-color: #4d44db; --light-bg: #f8f9fa; }
        body { background: var(--light-bg); font-family: 'Segoe UI', sans-serif; }
        .enrollment-card { max-width: 600px; margin: 2rem auto;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .course-header { background: linear-gradient(135deg,
        var(--primary-color), var(--secondary-color));
            color: white; padding: 1.5rem;
            border-radius: 10px 10px 0 0; }
        .price-tag { color: var(--primary-color);
            font-weight: bold;
            font-size: 1.5rem; }
        .btn-enroll { background: var(--primary-color);
            color: white; border: none;
            padding: 0.5rem 1.5rem; }
        .btn-enroll:hover { background: var(--secondary-color); }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="home-page.jsp">
            <i class="fas fa-graduation-cap me-2"></i>MetaTutor
        </a>
        <button class="navbar-toggler" data-bs-toggle="collapse"
                data-bs-target="#navbarNav"><span
                class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="student-course.jsp">My Courses</a>
                </li>
            </ul>
            <div class="d-flex">
                <% String user = (String) session.getAttribute("username"); %>
                <% if (user == null) { %>
                <a href="login.jsp" class="btn btn-outline-primary me-2">Log in</a>
                <a href="register.jsp" class="btn btn-primary">Sign up</a>
                <% } else { %>
                <a href="student.jsp" class="btn btn-outline-primary me-2">Dashboard</a>
                <a href="logout.jsp" class="btn btn-outline-primary">Log out</a>
                <% } %>
            </div>
        </div>
    </div>
</nav>

<div class="card enrollment-card">
    <div class="course-header text-center">
        <h2><i class="fas fa-graduation-cap me-2"></i>Course Enrollment</h2>
    </div>

    <div class="card-body p-4">
        <% if (selected != null) { %>
        <h3 class="mb-3"><%= selected.getName() %></h3>
        <p><strong>Description:</strong> <%= selected.getDescription() %></p>
        <p><strong>Tutor:</strong> <%= selected.getTutor() %></p>
        <p class="price-tag">
            <strong>Price:</strong> $<%= String.format("%.2f", selected.getPrice()) %>
        </p>
        <p><strong>Duration:</strong> <%= selected.getDuration() %></p>

        <!-- ←– Replace the link with this form: –→ -->
        <div class="text-center mt-4">
            <form method="post" action="enrollCourse">
                <input type="hidden" name="name"
                       value="<%= selected.getName() %>"/>
                <input type="hidden" name="description"
                       value="<%= selected.getDescription() %>"/>
                <input type="hidden" name="tutor"
                       value="<%= selected.getTutor() %>"/>
                <input type="hidden" name="price"
                       value="<%= selected.getPrice() %>"/>
                <input type="hidden" name="duration"
                       value="<%= selected.getDuration() %>"/>
                <button type="submit" class="btn btn-enroll">
                    <i class="fas fa-credit-card me-1"></i>Pay Now
                </button>
            </form>
        </div>

        <% } else { %>
        <p class="text-danger text-center">
            Sorry, that course was not found.
        </p>
        <% } %>
    </div>
</div>

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>
