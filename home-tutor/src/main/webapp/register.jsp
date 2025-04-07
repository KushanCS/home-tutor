<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Student Portal - Register</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    :root {
      --primary-color: #3498db;
      --secondary-color: #f8f9fa;
    }

    body {
      background-color: var(--secondary-color);
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      min-height: 100vh;
      display: flex;
      align-items: center;
    }

    .logo {
      font-size: 2.5rem;
      font-weight: 700;
      color: var(--primary-color);
      margin-bottom: 1rem;
    }

    .tagline {
      font-size: 1.2rem;
      color: #555;
      margin-bottom: 2rem;
    }

    .register-card {
      border: none;
      border-radius: 10px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
      padding: 2rem;
    }

    .btn-primary {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
      padding: 0.75rem;
      font-weight: 500;
    }

    .form-control {
      padding: 0.75rem;
      border-radius: 8px;
      margin-bottom: 1rem;
    }

    .password-strength {
      height: 5px;
      margin-top: -10px;
      margin-bottom: 15px;
    }

    .strength-weak {
      background-color: #dc3545;
      width: 25%;
    }

    .strength-medium {
      background-color: #ffc107;
      width: 50%;
    }

    .strength-strong {
      background-color: #28a745;
      width: 100%;
    }

    .footer-links {
      text-align: center;
      margin-top: 1.5rem;
    }

    .footer-links a {
      color: #777;
      text-decoration: none;
      margin: 0 0.5rem;
    }

    .footer-links a:hover {
      color: var(--primary-color);
    }
  </style>
</head>
<body>
<div class="container">
  <div class="row justify-content-center">
    <div class="col-lg-8">
      <div class="text-center mb-5">
        <div class="logo">Meta Tutor</div>
        <div class="tagline">Start your learning journey today</div>
      </div>

      <% String error = (String) request.getAttribute("error"); %>
      <% if (error != null) { %>
      <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <%= error %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
      <% } %>
      <% String message = (String) request.getAttribute("message"); %>
      <% if (message != null) { %>
      <div class="alert alert-success alert-dismissible fade show" role="alert">
        <%= message %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
      <% } %>

      <div class="register-card">
        <h3 class="text-center mb-4">Create Your Account</h3>

        <form action="login" method="post" onsubmit="return validateForm()">
          <input type="hidden" name="action" value="register">

          <div class="row">
            <div class="col-md-6">
              <div class="form-floating mb-3">
                <input type="text" class="form-control" id="username" name="username" placeholder="Username" required>
                <label for="username">Username</label>
              </div>
            </div>
            <div class="col-md-6">
              <div class="form-floating mb-3">
                <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Full Name" required>
                <label for="fullName">Full Name</label>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-md-6">
              <div class="form-floating mb-3">
                <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
                <label for="email">Email</label>
              </div>
            </div>
            <div class="col-md-6">
              <div class="form-floating mb-3">
                <input type="text" class="form-control" id="contact" name="contact" placeholder="Contact Number" required>
                <label for="contact">Contact Number</label>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-md-6">
              <div class="form-floating mb-3">
                <input type="date" class="form-control" id="dob" name="dob" required>
                <label for="dob">Date of Birth</label>
              </div>
            </div>
            <div class="col-md-6">
              <div class="form-floating mb-3">
                <input type="text" class="form-control" id="course" name="course" placeholder="Course" required>
                <label for="course">Course</label>
              </div>
            </div>
          </div>

          <div class="form-floating mb-3">
            <input type="text" class="form-control" id="address" name="address" placeholder="Address" required>
            <label for="address">Address</label>
          </div>

          <div class="row">
            <div class="col-md-6">
              <div class="form-floating mb-3">
                <input type="password" class="form-control" id="password" name="password" placeholder="Password" required oninput="checkPasswordStrength()">
                <label for="password">Password</label>
                <div class="progress password-strength">
                  <div class="progress-bar" id="passwordStrength"></div>
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="form-floating mb-3">
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required>
                <label for="confirmPassword">Confirm Password</label>
                <div id="passwordMatch" class="small text-muted"></div>
              </div>
            </div>
          </div>

          <div class="form-check mb-4">
            <input class="form-check-input" type="checkbox" id="terms" required>
            <label class="form-check-label" for="terms">
              I agree to the <a href="#" class="text-decoration-none">Terms and Conditions</a>
            </label>
          </div>

          <button type="submit" class="btn btn-primary w-100 btn-lg mb-3">Register Now</button>

          <div class="text-center">
            <p>Already have an account? <a href="login.jsp" class="text-decoration-none">Sign in</a></p>
          </div>
        </form>

        <div class="footer-links">
          <a href="#">About</a>
          <a href="#">Privacy</a>
          <a href="#">Terms</a>
          <a href="#">Help</a>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  function checkPasswordStrength() {
    const password = document.getElementById('password').value;
    const strengthBar = document.getElementById('passwordStrength');

    // Reset strength bar
    strengthBar.className = 'progress-bar';

    if (password.length === 0) {
      return;
    }

    // Calculate strength
    let strength = 0;
    if (password.length >= 8) strength++;
    if (password.match(/[a-z]/)) strength++;
    if (password.match(/[A-Z]/)) strength++;
    if (password.match(/[0-9]/)) strength++;
    if (password.match(/[^a-zA-Z0-9]/)) strength++;

    // Update strength bar
    if (strength <= 2) {
      strengthBar.classList.add('strength-weak');
    } else if (strength <= 4) {
      strengthBar.classList.add('strength-medium');
    } else {
      strengthBar.classList.add('strength-strong');
    }
  }

  function validateForm() {
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    const terms = document.getElementById('terms').checked;

    // Check password match
    if (password !== confirmPassword) {
      document.getElementById('passwordMatch').innerHTML = '<span class="text-danger">Passwords do not match</span>';
      document.getElementById('confirmPassword').focus();
      return false;
    } else {
      document.getElementById('passwordMatch').innerHTML = '<span class="text-success">Passwords match</span>';
    }

    // Check terms agreement
    if (!terms) {
      alert("Please agree to the terms and conditions");
      return false;
    }

    return true;
  }

  // Live password match checking
  document.getElementById('confirmPassword').addEventListener('input', function() {
    const password = document.getElementById('password').value;
    const confirmPassword = this.value;

    if (confirmPassword.length === 0) {
      document.getElementById('passwordMatch').textContent = '';
    } else if (password === confirmPassword) {
      document.getElementById('passwordMatch').innerHTML = '<span class="text-success">Passwords match</span>';
    } else {
      document.getElementById('passwordMatch').innerHTML = '<span class="text-danger">Passwords do not match</span>';
    }
  });
</script>
</body>
</html>