<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="course.model.Course" %>
<%@ page import="course.utils.CourseFileUtil" %>
<%@ page import="tutor.model.Tutor" %>
<%
    // Check if tutor is logged in by verifying session attribute
    Tutor tutor = (Tutor) session.getAttribute("tutor");
    if (tutor == null) {
        // Redirect to login if not logged in
        response.sendRedirect("loginTutor.jsp");
        return;
    }

    // Get tutor ID and course ID from parameters
    String tutorId = tutor.getTutorId();
    String courseId = request.getParameter("id");
    // Get real path to courses data file
    String courseFilePath = application.getRealPath("/WEB-INF/courses.txt");

    // Find the course to edit
    Course courseToEdit = null;
    List<Course> courses = CourseFileUtil.getCoursesByTutor(tutorId, courseFilePath);
    for (Course c : courses) {
        if (c.getCourseId().equals(courseId)) {
            courseToEdit = c;
            break;
        }
    }

    // Redirect if course not found
    if (courseToEdit == null) {
        response.sendRedirect("view_courses.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Course - MetaTutor</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* CSS variables for consistent theming */
        :root {
            --primary-color: #5624d0;
            --secondary-color: #f7f9fa;
            --accent-color: #a435f0;
        }

        body {
            background-color: var(--secondary-color);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-top: 0;
        }

        /* Navbar styling */
        .navbar {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        .navbar-brand {
            font-weight: 700;
            color: var(--primary-color) !important;
        }

        /* Button styling */
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-primary:hover {
            background-color: #4a1fb3;
            border-color: #4a1fb3;
        }

        /* Main content container */
        .course-container {
            max-width: 900px;
            margin: 30px auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        /* Form layout */
        .form-row {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .form-col {
            flex: 1;
            min-width: 250px;
        }

        /* Image preview styling */
        .image-preview {
            width: 100%;
            height: 200px;
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
            overflow: hidden;
            border-radius: 6px;
            border: 1px dashed #ddd;
        }

        /* Required field indicator */
        .required-field::after {
            content: " *";
            color: red;
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light sticky-top">
    <div class="container">
        <a class="navbar-brand" href="view_courses.jsp">
            <i class="fas fa-graduation-cap me-2"></i>MetaTutor
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <div class="ms-auto d-flex align-items-center">
                <!-- Back button -->
                <a href="view_courses.jsp" class="btn btn-outline-secondary me-2">
                    <i class="fas fa-arrow-left me-1"></i> Back to Courses
                </a>
                <!-- Logout button -->
                <a href="logoutTutor.jsp" class="btn btn-outline-danger">
                    <i class="fas fa-sign-out-alt me-1"></i> Logout
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- Main Edit Course Form -->
<div class="course-container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="page-title"><i class="fas fa-edit me-2"></i>Edit Course</h2>
    </div>

    <!-- Form that submits to UpdateCourseServlet -->
    <form action="UpdateCourseServlet" method="post" enctype="multipart/form-data">
        <!-- Hidden fields for course data that shouldn't be edited -->
        <input type="hidden" name="courseId" value="<%= courseToEdit.getCourseId() %>"/>
        <input type="hidden" name="tutorId" value="<%= courseToEdit.getTutorId() %>"/>
        <input type="hidden" name="tutorName" value="<%= courseToEdit.getTutorName() %>"/>
        <input type="hidden" name="tutorSubject" value="<%= courseToEdit.getTutorSubject() %>"/>
        <input type="hidden" name="currentImage" value="<%= courseToEdit.getImage() %>"/>

        <!-- Course Name Field -->
        <div class="mb-3">
            <label for="name" class="form-label required-field">Course Name</label>
            <input type="text" class="form-control" id="name" name="name"
                   value="<%= courseToEdit.getName() %>" required>
        </div>

        <!-- Description Field -->
        <div class="mb-3">
            <label for="description" class="form-label required-field">Description</label>
            <textarea class="form-control" id="description" name="description" rows="4"
                      required><%= courseToEdit.getDescription() %></textarea>
        </div>

        <!-- Two-column layout for level and price -->
        <div class="form-row">
            <div class="form-col">
                <label for="level" class="form-label required-field">Level</label>
                <select class="form-select" id="level" name="level" required>
                    <option value="Beginner" <%= courseToEdit.getLevel().equals("Beginner") ? "selected" : "" %>>Beginner</option>
                    <option value="Intermediate" <%= courseToEdit.getLevel().equals("Intermediate") ? "selected" : "" %>>Intermediate</option>
                    <option value="Advanced" <%= courseToEdit.getLevel().equals("Advanced") ? "selected" : "" %>>Advanced</option>
                </select>
            </div>
            <div class="form-col">
                <label for="price" class="form-label required-field">Price (USD)</label>
                <div class="input-group">
                    <span class="input-group-text">$</span>
                    <input type="number" class="form-control" id="price" name="price"
                           step="0.01" min="0" value="<%= courseToEdit.getPrice() %>" required>
                </div>
            </div>
        </div>

        <!-- Two-column layout for duration and current image -->
        <div class="form-row mt-3">
            <div class="form-col">
                <label for="duration" class="form-label required-field">Duration (weeks)</label>
                <input type="number" class="form-control" id="duration" name="duration"
                       min="1" value="<%= courseToEdit.getDuration() %>" required>
            </div>
            <div class="form-col">
                <label class="form-label">Current Image</label>
                <img src="images/<%= courseToEdit.getImage() %>" alt="Current Course Image" class="current-image img-thumbnail">
            </div>
        </div>

        <!-- Image upload section -->
        <div class="mt-3">
            <label for="image" class="form-label">Change Image (optional)</label>
            <div class="image-preview" id="imagePreview">
                <i class="fas fa-image fa-3x text-muted"></i>
            </div>
            <input type="file" class="form-control" id="image" name="image" accept="image/*">
            <div class="form-text">Leave blank to keep current image</div>
        </div>

        <!-- Form action buttons -->
        <div class="d-flex justify-content-end mt-4 pt-3 border-top">
            <a href="view_courses.jsp" class="btn btn-outline-secondary me-3">
                <i class="fas fa-times me-1"></i> Cancel
            </a>
            <button type="submit" class="btn btn-primary px-4">
                <i class="fas fa-save me-1"></i> Update Course
            </button>
        </div>
    </form>
</div>

<!-- JavaScript for image preview functionality -->
<script>
    // Get DOM elements
    const imageInput = document.getElementById('image');
    const imagePreview = document.getElementById('imagePreview');

    // Add change event listener to image input
    imageInput.addEventListener('change', function() {
        const file = this.files[0];
        if (file) {
            // Create file reader to preview selected image
            const reader = new FileReader();
            reader.onload = function(e) {
                imagePreview.innerHTML = `<img src="${e.target.result}" alt="Preview">`;
            }
            reader.readAsDataURL(file);
        } else {
            // Show default icon if no file selected
            imagePreview.innerHTML = '<i class="fas fa-image fa-3x text-muted"></i>';
        }
    });
</script>

<!-- Bootstrap JS bundle (includes Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>