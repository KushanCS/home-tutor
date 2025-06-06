<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Reset your MetaTutor account password">
    <title>Forgot Password - MetaTutor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #5624d0;
            --primary-light: #f0ebff;
            --secondary-color: #f7f9fa;
            --accent-color: #a435f0;
            --text-muted: #6c757d;
            --transition-speed: 0.3s;
        }

        body {
            background-color: var(--secondary-color);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            line-height: 1.6;
        }

        .logo {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-color);
            text-decoration: none;
            display: inline-block;
            transition: color var(--transition-speed) ease;
        }

        .logo:hover {
            color: var(--accent-color);
        }

        .navbar {
            width: 100%;
            padding: 1rem 2rem;
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .back-btn {
            color: var(--primary-color);
            font-weight: 500;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            transition: all var(--transition-speed) ease;
            padding: 0.5rem 1rem;
            border-radius: 8px;
        }

        .back-btn:hover {
            color: var(--accent-color);
            background-color: var(--primary-light);
            transform: translateX(-3px);
        }

        .login-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        .login-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            padding: 2.5rem;
            background-color: white;
            width: 100%;
            max-width: 450px;
            animation: fadeIn 0.5s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .card-title {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 1rem;
            text-align: center;
        }

        .card-subtitle {
            color: var(--text-muted);
            font-size: 0.95rem;
            margin-bottom: 2rem;
            text-align: center;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            padding: 0.75rem;
            font-weight: 500;
            border-radius: 8px;
            transition: all var(--transition-speed) ease;
        }

        .btn-primary:hover {
            background-color: var(--accent-color);
            border-color: var(--accent-color);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(86, 36, 208, 0.25);
        }

        .btn-primary:active {
            transform: translateY(0);
        }

        .form-control {
            padding: 0.75rem 1rem;
            border-radius: 8px;
            border: 1px solid #e1e1e1;
            transition: all var(--transition-speed) ease;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(86, 36, 208, 0.15);
        }

        .footer-links {
            text-align: center;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid #eee;
        }

        .footer-links a {
            color: var(--text-muted);
            text-decoration: none;
            margin: 0 0.5rem;
            font-size: 0.85rem;
            transition: color var(--transition-speed) ease;
        }

        .footer-links a:hover {
            color: var(--primary-color);
            text-decoration: underline;
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
            transition: color var(--transition-speed) ease;
        }

        .remember-password {
            display: inline-flex;
            align-items: center;
            color: var(--primary-color);
            font-weight: 500;
            text-decoration: none;
            transition: all var(--transition-speed) ease;
            padding: 0.5rem;
            border-radius: 6px;
        }

        .remember-password:hover {
            color: var(--accent-color);
            background-color: var(--primary-light);
            text-decoration: none;
        }

        .alert {
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light">
    <div class="container-fluid">
        <a href="home-page.jsp" class="logo" aria-label="MetaTutor Home">
            <i class="fas fa-graduation-cap me-2" aria-hidden="true"></i>MetaTutor
        </a>
        <div class="d-flex align-items-center">
            <a href="loginTutor.jsp" class="back-btn" aria-label="Return to login page">
                <i class="fas fa-arrow-left me-2" aria-hidden="true"></i>Return to Login
            </a>
        </div>
    </div>
</nav>

<div class="login-container">
    <div class="login-card">
        <div aria-hidden="true" class="text-center mb-4">
            <i class="fas fa-key" style="font-size: 2.5rem; color: var(--primary-color);"></i>
        </div>
        <h1 class="card-title">Reset Your Password</h1>
        <p class="card-subtitle">Enter your registered email address and we'll send you a secure link to reset your password.</p>

        <% String status = request.getParameter("status"); %>
        <% if ("notfound".equals(status)) { %>
        <div class="alert alert-danger" role="alert">
            <i class="fas fa-exclamation-circle me-2" aria-hidden="true"></i>
            <span>We couldn't find an account with that email. Please try again.</span>
        </div>
        <% } else if ("sent".equals(status)) { %>
        <div class="alert alert-success" role="alert">
            <i class="fas fa-check-circle me-2" aria-hidden="true"></i>
            <span>Password reset email sent! Check your inbox for instructions.</span>
        </div>
        <% } %>

        <form action="ForgotPasswordServlet" method="post" id="passwordResetForm">
            <div class="mb-4">
                <label for="email" class="form-label fw-semibold">Email Address</label>
                <div class="input-icon">
                    <input type="email" id="email" name="email" class="form-control" required
                           placeholder="your.email@example.com" autocomplete="email">
                    <i class="fas fa-envelope" aria-hidden="true"></i>
                </div>
                <div class="form-text mt-1">Enter the email you used when registering</div>
            </div>

            <button type="submit" class="btn btn-primary w-100 mb-3">
                <i class="fas fa-paper-plane me-2" aria-hidden="true"></i>Send Reset Link
            </button>

            <div class="text-center mt-3">
                <a href="loginTutor.jsp" class="remember-password">
                    <i class="fas fa-sign-in-alt me-1" aria-hidden="true"></i>Remember your password? Sign in
                </a>
            </div>
        </form>

        <div class="footer-links">
            <a href="#" aria-label="Help Center">Help Center</a>
            <a href="#" aria-label="Privacy Policy">Privacy Policy</a>
            <a href="#" aria-label="Terms of Service">Terms of Service</a>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Enhanced form interactions
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('passwordResetForm');
        const emailInput = document.getElementById('email');
        const emailIcon = document.querySelector('.input-icon i');

        // Input focus effects
        emailInput.addEventListener('focus', function() {
            emailIcon.style.color = 'var(--primary-color)';
            this.parentElement.style.borderColor = 'var(--primary-color)';
        });

        emailInput.addEventListener('blur', function() {
            emailIcon.style.color = 'var(--text-muted)';
            this.parentElement.style.borderColor = '#e1e1e1';
        });

        // Form submission feedback
        form.addEventListener('submit', function(e) {
            const btn = this.querySelector('button[type="submit"]');
            btn.disabled = true;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2" aria-hidden="true"></i>Sending...';
        });

        // Add subtle pulse animation to card for attention
        setTimeout(() => {
            document.querySelector('.login-card').style.animation = 'pulse 2s ease-in-out';
        }, 1000);
    });
</script>
</body>
</html>