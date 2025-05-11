<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="student.model.Course" %>
<%
  Course student = (Course) session.getAttribute("student");
  if (student == null) {
    response.sendRedirect("login.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title>Edit Profile</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card">
        <div class="card-header">
          <h3>Edit Profile</h3>
        </div>
        <div class="card-body">
          <form method="post" action="editProfile">
            <div class="mb-3">
              <label class="form-label">Full Name</label>
              <input type="text" class="form-control" name="name"
                     value="<%= student.getName() %>" required>
            </div>
            <div class="mb-3">
              <label class="form-label">Username</label>
              <input type="text" class="form-control" name="username"
                     value="<%= student.getUserName() %>" required>
            </div>
            <div class="mb-3">
              <label class="form-label">Email</label>
              <input type="email" class="form-control" name="email"
                     value="<%= student.getEmail() %>" required>
            </div>
            <div class="mb-3">
              <label class="form-label">New Password</label>
              <input type="password" class="form-control" name="password">
            </div>
            <div class="mb-3">
              <label class="form-label">Phone</label>
              <input type="text" class="form-control" name="phone"
                     value="<%= student.getPhone() %>">
            </div>
            <div class="mb-3">
              <label class="form-label">Address</label>
              <textarea class="form-control" name="address"><%= student.getAddress() %></textarea>
            </div>


              <button  type="submit" class="btn btn-primary">
                Save Changes
              </button>

            <a href="profile.jsp" class="btn btn-secondary">Cancel</a>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>