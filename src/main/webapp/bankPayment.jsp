<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String courseId = request.getParameter("courseId");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bank Payment - MetaTutor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #5624d0;
            --secondary-color: #f7f9fa;
            --accent-color: #a435f0;
            --light-gray: #f5f5f5;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light-gray);
        }

        .payment-container {
            max-width: 500px;
            margin: 2rem auto;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        .payment-header {
            background-color: var(--primary-color);
            color: white;
            padding: 1.5rem;
            text-align: center;
        }

        .payment-body {
            padding: 2rem;
        }

        .form-label {
            font-weight: 600;
            color: #333;
        }

        .form-control {
            padding: 0.75rem;
            border-radius: 8px;
            border: 1px solid #ddd;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(86, 36, 208, 0.1);
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            padding: 0.75rem;
            font-weight: 600;
            border-radius: 8px;
        }

        .btn-primary:hover {
            background-color: #4a1fc0;
            border-color: #4a1fc0;
        }

        .back-link {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            display: inline-block;
            margin-bottom: 1rem;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<!-- Navigation Bar (same as ChoosePaymentMethod.jsp) -->
<nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold" href="home-page.jsp" style="color: var(--primary-color);">
            <i class="fas fa-graduation-cap me-2"></i>MetaTutor
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="course-home.jsp">Courses</a>
                </li>
                <% if (session.getAttribute("username") != null && "student".equals(session.getAttribute("role"))) { %>
                <li class="nav-item">
                    <a class="nav-link" href="MyCoursesServlet"><i class="fas fa-book me-1"></i> My Courses</a>
                </li>
                <% } %>
            </ul>
            <% if (session.getAttribute("username") == null) { %>
            <div class="d-flex">
                <a href="loginOptions.jsp" class="btn btn-outline-primary me-2">Log in</a>
                <a href="register.jsp" class="btn btn-primary">Sign up</a>
            </div>
            <% } else { %>
            <div>
                <span class="me-3" style="font-weight: 500;"><%= session.getAttribute("username") %></span>
                <a href="logout.jsp" class="btn btn-outline-primary">Log out</a>
            </div>
            <% } %>
        </div>
    </div>
</nav>

<div class="container py-5">
    <div class="payment-container">
        <div class="payment-header">
            <h3 class="m-0"><i class="fas fa-university me-2"></i>Bank Transfer</h3>
        </div>

        <div class="payment-body">
            <a href="ChoosePaymentMethod.jsp?courseId=<%= courseId %>" class="back-link">
                <i class="fas fa-arrow-left me-1"></i>Change payment method
            </a>

            <form action="ConfirmPaymentServlet" method="post">
                <input type="hidden" name="courseId" value="<%= courseId %>">
                <input type="hidden" name="method" value="bank">

                <div class="mb-4">
                    <p class="text-muted">Please provide your bank transfer details below. We'll verify your payment within 24 hours.</p>
                </div>

                <div class="mb-3">
                    <label class="form-label">Bank Name</label>
                    <input type="text" class="form-control" name="bankName" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Account Number</label>
                    <input type="text" class="form-control" name="accountNumber" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Account Holder Name</label>
                    <input type="text" class="form-control" name="accountHolder" required>
                </div>

                <div class="mb-4">
                    <label class="form-label">Reference ID / Slip No.</label>
                    <input type="text" class="form-control" name="referenceId" required>
                    <div class="form-text">This is the transaction reference from your bank</div>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-check-circle me-2"></i>Confirm Payment
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>