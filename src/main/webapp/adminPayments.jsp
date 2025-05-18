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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .sidebar { background-color: #343a40; min-height: 100vh; color: white; }
        .sidebar .nav-link { color: rgba(255, 255, 255, 0.8); margin-bottom: 5px; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            color: white; background-color: rgba(255, 255, 255, 0.1);
        }
        .sidebar .nav-link i { margin-right: 10px; }
    </style>
</head>
<body class="bg-light">

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3 col-lg-2 d-md-block sidebar">
            <div class="text-center py-4">
                <h4>Meta Tutor Admin</h4>
            </div>
            <ul class="nav flex-column px-3">
                <li class="nav-item">
                    <a class="nav-link text-white" href="adminDashboard.jsp">
                        <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="StudentManagement.jsp">
                        <i class="fas fa-users me-2"></i> Students
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="TutorManagementServlet?action=viewTutors">
                        <i class="fas fa-chalkboard-teacher me-2"></i> Tutors
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="courseManagement.jsp">
                        <i class="fas fa-book me-2"></i> Courses
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white active" href="adminPayments.jsp">
                        <i class="fas fa-credit-card me-2"></i> Payments
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="logout.jsp">
                        <i class="fas fa-sign-out-alt me-2"></i> Logout
                    </a>
                </li>
            </ul>
        </div>

        <!-- Main Content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <h2 class="mb-4 text-primary">Payment History</h2>

            <!-- Session Alerts -->
            <%
                String msg = (String) session.getAttribute("message");
                String err = (String) session.getAttribute("error");
                if (msg != null) {
            %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= msg %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <%
                    session.removeAttribute("message");
                }
                if (err != null) {
            %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= err %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <%
                    session.removeAttribute("error");
                }
            %>

            <div class="table-responsive">
                <table class="table table-bordered table-striped align-middle">
                    <thead class="table-dark">
                    <tr>
                        <th>Username</th>
                        <th>Course ID</th>
                        <th>Course Name</th>
                        <th>Method</th>
                        <th>Amount</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% if (payments == null || payments.isEmpty()) { %>
                    <tr><td colspan="8" class="text-center text-muted">No payment records found.</td></tr>
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
                        <td>
                            <form action="RevertPaymentServlet" method="post" style="display:inline;">
                                <input type="hidden" name="username" value="<%= p.getUsername() %>">
                                <input type="hidden" name="courseId" value="<%= p.getCourseId() %>">
                                <button type="submit" class="btn btn-sm btn-warning"
                                        onclick="return confirm('Return this payment and mark course unpaid?')">
                                    Return Money
                                </button>
                            </form>
                        </td>
                    </tr>
                    <% }} %>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
