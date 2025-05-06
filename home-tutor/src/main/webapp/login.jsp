<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Login</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-5">
      <div class="card shadow-sm">
        <div class="card-header text-center">
          <h3>Student Login</h3>
        </div>
        <div class="card-body">
          <% String error = (String) request.getAttribute("error"); %>
          <% if (error != null) { %>
          <div class="alert alert-danger"><%= error %></div>
          <% } %>

          <form method="post" action="login">
            <div class="mb-3">
              <label for="username" class="form-label">Username</label>
              <input type="text" class="form-control" id="username" name="username" required>
            </div>

            <div class="mb-3">
              <label for="password" class="form-label">Password</label>
              <input type="password" class="form-control" id="password" name="password" required>
            </div>

            <div class="d-grid">
              <button type="submit" class="btn btn-primary">Login</button>
            </div>
          </form>
        </div>
        <div class="card-footer text-center">
          <small>Don't have an account? <a href="register.jsp">Register here</a></small>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>