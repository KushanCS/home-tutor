<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | MetaTutor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #5624d0;
            --secondary-color: #f7f9fa;
            --accent-color: #a435f0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--secondary-color);
        }

        .navbar {
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .login-hero {
            background: linear-gradient(135deg, #5624d0 0%, #a435f0 100%);
            color: white;
            padding: 4rem 0;
            margin-bottom: 3rem;
            border-radius: 0 0 20px 20px;
            position: relative;
            overflow: hidden;
        }

        .login-hero::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('https://images.unsplash.com/photo-1522202176988-66273c2fd55f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1200&q=80') center/cover;
            opacity: 0.15;
        }

        .login-card {
            transition: all 0.3s ease;
            border: none;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
            margin-bottom: 2rem;
            background: white;
        }

        .login-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }

        .card-img-container {
            height: 200px;
            overflow: hidden;
            position: relative;
        }

        .card-img-top {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .login-card:hover .card-img-top {
            transform: scale(1.05);
        }

        .card-body {
            padding: 2rem;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-outline-primary {
            color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-outline-primary:hover {
            background-color: var(--primary-color);
            color: white;
        }

        .btn-outline-success {
            color: var(--accent-color);
            border-color: var(--accent-color);
        }

        .btn-outline-success:hover {
            background-color: var(--accent-color);
            color: white;
        }

        .help-section {
            background-color: white;
            border-radius: 12px;
            padding: 2.5rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .login-icon {
            font-size: 2rem;
            margin-bottom: 1rem;
            color: var(--primary-color);
        }

        .tutor-icon {
            color: var(--accent-color);
        }

        @media (max-width: 768px) {
            .login-hero {
                padding: 3rem 0;
            }

            .card-img-container {
                height: 160px;
            }
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
                <li class="nav-item">
                    <a class="nav-link" href="become_tutor.jsp">Become a Tutor</a>
                </li>
            </ul>
            <div class="d-flex">
                <a href="register.jsp" class="btn btn-primary">Sign up</a>
            </div>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="login-hero">
    <div class="container text-center position-relative">
        <h1 class="display-5 fw-bold mb-3">Welcome Back!</h1>
        <p class="lead fs-4">Continue your learning journey with MetaTutor</p>
    </div>
</section>

<!-- Login Options -->
<div class="container">
    <div class="row justify-content-center">
        <!-- Student Card -->
        <div class="col-lg-5 col-md-6 mb-4">
            <div class="login-card h-100">
                <div class="card-img-container">
                    <img src="https://images.unsplash.com/photo-1523050854058-8df90110c9f1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80"
                         class="card-img-top" alt="Student learning online">
                </div>
                <div class="card-body text-center">
                    <div class="login-icon">
                        <i class="fas fa-user-graduate"></i>
                    </div>
                    <h3 class="card-title mb-3">Student Login</h3>
                    <p class="card-text mb-4">Access your courses, message tutors, and track your learning progress.</p>
                    <a href="login.jsp" class="btn btn-outline-primary btn-lg w-100 py-2">
                        Continue as Student <i class="fas fa-arrow-right ms-2"></i>
                    </a>
                </div>
            </div>
        </div>

        <!-- Tutor Card -->
        <div class="col-lg-5 col-md-6 mb-4">
            <div class="login-card h-100">
                <div class="card-img-container">
                    <img src="https://images.unsplash.com/photo-1503676260728-1c00da094a0b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80"
                         class="card-img-top" alt="Tutor teaching online">
                </div>
                <div class="card-body text-center">
                    <div class="login-icon tutor-icon">
                        <i class="fas fa-chalkboard-teacher"></i>
                    </div>
                    <h3 class="card-title mb-3">Tutor Login</h3>
                    <p class="card-text mb-4">Manage your classes, schedule sessions, and connect with students.</p>
                    <a href="loginTutor.jsp" class="btn btn-outline-success btn-lg w-100 py-2">
                        Continue as Tutor <i class="fas fa-arrow-right ms-2"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Help Section -->
    <div class="row justify-content-center mt-5">
        <div class="col-lg-8">
            <div class="help-section text-center">
                <h4 class="mb-4">Need help logging in?</h4>
                <div class="d-flex flex-wrap justify-content-center gap-3">
                    <a href="#" class="btn btn-outline-secondary px-4">
                        <i class="fas fa-phone me-2"></i>+44 (0) 203 773 6020
                    </a>
                    <a href="#" class="btn btn-outline-secondary px-4">
                        <i class="fas fa-envelope me-2"></i>help@metatutor.com
                    </a>
                    <a href="#" class="btn btn-outline-secondary px-4">
                        <i class="fas fa-question-circle me-2"></i>Help Center
                    </a>
                </div>
                <hr class="my-4">
                <p class="mb-0">Don't have an account? <a href="register.jsp" class="text-primary fw-bold">Sign up now</a></p>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>