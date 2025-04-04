<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Portal - Login or Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f2f5;
        }
        .fb-logo {
            font-size: 3rem;
            color: #1877f2;
            font-weight: bold;
        }
        .subheading {
            font-size: 1.5rem;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }
        .form-control {
            border-radius: 6px;
        }
        .btn-primary {
            background-color: #1877f2;
            border-color: #1877f2;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center align-items-center">
        <!-- LEFT SIDE (Register) -->
        <div class="col-md-6 mb-4">
            <div class="text-center text-md-start">
                <div class="fb-logo mb-3">Meta Tutor</div>
                <div class="subheading mb-4">Connect with your future.</div>

                <% String error = (String) request.getAttribute("error"); %>
                <% if (error != null) { %>
                <div class="alert alert-danger"><%= error %></div>
                <% } %>
                <% String message = (String) request.getAttribute("message"); %>
                <% if (message != null) { %>
                <div class="alert alert-success"><%= message %></div>
                <% } %>

                <div class="card p-4">
                    <h5 class="mb-3">Create an Account</h5>
                    <form action="login" method="post" onsubmit="return validatePasswords()">
                        <input type="hidden" name="action" value="register">
                        <div class="mb-2">
                            <input type="text" name="username" class="form-control" placeholder="Username" required>
                        </div>
                        <div class="mb-2">
                            <input type="password" id="password" name="password" class="form-control" placeholder="Password" required>
                        </div>
                        <div class="mb-2">
                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Confirm Password" required>
                        </div>
                        <div class="mb-2">
                            <input type="text" name="fullName" class="form-control" placeholder="Full Name" required>
                        </div>
                        <div class="mb-2">
                            <input type="email" name="email" class="form-control" placeholder="Email" required>
                        </div>
                        <div class="mb-2">
                            <input type="text" name="course" class="form-control" placeholder="Course" required>
                        </div>
                        <div class="mb-2">
                            <input type="text" name="address" class="form-control" placeholder="Address" required>
                        </div>
                        <div class="mb-2">
                            <input type="date" name="dob" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <input type="text" name="contact" class="form-control" placeholder="Contact Number" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Sign Up</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- RIGHT SIDE (Login) -->
        <div class="col-md-4">
            <div class="card p-4">
                <h5 class="mb-3 text-center">Log in to Student Portal</h5>
                <form action="login" method="post">
                    <input type="hidden" name="action" value="login">
                    <div class="mb-3">
                        <input type="text" name="username" class="form-control" placeholder="Username or Student ID" required>
                    </div>
                    <div class="mb-3">
                        <input type="password" name="password" class="form-control" placeholder="Password" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Log In</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function validatePasswords() {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (password !== confirmPassword) {
            alert("Passwords do not match. Please re-enter.");
            return false;
        }
        return true;
    }
</script>
</body>
</html>