<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password - MetaTutor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f6f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .card {
            width: 400px;
            padding: 20px;
        }
    </style>
</head>
<body>
<div class="card shadow">
    <h4 class="text-center mb-4">Forgot Password</h4>

    <%
        String status = request.getParameter("status");
        if ("notfound".equals(status)) {
    %>
    <div class="alert alert-danger">Email not found. Please try again.</div>
    <% } else if ("sent".equals(status)) { %>
    <div class="alert alert-success">OTP sent successfully. Check console for development.</div>
    <% } %>

    <form action="ForgotPasswordServlet" method="post">
        <div class="mb-3">
            <label for="email" class="form-label">Registered Email</label>
            <input type="email" name="email" id="email" class="form-control" placeholder="Enter your email" required>
        </div>
        <button type="submit" class="btn btn-primary w-100">Send OTP</button>
    </form>

    <div class="text-center mt-3">
        <a href="loginTutor.jsp">Back to Login</a>
    </div>
</div>
</body>
</html>
