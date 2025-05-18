<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Page Metadata -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Reset your MetaTutor account password">
    <title>Forgot Password - MetaTutor</title>

    <!-- Bootstrap & FontAwesome CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- Page Styling -->
    <style>
        /* Define color and animation variables for consistent theme */
        :root {
            --primary-color: #5624d0;
            --primary-light: #f0ebff;
            --secondary-color: #f7f9fa;
            --accent-color: #a435f0;
            --text-muted: #6c757d;
            --transition-speed: 0.3s;
        }

        /* General Body Styling */
        body {
            background-color: var(--secondary-color);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* Navigation Bar Styles */
        .navbar {
            padding: 1rem 2rem;
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .logo {
            font-size: 2rem;
            font-weight: bold;
            color: var(--primary-color);
            text-decoration: none;
        }

        .logo:hover {
            color: var(--accent-color);
        }

        /* Back to login button */
        .back-btn {
            color: var(--primary-color);
            font-weight: 500;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
        }

        .back-btn:hover {
            color: var(--accent-color);
            background-color: var(--primary-light);
            transform: translateX(-3px);
        }

        /* Main Container Styling */
        .login-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        .login-card {
            background-color: white;
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            width: 100%;
            max-width: 450px;
            animation: fadeIn 0.5s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Typography */
        .card-title {
            color: var(--primary-color);
            font-weight: 600;
            text-align: center;
        }

        .card-subtitle {
            color: var(--text-muted);
            text-align: center;
            font-size: 0.95rem;
            margin-bottom: 2rem;
        }

        /* Form and Button Styling */
        .form-control {
            padding: 0.75rem 1rem;
            border-radius: 8px;
            border: 1px solid #e1e1e1;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(86, 36, 208, 0.15);
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            padding: 0.75rem;
            font-weight: 500;
            border-radius: 8px;
        }

        .btn-primary:hover {
            background-color: var(--accent-color);
            border-color: var(--accent-color);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(86, 36, 208, 0.25);
        }

        .input-icon {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .input-icon i {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
        }

        /* Message/Alert Boxes */
        .alert {
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1.5rem;
        }

        /* Footer Links */
        .footer-links {
            text-align: center;
            margin-top: 2rem;
            border-top: 1px solid #eee;
            padding-top: 1.5rem;
        }

        .footer-links a {
            color: var(--text-muted);
            text-decoration: none;
            margin: 0 0.5rem;
        }

        .footer-links a:hover {
            color: var(--primary-color);
            text-decoration: underline;
        }
    </style>
</head>
<body>

<!-- Navbar with Logo and Return to Login Button -->
<nav class="navbar navbar-expand-lg navbar-light">
    <div class="container-fluid">
        <a href="home-page.jsp" class="logo"><i class="fas fa-graduation-cap me-2"></i>MetaTutor</a>
        <div class="d-flex align-items-center">
            <a href="loginTutor.jsp" class="back-btn"><i class="fas fa-arrow-left me-2"></i>Return to Login</a>
        </div>
    </div>
</nav>

<!-- Password Reset Card -->
<div class="login-container">
    <div class="login-card">
        <div class="text-center mb-4">
            <i class="fas fa-key" style="font-size: 2.5rem; color: var(--primary-color);"></i>
        </div>
        <h1 class="card-title">Reset Your Password</h1>
        <p class="card-subtitle">Enter your registered email address and we'll send you a secure link to reset your password.</p>

        <!-- Alert Section for Status Feedback -->
        <%
            String status = request.getParameter("status");
            if ("notfound".equals(status)) {
        %>
        <div class="alert alert-danger" role="alert">
            <i class="fas fa-exclamation-circle me-2"></i>
            We couldn't find an account with that email. Please try again.
        </div>
        <% } else if ("sent".equals(status)) { %>
        <div class="alert alert-success" role="alert">
            <i class="fas fa-check-circle me-2"></i>
            Password reset email sent! Check your inbox.
        </div>
        <% } %>

        <!-- Password Reset Form -->
        <form action="ForgotPasswordServlet" method="post" id="passwordResetForm">
            <div class="mb-4">
                <label for="email" class="form-label fw-semibold">Email Address</label>
                <div class="input-icon">
                    <input type="email" id="email" name="email" class="form-control" required placeholder="your.email@example.com" autocomplete="email">
                    <i class="fas fa-envelope"></i>
                </div>
                <div class="form-text">Enter the email you used when registering</div>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary w-100 mb-3">
                <i class="fas fa-paper-plane me-2"></i>Send Reset Link
            </button>

            <!-- Link to Login -->
            <div class="text-center">
                <a href="loginTutor.jsp" class="remember-password">
                    <i class="fas fa-sign-in-alt me-1"></i>Remember your password? Sign in
                </a>
            </div>
        </form>

        <!-- Footer Navigation Links -->
        <div class="footer-links">
            <a href="#">Help Center</a>
            <a href="#">Privacy Policy</a>
            <a href="#">Terms of Service</a>
        </div>
    </div>
</div>

<!-- Bootstrap & Interactive JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // UI Interaction: Input icon color and submit button behavior
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('passwordResetForm');
        const emailInput = document.getElementById('email');
        const emailIcon = document.querySelector('.input-icon i');

        // Change icon color on input focus
        emailInput.addEventListener('focus', function() {
            emailIcon.style.color = 'var(--primary-color)';
        });
        emailInput.addEventListener('blur', function() {
            emailIcon.style.color = 'var(--text-muted)';
        });

        // Show loading spinner when form is submitted
        form.addEventListener('submit', function() {
            const btn = this.querySelector('button[type="submit"]');
            btn.disabled = true;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Sending...';
        });
    });
</script>
</body>
</html>
