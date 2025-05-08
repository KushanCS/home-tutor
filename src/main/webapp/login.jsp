<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Portal - Login</title>
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
            height: 100vh;
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

        .login-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            padding: 2rem;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            padding: 0.5rem;
            font-weight: 500;
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

        .divider::before {
            margin-right: 1rem;
        }

        .divider::after {
            margin-left: 1rem;
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
    <div class="row justify-content-center align-items-center">
        <!-- Left Side - Branding -->
        <div class="col-lg-6 d-none d-lg-block">
            <div class="text-center text-lg-start">
                <div class="logo">Meta Tutor</div>
                <div class="tagline">Your gateway to academic success</div>
                <img src="https://images.unsplash.com/photo-1523050854058-8df90110c9f1?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80"
                     alt="Students learning" class="img-fluid rounded">
            </div>
        </div>

        <!-- Right Side - Login Form -->
        <div class="col-lg-4 col-md-8">
            <div class="login-card">
                <h3 class="text-center mb-4">Welcome Back!</h3>

                <% String error = (String) request.getAttribute("error"); %>
                <% if (error != null) { %>
                <div class="alert alert-danger"><%= error %></div>
                <% } %>
                <% String message = (String) request.getAttribute("message"); %>
                <% if (message != null) { %>
                <div class="alert alert-success"><%= message %></div>
                <% } %>

                <form action="login" method="post">
                    <input type="hidden" name="action" value="login">
                    <div class="mb-3">
                        <label for="username" class="form-label">Username or Student ID</label>
                        <input type="text" id="username" name="username" class="form-control" placeholder="Enter your username" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <div class="input-group">
                            <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" required>
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
                        <a href="#" class="text-decoration-none">Forgot password?</a>
                    </div>
                    <button type="submit" class="btn btn-primary w-100 mb-3">Log In</button>

                    <div class="divider">or</div>

                    <a href="register.jsp" class="btn btn-outline-primary w-100">
                        Create New Account
                    </a>
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
    // Toggle password visibility
    document.getElementById('togglePassword').addEventListener('click', function() {
        const password = document.getElementById('password');
        const icon = this.querySelector('i');
        if (password.type === 'password') {
            password.type = 'text';
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            password.type = 'password';
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    });
</script>
</body>
</html>