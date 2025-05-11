<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MetaTutor - Online Learning Platform</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #5624d0;
            --secondary-color: #f7f9fa;
            --accent-color: #a435f0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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

        .btn-outline-primary {
            color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-outline-primary:hover {
            background-color: var(--primary-color);
        }

        .hero-section {
            background-color: var(--secondary-color);
            padding: 80px 0;
        }

        .course-card {
            transition: transform 0.3s;
            border: none;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .course-card:hover {
            transform: translateY(-5px);
        }

        .course-img {
            height: 160px;
            object-fit: cover;
        }

        .rating {
            color: #f4c150;
        }

        footer {
            background-color: #1c1d1f;
            color: white;
            padding: 40px 0;
        }

        .footer-link {
            color: #cec0fc;
            text-decoration: none;
        }

        .footer-link:hover {
            color: white;
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
                    <a class="nav-link" href="student-course.jsp"><i class="bi bi-collection-play me-1"></i> My Courses</a>
                </li>
            </ul>
            <%
                String user = (String) session.getAttribute("username"); // Assuming username is stored in session
                if (user == null) {
            %>
            <div class="d-flex">
                <a href="login.jsp" class="btn btn-outline-primary me-2">Log in</a>
                <a href="register.jsp" class="btn btn-primary">Sign up</a>
            </div>
            <%
            } else {
            %>
            <div>
                <a href="student.jsp" class="btn btn-primary">Dashboard</a>
                <a href="logout.jsp" class="btn btn-outline-primary">Log out</a>
            </div>
            <%} %>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero-section">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6">
                <h1 class="display-4 fw-bold mb-4">Learn on your schedule</h1>
                <p class="lead mb-4">Study any topic, anytime. Choose from thousands of expert-led courses now.</p>
                <div class="input-group mb-3">
                    <input type="text" class="form-control form-control-lg" placeholder="What do you want to learn?">
                    <button class="btn btn-primary" type="button">Search</button>
                </div>
            </div>
            <div class="col-lg-6 d-none d-lg-block">
                <img src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=80"
                     alt="Learning together" class="img-fluid rounded">
            </div>
        </div>
    </div>
</section>

<!-- Popular Courses Section -->
<section id="courses" class="py-5">
    <div class="container">
        <h2 class="fw-bold mb-5">Popular Courses</h2>
        <div class="row">
            <!-- Course 1 -->
            <div class="col-md-4">
                <div class="card course-card">
                    <img src="https://img-c.udemycdn.com/course/240x135/1565838_e54e_16.jpg" class="card-img-top course-img" alt="Web Development">
                    <div class="card-body">
                        <h5 class="card-title">The Complete Web Development Bootcamp</h5>
                        <p class="text-muted">Dr. Angela Yu</p>
                        <div class="rating mb-2">
                            <span>4.7</span>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star-half-alt"></i>
                            <span class="text-muted">(120,345)</span>
                        </div>
                        <h5 class="text-primary">$12.99</h5>
                    </div>
                </div>
            </div>

            <!-- Course 2 -->
            <div class="col-md-4">
                <div class="card course-card">
                    <img src="https://img-c.udemycdn.com/course/240x135/1362070_b9a1_2.jpg" class="card-img-top course-img" alt="Python Programming">
                    <div class="card-body">
                        <h5 class="card-title">Python for Beginners - Learn Programming</h5>
                        <p class="text-muted">Jose Portilla</p>
                        <div class="rating mb-2">
                            <span>4.6</span>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <span class="text-muted">(98,765)</span>
                        </div>
                        <h5 class="text-primary">$11.99</h5>
                    </div>
                </div>
            </div>

            <!-- Course 3 -->
            <div class="col-md-4">
                <div class="card course-card">
                    <img src="https://img-c.udemycdn.com/course/240x135/625204_436a_3.jpg" class="card-img-top course-img" alt="Digital Marketing">
                    <div class="card-body">
                        <h5 class="card-title">The Complete Digital Marketing Course</h5>
                        <p class="text-muted">Rob Percival</p>
                        <div class="rating mb-2">
                            <span>4.5</span>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star-half-alt"></i>
                            <span class="text-muted">(87,654)</span>
                        </div>
                        <h5 class="text-primary">$10.99</h5>
                    </div>
                </div>
            </div>
        </div>

        <div class="text-center mt-4">
            <a href="#" class="btn btn-outline-primary">View All Courses</a>
        </div>
    </div>
</section>

<!-- About Section -->
<section id="about" class="py-5 bg-light">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6">
                <img src="https://images.unsplash.com/photo-1523240795612-9a054b0db644?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=80"
                     alt="About MetaTutor" class="img-fluid rounded">
            </div>
            <div class="col-lg-6">
                <h2 class="fw-bold mb-4">About MetaTutor</h2>
                <p>MetaTutor is an online learning platform where anyone can discover and take courses across a wide range of subjects. Our mission is to make quality education accessible to everyone, everywhere.</p>
                <p>Whether you want to learn new skills, advance your career, or pursue a passion, LearnHub has courses taught by expert instructors to help you achieve your goals.</p>
                <div class="mt-4">
                    <a href="#" class="btn btn-primary me-2">Learn More</a>
                    <a href="#" class="btn btn-outline-primary">Our Instructors</a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Call to Action -->
<section class="py-5" style="background-color: var(--primary-color); color: white;">
    <div class="container text-center">
        <h2 class="fw-bold mb-3">Start Learning Today</h2>
        <p class="lead mb-4">Join over 10 million learners worldwide</p>
        <a href="signup.html" class="btn btn-light btn-lg px-4">Get Started</a>
    </div>
</section>

<!-- Footer -->
<footer>
    <div class="container">
        <div class="row">
            <div class="col-md-4 mb-4">
                <h5 class="mb-3">LearnHub</h5>
                <p>LearnHub is a leading online learning platform, offering the best courses from expert instructors.</p>
            </div>
            <div class="col-md-2 mb-4">
                <h5 class="mb-3">Company</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="#" class="footer-link">About</a></li>
                    <li class="mb-2"><a href="#" class="footer-link">Careers</a></li>
                    <li class="mb-2"><a href="#" class="footer-link">Blog</a></li>
                </ul>
            </div>
            <div class="col-md-2 mb-4">
                <h5 class="mb-3">Support</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="#" class="footer-link">Help Center</a></li>
                    <li class="mb-2"><a href="#" class="footer-link">Contact Us</a></li>
                    <li class="mb-2"><a href="#" class="footer-link">FAQ</a></li>
                </ul>
            </div>
            <div class="col-md-4 mb-4">
                <h5 class="mb-3">Connect With Us</h5>
                <a href="#" class="footer-link me-3"><i class="fab fa-facebook-f fa-lg"></i></a>
                <a href="#" class="footer-link me-3"><i class="fab fa-twitter fa-lg"></i></a>
                <a href="#" class="footer-link me-3"><i class="fab fa-instagram fa-lg"></i></a>
                <a href="#" class="footer-link"><i class="fab fa-linkedin-in fa-lg"></i></a>
            </div>
        </div>
        <hr class="my-4" style="border-color: #3e4143;">
        <div class="row">
            <div class="col-md-6">
                <p class="small">&copy; 2023 LearnHub. All rights reserved.</p>
            </div>
            <div class="col-md-6 text-md-end">
                <a href="#" class="footer-link small me-3">Terms</a>
                <a href="#" class="footer-link small me-3">Privacy</a>
                <a href="#" class="footer-link small">Cookie Policy</a>
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>