<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, payment.model.Payment, payment.utils.PaymentFileUtil" %>
<%
    String paymentPath = application.getRealPath("/WEB-INF/payment.txt");
    List<Payment> payments = PaymentFileUtil.readPayments(paymentPath);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment History - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="mb-4 text-primary">Payment History</h2>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
        <tr>
            <th>Username</th>
            <th>Course ID</th>
            <th>Course Name</th>
            <th>Method</th>
            <th>Amount</th>
            <th>Date</th>
            <th>Status</th>
        </tr>
        </thead>
        <tbody>
        <% if (payments == null || payments.isEmpty()) { %>
        <tr><td colspan="7" class="text-center text-muted">No payment records found.</td></tr>
        <% } else {
            for (Payment p : payments) { %>
        <tr>
            <td><%= p.getUsername() %></td>
            <td><%= p.getCourseId() %></td>
            <td><%= p.getCourseName() %></td>
            <td><%= p.getMethod() %></td>
            <td>$<%= p.getAmount() %></td>
            <td><%= p.getDate() %></td>
            <td><%= p.getStatus() %></td>
        </tr>
        <% }} %>
        </tbody>
    </table>
</div>
</body>
</html>
