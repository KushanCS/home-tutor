<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Enroll in Course</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #6c63ff;
            --secondary-color: #4d44db;
            --light-bg: #f8f9fa;
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .enrollment-card {
            max-width: 600px;
            margin: 2rem auto;
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .course-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 1.5rem;
            border-radius: 10px 10px 0 0;
        }

        .price-tag {
            font-size: 1.5rem;
            font-weight: bold;
            color: var(--primary-color);
        }

        .btn-enroll {
            background-color: var(--primary-color);
            border: none;
            padding: 10px 25px;
        }

        .btn-enroll:hover {
            background-color: var(--secondary-color);
        }
    </style>
</head>
<body>
<div class="container py-4">
    <div class="card enrollment-card">
        <div class="course-header text-center">
            <h2><i class="fas fa-graduation-cap me-2"></i>Course Enrollment</h2>
        </div>

        <div class="card-body p-4">
            <div class="mb-4">
                <h4><%= request.getParameter("name") %></h4>
                <p class="text-muted mb-1"><i class="fas fa-user-tie me-2"></i>Tutor: <%= request.getParameter("tutor") %></p>
                <p class="price-tag my-3">$<%= request.getParameter("price") %></p>
                <p><i class="fas fa-clock me-2"></i>Duration: <%= request.getParameter("duration") %></p>
                <div class="alert alert-light mt-3">
                    <p class="mb-0"><%= request.getParameter("description") %></p>
                </div>
            </div>

            <hr>

            <div class="mt-4">
                <h5 class="mb-3">Enrollment Options</h5>
                <div class="d-flex flex-wrap gap-3">
                    <a class="btn btn-enroll btn-primary text-white" href="paynow.jsp">
                        <i class="fas fa-credit-card me-2"></i>Pay Now
                    </a>
                    <button class="btn btn-outline-primary">
                        <i class="fas fa-file-invoice me-2"></i>Get Invoice
                    </button>
                    <button class="btn btn-outline-secondary">
                        <i class="fas fa-share-alt me-2"></i>Share Course
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="js/bootstrap.bundle.min.js"></script>
</body>
</html>