<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Verify OTP - Reset Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .card { width: 400px; padding: 20px; }
    </style>
</head>
<body>
<div class="card shadow">
    <h4 class="mb-3">Verify OTP</h4>
    <form action="VerifyOTPServlet" method="post">
        <div class="mb-3">
            <label>Enter OTP</label>
            <input type="text" name="otp" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>New Password</label>
            <input type="password" name="newPassword" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Confirm Password</label>
            <input type="password" name="confirmPassword" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary w-100">Reset Password</button>
    </form>
</div>
</body>
</html>
