<%@ page import="student.model.Student" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Student student = (Student) request.getAttribute("student");
    if (student == null) {
        response.sendRedirect("AdminServlet?action=viewStudents");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Student</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', sans-serif;
        }
        .navbar {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .navbar-brand {
            font-weight: 600;
            color: #5624d0;
        }
        .form-container {
            background: white;
            padding: 2rem 3rem;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            max-width: 850px;
            margin: 2rem auto;
        }
        .form-control, .form-select {
            border-radius: 10px;
            padding: 0.75rem;
        }
        .btn-primary {
            padding: 0.75rem;
            font-weight: 500;
            background-color: #5624d0;
            border-color: #5624d0;
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light sticky-top">
    <div class="container">
        <a class="navbar-brand" href="adminDashboard.jsp">
            <i class="fas fa-chalkboard-teacher me-2"></i>MetaTutor Admin
        </a>
        <div class="ms-auto">
            <a href="AdminServlet?action=viewStudents" class="btn btn-outline-secondary">
                <i class="fas fa-times me-1"></i> Close
            </a>
        </div>
    </div>
</nav>

<!-- Form Container -->
<div class="container">
    <div class="form-container">
        <h3 class="text-center mb-4">Edit Student - <%= student.getStdId() %></h3>

        <form action="AdminServlet" method="post">
            <input type="hidden" name="action" value="updateStudent">
            <input type="hidden" name="studentId" value="<%= student.getStdId() %>">

            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label">Username</label>
                    <input type="text" name="username" class="form-control" value="<%= student.getUserName() %>" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Name</label>
                    <input type="text" name="name" class="form-control" value="<%= student.getName() %>" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" value="<%= student.getEmail() %>" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Phone</label>
                    <input type="text" name="phone" class="form-control" value="<%= student.getPhone() %>">
                </div>
                <div class="col-md-6">
                    <label class="form-label">Course</label>
                    <input type="text" name="course" class="form-control" value="<%= student.getCourse() %>">
                </div>
                <div class="col-md-6">
                    <label class="form-label">Date of Birth</label>
                    <input type="date" name="dob" class="form-control" value="<%= student.getDob() %>">
                </div>
                <div class="col-12">
                    <label class="form-label">Address</label>
                    <input type="text" name="address" class="form-control" value="<%= student.getAddress() %>">
                </div>
                <div class="col-md-6">
                    <label class="form-label">New Password</label>
                    <input type="password" name="newPassword" class="form-control" placeholder="Leave blank to keep current password">
                </div>
                <div class="col-12 d-flex justify-content-end gap-2 mt-3">
                    <a href="AdminServlet?action=viewStudents" class="btn btn-secondary">
                        <i class="fas fa-times me-1"></i> Cancel
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-1"></i> Update Student
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>