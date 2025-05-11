<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify OTP - MetaTutor</title>
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
            --weak-color: #dc3545;
            --medium-color: #ffc107;
            --strong-color: #28a745;
        }

        body {
            background-color: var(--secondary-color);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
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

        .verify-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        .verify-card {
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

        .input-group-text {
            background-color: transparent;
            border-left: none;
            cursor: pointer;
        }

        .input-group .form-control {
            border-right: none;
        }

        .input-group .form-control:focus + .input-group-text {
            border-color: var(--primary-color);
        }

        .password-toggle {
            color: var(--text-muted);
            transition: color var(--transition-speed) ease;
        }

        .password-toggle:hover {
            color: var(--primary-color);
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

        .otp-input {
            letter-spacing: 2px;
            font-size: 1.2rem;
            text-align: center;
        }

        /* New password strength styles */
        .password-strength {
            height: 4px;
            width: 100%;
            background-color: #e9ecef;
            margin-top: 0.5rem;
            border-radius: 2px;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            width: 0;
            transition: width var(--transition-speed) ease, background-color var(--transition-speed) ease;
        }

        .password-feedback {
            font-size: 0.8rem;
            margin-top: 0.25rem;
            height: 1rem;
        }

        .password-match {
            color: var(--strong-color);
        }

        .password-mismatch {
            color: var(--weak-color);
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
            <a href="forgot_password.jsp" class="back-btn" aria-label="Return to forgot password page">
                <i class="fas fa-arrow-left me-2" aria-hidden="true"></i>Back
            </a>
        </div>
    </div>
</nav>

<div class="verify-container">
    <div class="verify-card">
        <div aria-hidden="true" class="text-center mb-4">
            <i class="fas fa-shield-alt" style="font-size: 2.5rem; color: var(--primary-color);"></i>
        </div>
        <h1 class="card-title">Verify Your Identity</h1>
        <p class="card-subtitle">Enter the OTP sent to your email and create a new password</p>

        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger" role="alert">
            <i class="fas fa-exclamation-circle me-2" aria-hidden="true"></i>
            <span><%= request.getAttribute("error") %></span>
        </div>
        <% } %>

        <form action="VerifyOTPServlet" method="post" id="verifyForm">
            <div class="mb-4">
                <label for="otp" class="form-label fw-semibold">Verification Code (OTP)</label>
                <input type="text" id="otp" name="otp" class="form-control otp-input" required
                       placeholder="Enter 6-digit code" maxlength="6" pattern="\d{6}"
                       title="Please enter a 6-digit number">
            </div>

            <div class="mb-4">
                <label for="newPassword" class="form-label fw-semibold">New Password</label>
                <div class="input-group">
                    <input type="password" id="newPassword" name="newPassword" class="form-control" required
                           placeholder="Enter your password">
                    <span class="input-group-text password-toggle" id="toggleNewPassword">
                            <i class="fas fa-eye"></i>
                        </span>
                </div>
                <div class="password-strength">
                    <div class="password-strength-bar" id="passwordStrengthBar"></div>
                </div>
                <div class="password-feedback" id="passwordStrengthText"></div>
                <div class="form-text mt-1">Minimum 8 characters with at least 1 number</div>
            </div>

            <div class="mb-4">
                <label for="confirmPassword" class="form-label fw-semibold">Confirm Password</label>
                <div class="input-group">
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required
                           placeholder="Confirm your password">
                    <span class="input-group-text password-toggle" id="toggleConfirmPassword">
                            <i class="fas fa-eye"></i>
                        </span>
                </div>
                <div class="password-feedback" id="passwordMatchText"></div>
            </div>

            <button type="submit" class="btn btn-primary w-100 mb-3">
                <i class="fas fa-sync-alt me-2" aria-hidden="true"></i>Reset Password
            </button>
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
    document.addEventListener('DOMContentLoaded', function() {
        // Password toggle functionality
        const toggleNewPassword = document.getElementById('toggleNewPassword');
        const toggleConfirmPassword = document.getElementById('toggleConfirmPassword');
        const newPassword = document.getElementById('newPassword');
        const confirmPassword = document.getElementById('confirmPassword');

        toggleNewPassword.addEventListener('click', function() {
            const icon = this.querySelector('i');
            if (newPassword.type === 'password') {
                newPassword.type = 'text';
                icon.classList.replace('fa-eye', 'fa-eye-slash');
            } else {
                newPassword.type = 'password';
                icon.classList.replace('fa-eye-slash', 'fa-eye');
            }
        });

        toggleConfirmPassword.addEventListener('click', function() {
            const icon = this.querySelector('i');
            if (confirmPassword.type === 'password') {
                confirmPassword.type = 'text';
                icon.classList.replace('fa-eye', 'fa-eye-slash');
            } else {
                confirmPassword.type = 'password';
                icon.classList.replace('fa-eye-slash', 'fa-eye');
            }
        });

        // Form submission feedback
        const form = document.getElementById('verifyForm');
        form.addEventListener('submit', function(e) {
            const btn = this.querySelector('button[type="submit"]');
            btn.disabled = true;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2" aria-hidden="true"></i>Processing...';

            // Simple password match validation
            if (newPassword.value !== confirmPassword.value) {
                e.preventDefault();
                alert('Passwords do not match!');
                btn.disabled = false;
                btn.innerHTML = '<i class="fas fa-sync-alt me-2" aria-hidden="true"></i>Reset Password';
            }
        });

        // OTP input formatting
        const otpInput = document.getElementById('otp');
        otpInput.addEventListener('input', function() {
            this.value = this.value.replace(/\D/g, '');
        });

        // Password strength checker
        function checkPasswordStrength() {
            const password = newPassword.value;
            const strengthBar = document.getElementById('passwordStrengthBar');
            const strengthText = document.getElementById('passwordStrengthText');

            // Reset
            strengthBar.style.width = '0%';
            strengthBar.style.backgroundColor = 'transparent';
            strengthText.textContent = '';

            if (password.length === 0) return;

            // Calculate strength
            let strength = 0;

            // Length check
            if (password.length >= 8) strength += 1;
            if (password.length >= 12) strength += 1;

            // Complexity checks
            if (/[A-Z]/.test(password)) strength += 1;
            if (/\d/.test(password)) strength += 1;
            if (/[^A-Za-z0-9]/.test(password)) strength += 1;

            // Determine strength level
            let width, color, text;
            if (strength <= 2) {
                width = '33%';
                color = 'var(--weak-color)';
                text = 'Weak password';
            } else if (strength <= 4) {
                width = '66%';
                color = 'var(--medium-color)';
                text = 'Medium strength';
            } else {
                width = '100%';
                color = 'var(--strong-color)';
                text = 'Strong password';
            }

            // Update UI
            strengthBar.style.width = width;
            strengthBar.style.backgroundColor = color;
            strengthText.textContent = text;
            strengthText.style.color = color;

            // Also check password match
            checkPasswordMatch();
        }

        // Password match checker
        function checkPasswordMatch() {
            const password = newPassword.value;
            const confirm = confirmPassword.value;
            const matchText = document.getElementById('passwordMatchText');

            if (confirm.length === 0) {
                matchText.textContent = '';
                return;
            }

            if (password === confirm) {
                matchText.textContent = 'Passwords match';
                matchText.className = 'password-feedback password-match';
            } else {
                matchText.textContent = 'Passwords do not match';
                matchText.className = 'password-feedback password-mismatch';
            }
        }

        // Add event listeners
        newPassword.addEventListener('input', checkPasswordStrength);
        confirmPassword.addEventListener('input', checkPasswordMatch);
    });
</script>
</body>
</html>