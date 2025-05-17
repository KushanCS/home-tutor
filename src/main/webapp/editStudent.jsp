<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Edit Student</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <div class="card">
    <div class="card-header">
      <h4>Edit Student</h4>
    </div>
    <div class="card-body">
      <form action="AdminServlet" method="post">
        <input type="hidden" name="action" value="updateStudent">
        <input type="hidden" name="studentId" value="${student.stdId}">

        <div class="row mb-3">
          <div class="col-md-6">
            <label class="form-label">Full Name</label>
            <input type="text" name="name" class="form-control" value="${student.name}" required>
          </div>
          <div class="col-md-6">
            <label class="form-label">Username</label>
            <input type="text" name="username" class="form-control" value="${student.userName}" required>
          </div>
        </div>

        <!-- Include all other fields similar to addStudent.jsp -->
        <!-- Add password change fields if needed -->

        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
          <a href="StudentManagement.jsp" class="btn btn-secondary me-md-2">Cancel</a>
          <button type="submit" class="btn btn-primary">Update Student</button>
        </div>
      </form>
    </div>
  </div>
</div>
</body>
</html>