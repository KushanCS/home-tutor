<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="tutor.model.Tutor" %>
<%
    Tutor tutor = (Tutor) session.getAttribute("tutor");
    if (tutor == null) {
        response.sendRedirect("loginTutor.jsp");
        return;
    }
    String tutorId = tutor.getTutorId();
    String tutorName = tutor.getName();
    String tutorSubject = tutor.getSubject();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Course - MetaTutor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
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

        .navbar {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        .navbar-brand {
            font-weight: 700;
            color: var(--primary-color) !important;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-primary:hover {
            background-color: #4a1fb3;
            border-color: #4a1fb3;
        }

        .btn-outline-primary {
            color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-outline-primary:hover {
            background-color: var(--primary-color);
            color: white;
        }

        .course-container {
            max-width: 900px;
            margin: 30px auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .page-title {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #eee;
        }

        .form-row {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .form-col {
            flex: 1;
            min-width: 250px;
        }

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

        .image-preview img {
            max-height: 100%;
            max-width: 100%;
            object-fit: contain;
        }

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
        <a class="navbar-brand" href="home-page.jsp">
            <i class="fas fa-graduation-cap me-2"></i>MetaTutor
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <div class="ms-auto d-flex align-items-center">
                <a href="view_courses.jsp" class="btn btn-outline-secondary me-2">
                    <i class="fas fa-arrow-left me-1"></i> Back to Courses
                </a>
                <a href="logoutTutor.jsp" class="btn btn-outline-danger">
                    <i class="fas fa-sign-out-alt me-1"></i> Logout
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- Add Course Form -->
<div class="course-container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="page-title"><i class="fas fa-plus-circle me-2"></i>Add New Course</h2>
    </div>

    <form action="AddCourseServlet" method="post" enctype="multipart/form-data">
        <!-- Hidden tutor data -->
        <input type="hidden" name="tutorId" value="<%= tutorId %>" />
        <input type="hidden" name="tutorName" value="<%= tutorName %>" />
        <input type="hidden" name="tutorSubject" value="<%= tutorSubject %>" />

        <div class="form-row">
            <div class="form-col">
                <label class="form-label required-field">Course Name</label>
                <input type="text" name="name" class="form-control" required>
            </div>
            <div class="form-col">
                <label class="form-label required-field">Level</label>
                <select name="level" class="form-select" required>
                    <option value="" disabled selected>Select level</option>
                    <option value="Beginner">Beginner</option>
                    <option value="Intermediate">Intermediate</option>
                    <option value="Advanced">Advanced</option>
                </select>
            </div>
        </div>

        <div class="mt-3">
            <label class="form-label required-field">Description</label>
            <textarea name="description" class="form-control" rows="4" required></textarea>
        </div>

        <div class="form-row mt-3">
            <div class="form-col">
                <label class="form-label required-field">Price (USD)</label>
                <div class="input-group">
                    <span class="input-group-text">$</span>
                    <input type="number" name="price" class="form-control" step="0.01" min="0" required>
                </div>
            </div>
            <div class="form-col">
                <label class="form-label required-field">Duration (weeks)</label>
                <input type="number" name="duration" class="form-control" min="1" required>
            </div>
        </div>

        <div class="mt-3">
            <label class="form-label">Course Image</label>
            <div class="image-preview" id="imagePreview">
                <i class="fas fa-image fa-3x text-muted"></i>
            </div>
            <input type="file" name="image" id="image" class="form-control" accept="image/*">
            <div class="form-text">Recommended size: 800x450 pixels (16:9 aspect ratio)</div>
        </div>

        <div class="d-flex justify-content-end mt-4 pt-3 border-top">
            <button type="reset" class="btn btn-outline-secondary me-3">
                <i class="fas fa-undo me-1"></i> Reset
            </button>
            <button type="submit" class="btn btn-primary px-4">
                <i class="fas fa-save me-1"></i> Add Course
            </button>
        </div>
    </form>
</div>

<script>
    // Image preview
    const imageInput = document.getElementById('image');
    const imagePreview = document.getElementById('imagePreview');

    imageInput.addEventListener('change', function() {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                imagePreview.innerHTML = `<img src="${e.target.result}" alt="Preview">`;
            }
            reader.readAsDataURL(file);
        } else {
            imagePreview.innerHTML = '<i class="fas fa-image fa-3x text-muted"></i>';
        }
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>