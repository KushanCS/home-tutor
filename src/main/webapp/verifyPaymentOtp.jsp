<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String error = request.getParameter("error");
    String maskedCard = (String) session.getAttribute("maskedCard");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Verify OTP - MetaTutor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5" style="max-width: 500px;">
    <div class="card shadow">
        <div class="card-header text-white bg-primary">
            <h5 class="m-0">OTP Verification</h5>
        </div>
        <div class="card-body">
            <p>We've sent an OTP to your registered phone number to verify your card <strong><%= maskedCard != null ? maskedCard : "" %></strong>.</p>

            <% if ("invalid".equals(error)) { %>
            <div class="alert alert-danger">Invalid OTP. Please try again.</div>
            <% } %>

            <form action="ValidatePaymentOtpServlet" method="post">
                <div class="mb-3">
                    <label for="otp" class="form-label">Enter OTP</label>
                    <input type="text" name="otp" id="otp" class="form-control" required pattern="[0-9]{4}" placeholder="4-digit code">
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-success">Confirm Payment</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
