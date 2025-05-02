
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Become a Tutor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            font-family: 'Segoe UI', sans-serif;
        }
        .form-container {
            background: white;
            padding: 2rem 3rem;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            max-width: 700px;
            width: 100%;
        }
        .form-control {
            border-radius: 10px;
            padding: 0.75rem;
        }
        .btn-primary {
            padding: 0.75rem;
            font-weight: 500;
        }
        .form-check-label {
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h3 class="text-center mb-4">Become a Tutor</h3>
    <form action="addTutor" method="post">
        <div class="row g-3">
            <div class="col-md-6">
                <input type="text" name="name" class="form-control" placeholder="Full Name" required>
            </div>
            <div class="col-md-6">
                <input type="text" name="subject" class="form-control" placeholder="Subject Expertise" required>
            </div>
            <div class="col-md-6">
                <input type="email" name="email" class="form-control" placeholder="Email" required>
            </div>
            <div class="col-md-6">
                <input type="text" name="contact" class="form-control" placeholder="Contact Number" required>
            </div>
            <div class="col-12">
                <textarea name="about" class="form-control" rows="3" placeholder="Short Bio/About You..."></textarea>
            </div>
            <div class="col-12 form-check ms-2">
                <input type="checkbox" class="form-check-input" id="agree" required>
                <label class="form-check-label" for="agree">
                    I agree to the <a href="#">Terms and Conditions</a>
                </label>
            </div>
            <div class="col-12">
                <button type="submit" class="btn btn-primary w-100">Register as Tutor</button>
            </div>
        </div>
    </form>
    <div class="text-center mt-3">
        Already a user? <a href="login.jsp">Sign in</a>
    </div>
</div>
</body>
</html>
