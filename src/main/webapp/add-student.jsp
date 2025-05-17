<<<<<<< Updated upstream
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="tutor.model.Tutor" %>

<%
    // Step 1: Check if tutor is logged in
    Tutor tutor = (Tutor) session.getAttribute("tutor");
    if (tutor == null) {
        response.sendRedirect("loginTutor.jsp"); // Redirect to login if not authenticated
        return;
    }

    // Step 2: Retrieve tutor ID to associate course with the tutor
    String tutorId = tutor.getTutorId();
%>

=======

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
>>>>>>> Stashed changes
<!DOCTYPE html>
<html>
<head>
    <title>Add Course - MetaTutor</title>
<<<<<<< Updated upstream

    <!-- Bootstrap CSS for styling -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<!-- Course creation form container -->
<div class="container mt-5 bg-white p-4 rounded shadow" style="max-width: 800px;">
    <h2 class="text-primary mb-4">
        <i class="fas fa-plus-circle me-2"></i>Add New Course
    </h2>

    <!-- Course submission form -->
    <form action="AddCourseServlet" method="post" enctype="multipart/form-data">
        <!-- Hidden field to include tutor ID -->
        <input type="hidden" name="tutorId" value="<%= tutorId %>" />

        <!-- Course name -->
=======
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<div class="container mt-5 bg-white p-4 rounded shadow" style="max-width: 800px;">
    <h2 class="text-primary mb-4"><i class="fas fa-plus-circle me-2"></i>Add New Course</h2>
    <form action="AddCourseServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="tutorId" value="<%= tutorId %>" />

>>>>>>> Stashed changes
        <div class="mb-3">
            <label for="name" class="form-label">Course Name</label>
            <input type="text" class="form-control" id="name" name="name" required>
        </div>

<<<<<<< Updated upstream
        <!-- Course description -->
=======
>>>>>>> Stashed changes
        <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <textarea class="form-control" id="description" name="description" required></textarea>
        </div>

<<<<<<< Updated upstream
        <!-- Course level -->
=======
>>>>>>> Stashed changes
        <div class="mb-3">
            <label for="level" class="form-label">Level</label>
            <select class="form-select" id="level" name="level">
                <option value="Beginner">Beginner</option>
                <option value="Intermediate">Intermediate</option>
                <option value="Advanced">Advanced</option>
            </select>
        </div>

        <!-- Course image upload -->
        <div class="mb-3">
            <label for="image" class="form-label">Course Image</label>
            <input type="file" class="form-control" id="image" name="image" accept="image/*" required>
        </div>

        <!-- Course price -->
        <div class="mb-3">
            <label for="price" class="form-label">Price</label>
            <input type="text" class="form-control" id="price" name="price" required>
        </div>

<<<<<<< Updated upstream
        <!-- Course duration -->
=======
>>>>>>> Stashed changes
        <div class="mb-4">
            <label for="duration" class="form-label">Duration</label>
            <input type="text" class="form-control" id="duration" name="duration" required>
        </div>

<<<<<<< Updated upstream
        <!-- Submit button -->
=======
>>>>>>> Stashed changes
        <div class="d-flex justify-content-end">
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-save me-1"></i> Add Course
            </button>
        </div>
    </form>
</div>

</body>
</html>
