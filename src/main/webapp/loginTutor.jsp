<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>

<%-- Alert if tutor account was deleted and redirected back here --%>
<%
    String deleted = request.getParameter("deleted");
    if ("true".equals(deleted)) {
%>
<div class="alert alert-warning text-center">Your profile has been deleted successfully.</div>
<% } %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutor Portal - Login</title>

    <!-- Bootstrap & Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        :root {
            --primary-color: #5624d0;
            --secondary-color: #f7f9fa;
            --accent-color: #a435f0;
        }

        body {
            background-color: var(--secondary-color);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh;
            display: flex;
            align-items: center;
        }

        .logo {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 1rem;
            text-decoration: none;
            display: inline-block;
        }

        .tagline {
            font-size: 1.2rem;
            color: #555;
            margin-bottom: 2rem;
        }

        .login-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            background-color: white;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            padding: 0.5rem;
            font-weight: 500;
        }

        .btn-primary:hover {
            background-color: var(--accent-color);
            border-color: var(--accent-color);
        }

        .btn-outline-primary {
            color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-outline-primary:hover {
            background-color: var(--primary-color);
            color: white;
        }

        .form-control {
            padding: 0.75rem;
            border-radius: 8px;
        }

        .divider {
            display: flex;
            align-items: center;
            text-align: center;
            margin: 1.5rem 0;
            color: #777;
        }

        .divider::before, .divider::after {
            content: "";
            flex: 1;
            border-bottom: 1px solid #ddd;
        }

        .divider::before { margin-right: 1rem; }
        .divider::after { margin-left: 1rem; }

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
    <div class="row justify-content-center align-items-center">

        <!-- Left side visual branding -->
        <div class="col-lg-6 d-none d-lg-block">
            <div class="text-center text-lg-start">
                <a href="home-page.jsp" class="logo">
                    <i class="fas fa-graduation-cap me-2"></i>MetaTutor
                </a>
                <div class="tagline">Your gateway to academic success</div>
                <img src="https://images.unsplash.com/photo-1523050854058-8df90110c9f1?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80"
                     alt="Students learning" class="img-fluid rounded">
            </div>
        </div>

        <!-- Login form column -->
        <div class="col-lg-4 col-md-8">
            <div class="login-card">

                <h3 class="text-center mb-4">Welcome Back!</h3>

                <%-- Show alerts based on query string --%>
                <%
                    String success = request.getParameter("success");
                    String error = request.getParameter("error");
                    if ("true".equals(success)) {
                %>
                <div class="alert alert-success text-center">Registration successful! You can now log in.</div>
                <% } else if ("exists".equals(error)) { %>
                <div class="alert alert-danger text-center">Username already exists!</div>
                <% } else if ("emailexists".equals(error)) { %>
                <div class="alert alert-danger text-center">Email already registered!</div>
                <% } else if ("invalid".equals(error)) { %>
                <div class="alert alert-danger text-center">Invalid username or password.</div>
                <% } %>

                <%-- Server-side forwarded error/message --%>
                <%
                    String attrError = (String) request.getAttribute("error");
                    String attrMessage = (String) request.getAttribute("message");
                    if (attrError != null) {
                %>
                <div class="alert alert-danger"><%= attrError %></div>
                <% } else if (attrMessage != null) { %>
                <div class="alert alert-success"><%= attrMessage %></div>
                <% } %>

                <!-- Login Form Starts -->
                <form action="LoginTutorServlet" method="post">
                    <div class="mb-3">
                        <label for="username" class="form-label">Username or Tutor ID</label>
                        <input type="text" id="username" name="username" class="form-control" required placeholder="Enter your username">
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <div class="input-group">
                            <input type="password" id="password" name="password" class="form-control" required placeholder="Enter your password">
                            <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>
                    <div class="d-flex justify-content-between mb-3">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="rememberMe">
                            <label class="form-check-label" for="rememberMe">Remember me</label>
                        </div>
                        <a href="forgot_password.jsp" class="text-decoration-none">Forgot password?</a>
                    </div>

                    <!-- Submit Login -->
                    <button type="submit" class="btn btn-primary w-100 mb-3">Log In</button>

                    <!-- Divider -->
                    <div class="divider">or</div>

                    <!-- Link to registration -->
                    <a href="add_tutor.jsp" class="btn btn-outline-primary w-100">Create New Account</a>
                </form>

                <!-- Footer Navigation -->
                <div class="footer-links mt-3">
                    <a href="#">About</a>
                    <a href="#">Privacy</a>
                    <a href="#">Terms</a>
                    <a href="#">Help</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- JS: Bootstrap + Password visibility toggle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Toggle password visibility
    document.getElementById('togglePassword').addEventListener('click', function () {
        const input = document.getElementById('password');
        const icon = this.querySelector('i');
        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.replace('fa-eye', 'fa-eye-slash');
        } else {
            input.type = 'password';
            icon.classList.replace('fa-eye-slash', 'fa-eye');
        }
    });
</script>
</body>
</html>
