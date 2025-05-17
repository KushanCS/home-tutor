<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String courseId = request.getParameter("courseId");
    session.setAttribute("paymentCourseId", courseId);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Choose Payment Method - MetaTutor</title>
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

        .navbar {
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .nav-link {
            font-weight: 500;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
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

        .payment-option {
            display: flex;
            align-items: center;
            padding: 1rem;
            margin-bottom: 1rem;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .payment-option:hover {
            border-color: var(--primary-color);
            background-color: rgba(86, 36, 208, 0.05);
        }

        .payment-option.selected {
            border-color: var(--primary-color);
            background-color: rgba(86, 36, 208, 0.1);
        }

        .payment-icon {
            font-size: 1.5rem;
            color: var(--primary-color);
            margin-right: 1rem;
            width: 40px;
            text-align: center;
        }

        .payment-details {
            flex-grow: 1;
        }

        .payment-title {
            font-weight: 600;
            margin-bottom: 0.25rem;
        }

        .payment-description {
            color: #666;
            font-size: 0.9rem;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            padding: 0.75rem;
            font-weight: 600;
        }

        .btn-primary:hover {
            background-color: #4a1fc0;
            border-color: #4a1fc0;
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
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
            <h3 class="m-0"><i class="fas fa-lock me-2"></i>Secure Payment</h3>
        </div>

        <div class="payment-body">
            <h5 class="mb-4">Select payment method</h5>

            <form action="ProcessPaymentServlet" method="post" id="paymentForm">
                <!-- Bank Transfer Option -->
                <div class="payment-option" onclick="selectPayment('bank')">
                    <div class="payment-icon">
                        <i class="fas fa-university"></i>
                    </div>
                    <div class="payment-details">
                        <div class="payment-title">Bank Transfer</div>
                        <div class="payment-description">Direct transfer from your bank account</div>
                    </div>
                    <input type="radio" name="paymentMethod" value="bank" id="bank" required hidden>
                </div>

                <!-- Card Payment Option -->
                <div class="payment-option" onclick="selectPayment('card')">
                    <div class="payment-icon">
                        <i class="far fa-credit-card"></i>
                    </div>
                    <div class="payment-details">
                        <div class="payment-title">Credit/Debit Card</div>
                        <div class="payment-description">Visa, Mastercard, American Express</div>
                    </div>
                    <input type="radio" name="paymentMethod" value="card" id="card" hidden>
                </div>

                <div class="d-grid mt-4">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-arrow-right me-2"></i>Continue to Payment
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function selectPayment(method) {
        // Remove selected class from all options
        document.querySelectorAll('.payment-option').forEach(option => {
            option.classList.remove('selected');
        });

        // Add selected class to clicked option
        event.currentTarget.classList.add('selected');

        // Set the radio button as checked
        document.getElementById(method).checked = true;
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>