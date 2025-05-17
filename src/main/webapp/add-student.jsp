
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="tutor.model.Tutor" %>
<%
    Tutor tutor = (Tutor) session.getAttribute("tutor");
    if (tutor == null) {
        response.sendRedirect("loginTutor.jsp");
        return;
    }
    String tutorId = tutor.getTutorId();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Course - MetaTutor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<div class="container mt-5 bg-white p-4 rounded shadow" style="max-width: 800px;">
    <h2 class="text-primary mb-4"><i class="fas fa-plus-circle me-2"></i>Add New Course</h2>
    <form action="AddCourseServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="tutorId" value="<%= tutorId %>" />

        <div class="mb-3">
            <label for="name" class="form-label">Course Name</label>
            <input type="text" class="form-control" id="name" name="name" required>
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <textarea class="form-control" id="description" name="description" required></textarea>
        </div>

        <div class="mb-3">
            <label for="level" class="form-label">Level</label>
            <select class="form-select" id="level" name="level">
                <option value="Beginner">Beginner</option>
                <option value="Intermediate">Intermediate</option>
                <option value="Advanced">Advanced</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="image" class="form-label">Course Image</label>
            <input type="file" class="form-control" id="image" name="image" accept="image/*" required>
        </div>

        <div class="mb-3">
            <label for="price" class="form-label">Price</label>
            <input type="text" class="form-control" id="price" name="price" required>
        </div>

        <div class="mb-4">
            <label for="duration" class="form-label">Duration</label>
            <input type="text" class="form-control" id="duration" name="duration" required>
        </div>

        <div class="d-flex justify-content-end">
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-save me-1"></i> Add Course
            </button>
        </div>
    </form>
</div>
</body>
</html>
