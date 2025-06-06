<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Register Student - Admin</title>
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
    .btn-secondary {
      padding: 0.75rem;
      font-weight: 500;
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
      <a href="StudentManagement.jsp" class="btn-close btn-close-purple" aria-label="Close"></a>
    </div>
  </div>
</nav>

<!-- Form Container -->
<div class="container">
  <div class="form-container">
    <h3 class="text-center mb-4">Register New Student</h3>

    <form action="RegisterServlet" method="post" enctype="multipart/form-data">
      <input type="hidden" name="role" value="student">
      <input type="hidden" name="from" value="admin">

      <div class="row g-3">
        <div class="col-md-6">
          <input type="text" name="name" class="form-control" placeholder="Full Name" required>
        </div>
        <div class="col-md-6">
          <input type="text" name="username" class="form-control" placeholder="Username" required>
        </div>
        <div class="col-md-6">
          <input type="email" name="email" class="form-control" placeholder="Email" required>
        </div>
        <div class="col-md-6">
          <input type="text" name="contact" class="form-control" placeholder="Contact Number" required>
        </div>
        <div class="col-md-6">
          <input type="date" name="dob" class="form-control" required>
        </div>
        <div class="col-md-6">
          <input type="text" name="course" class="form-control" placeholder="Course" required>
        </div>
        <div class="col-12">
          <input type="text" name="address" class="form-control" placeholder="Address" required>
        </div>
        <div class="col-md-6">
          <input type="password" id="password" name="password" class="form-control" placeholder="Password" required>
          <div class="progress mt-1"><div id="password-strength" class="progress-bar bg-danger" role="progressbar" style="width: 0%"></div></div>
        </div>
        <div class="col-md-6">
          <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Confirm Password" required>
          <span id="match-message" class="form-text"></span>
        </div>
        <div class="col-12">
          <label for="image" class="form-label">Profile Image (optional)</label>
          <input type="file" name="image" id="image" class="form-control" accept="image/*">
        </div>
        <div class="col-12 d-flex justify-content-between">
          <a href="StudentManagement.jsp" class="btn btn-secondary">
            <i class="fas fa-times me-1"></i> Cancel
          </a>
          <button type="submit" class="btn btn-primary">
            <i class="fas fa-user-plus me-1"></i> Register Student
          </button>
        </div>
      </div>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  const password = document.getElementById("password");
  const confirmPassword = document.getElementById("confirmPassword");
  const matchMessage = document.getElementById("match-message");
  const strengthBar = document.getElementById("password-strength");

  function updateStrengthBar() {
    const val = password.value;
    let strength = 0;
    if (val.length >= 8) strength++;
    if (/[A-Z]/.test(val)) strength++;
    if (/[0-9]/.test(val)) strength++;
    if (/[^A-Za-z0-9]/.test(val)) strength++;
    const widths = ["0%", "25%", "50%", "75%", "100%"];
    const colors = ["bg-danger", "bg-warning", "bg-info", "bg-primary", "bg-success"];
    strengthBar.style.width = widths[strength];
    strengthBar.className = "progress-bar " + colors[strength];
  }

  function checkMatch() {
    if (password.value && confirmPassword.value) {
      if (password.value === confirmPassword.value) {
        matchMessage.textContent = "Passwords match";
        matchMessage.className = "form-text text-success";
      } else {
        matchMessage.textContent = "Passwords do not match";
        matchMessage.className = "form-text text-danger";
      }
    } else {
      matchMessage.textContent = "";
    }
  }

  password.addEventListener("input", () => {
    updateStrengthBar();
    checkMatch();
  });
  confirmPassword.addEventListener("input", checkMatch);
</script>
</body>
</html>