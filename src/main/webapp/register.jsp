<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Student Portal - Register</title>

  <!-- Bootstrap and Font Awesome CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

  <!-- Custom CSS Variables and Styling -->
  <style>
    :root {
      --primary-color: #5624d0;
      --secondary-color: #f7f9fa;
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
      background-color: white;
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

    /* Password strength bar styles */
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

    /* Footer links styling */
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

<!-- Registration Card Container -->
<div class="container">
  <div class="row justify-content-center">
    <div class="col-lg-8">

      <!-- Logo and Tagline -->
      <div class="text-center mb-5">
        <a href="home-page.jsp" class="logo text-decoration-none text-var">Meta Tutor</a>
        <div class="tagline">Start your learning journey today</div>
      </div>

      <!-- Display server-side error message if present -->
      <% String error = (String) request.getAttribute("error"); %>
      <% if (error != null) { %>
      <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <%= error %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
      <% } %>

      <!-- Display server-side success message if present -->
      <% String message = (String) request.getAttribute("message"); %>
      <% if (message != null) { %>
      <div class="alert alert-success alert-dismissible fade show" role="alert">
        <%= message %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
      <% } %>

      <!-- Registration Form -->
      <div class="register-card">
        <h3 class="text-center mb-4">Create Your Account</h3>

        <form action="register" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
          <input type="hidden" name="action" value="register">

          <!-- Name and Username -->
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

          <!-- Email and Contact -->
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

          <!-- DOB and Course -->
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

          <!-- Address -->
          <div class="form-floating mb-3">
            <input type="text" class="form-control" id="address" name="address" placeholder="Address" required>
            <label for="address">Address</label>
          </div>

          <!-- Password and Confirm Password -->
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

          <!-- Profile Picture Upload -->
          <div class="mb-4">
            <label for="profilePic" class="form-label">Profile Picture</label>
            <input class="form-control" type="file" id="profilePic" name="profilePic" accept="image/*" required onchange="previewImage(event)">
            <img id="preview" src="#" alt="Preview" class="mt-3" style="max-height:150px; display:none;"/>
          </div>

          <!-- Terms and Conditions -->
          <div class="form-check mb-4">
            <input class="form-check-input" type="checkbox" id="terms" required>
            <label class="form-check-label" for="terms">
              I agree to the <a href="#" class="text-decoration-none">Terms and Conditions</a>
            </label>
          </div>

          <!-- Submit Button -->
          <button type="submit" class="btn btn-primary w-100 btn-lg mb-3">Register Now</button>

          <!-- Login Redirect -->
          <div class="text-center">
            <p>Already have an account? <a href="login.jsp" class="text-decoration-none">Sign in</a></p>
          </div>
        </form>

        <!-- Footer Links -->
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

<!-- JavaScript: Password Strength, Preview & Form Validation -->
<script>
  // Show password strength indicator
  function checkPasswordStrength() {
    const password = document.getElementById('password').value;
    const strengthBar = document.getElementById('passwordStrength');
    strengthBar.className = 'progress-bar';

    if (password.length === 0) return;

    let strength = 0;
    if (password.length >= 8) strength++;
    if (/[a-z]/.test(password)) strength++;
    if (/[A-Z]/.test(password)) strength++;
    if (/[0-9]/.test(password)) strength++;
    if (/[^a-zA-Z0-9]/.test(password)) strength++;

    if (strength <= 2) {
      strengthBar.classList.add('strength-weak');
    } else if (strength <= 4) {
      strengthBar.classList.add('strength-medium');
    } else {
      strengthBar.classList.add('strength-strong');
    }
  }

  // Show preview of uploaded image
  function previewImage(e) {
    const reader = new FileReader();
    reader.onload = function () {
      const img = document.getElementById('preview');
      img.src = reader.result;
      img.style.display = 'block';
    };
    reader.readAsDataURL(e.target.files[0]);
  }

  // Validate form fields before submission
  function validateForm() {
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    const terms = document.getElementById('terms').checked;

    if (password !== confirmPassword) {
      document.getElementById('passwordMatch').innerHTML = '<span class="text-danger">Passwords do not match</span>';
      document.getElementById('confirmPassword').focus();
      return false;
    } else {
      document.getElementById('passwordMatch').innerHTML = '<span class="text-success">Passwords match</span>';
    }

    if (!terms) {
      alert("Please agree to the Terms and Conditions.");
      return false;
    }

    return true;
  }
</script>
</body>
</html>
