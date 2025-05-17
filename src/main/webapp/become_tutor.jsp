<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Become a Tutor | MetaTutor</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap + FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        :root {
            --primary-color: #5624d0;
            --secondary-color: #f7f9fa;
            --accent-color: #a435f0;
            --gradient-start: #6a11cb;
            --gradient-end: #2575fc;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            background-color: #f8f9fa;
        }

        /* Animated Gradient Background */
        .gradient-bg {
            background: linear-gradient(-45deg, #ee7752, #e73c7e, #23a6d5, #23d5ab);
            background-size: 400% 400%;
            animation: gradient 15s ease infinite;
        }

        @keyframes gradient {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .navbar {
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
        }

        .nav-link {
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            color: var(--primary-color) !important;
            transform: translateY(-2px);
        }

        /* Enhanced Button Styles */
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1); /* Smoother easing */
            position: relative;
            overflow: hidden;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            border-radius: 8px; /* Slightly rounded corners */
            box-shadow: 0 2px 5px rgba(86, 36, 208, 0.2);
        }

        /* Hero section button specific styles */
        .hero-section .btn-primary {
            padding: 1rem 2rem;
            font-size: 1.1rem;
            border-radius: 12px; /* More rounded for prominence */
        }

        /* Hover state - subtle but clear */
        .btn-primary:hover {
            background-color: var(--primary-color);
            opacity: 0.92; /* Very slight transparency */
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(86, 36, 208, 0.3);
        }

        /* Active/click state */
        .btn-primary:active {
            transform: translateY(1px);
            box-shadow: 0 2px 5px rgba(86, 36, 208, 0.3);
        }

        /* Focus state for accessibility */
        .btn-primary:focus {
            outline: none;
            box-shadow: 0 0 0 3px rgba(86, 36, 208, 0.4);
        }

        /* Ripple effect for better feedback */
        .btn-primary::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 5px;
            height: 5px;
            background: rgba(255, 255, 255, 0.5);
            opacity: 0;
            border-radius: 100%;
            transform: scale(1, 1) translate(-50%);
            transform-origin: 50% 50%;
        }

        .btn-primary:focus:not(:active)::after {
            animation: ripple 0.6s ease-out;
        }

        @keyframes ripple {
            0% {
                transform: scale(0, 0);
                opacity: 0.5;
            }
            100% {
                transform: scale(20, 20);
                opacity: 0;
            }
        }

        /* Button text transition */
        .btn-primary span {
            position: relative;
            transition: transform 0.2s ease;
            display: inline-block;
        }

        .btn-primary:hover span {
            transform: translateX(3px);
        }

        /* Arrow icon transition */
        .btn-primary i {
            transition: transform 0.2s ease;
        }

        .btn-primary:hover i {
            transform: translateX(5px);
        }

        .section {
            padding: 80px 0;
            position: relative;
        }

        .section-title {
            font-weight: 800;
            margin-bottom: 30px;
            position: relative;
            display: inline-block;
        }

        .section-title:after {
            content: '';
            position: absolute;
            width: 50%;
            height: 4px;
            bottom: -10px;
            left: 0;
            background: linear-gradient(to right, var(--gradient-start), var(--gradient-end));
            border-radius: 2px;
        }

        /* Floating Cards */
        .benefit-card {
            text-align: center;
            padding: 40px 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            transition: all 0.4s ease;
            background: white;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            border: none;
            height: 100%;
        }

        .benefit-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        }

        .benefit-icon {
            font-size: 3rem;
            background: linear-gradient(to right, var(--gradient-start), var(--gradient-end));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 20px;
        }

        /* Testimonial Cards */
        .testimonial-card {
            background: white;
            padding: 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            border-left: 4px solid var(--primary-color);
        }

        .testimonial-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        }

        /* CTA Section */
        .cta-section {
            background: linear-gradient(135deg, var(--gradient-start), var(--gradient-end));
            color: white;
            padding: 100px 0;
            text-align: center;
            border-radius: 20px;
            margin: 50px 30px;
            overflow: hidden;
            position: relative;
        }

        .cta-section a {
            position: relative;
            z-index: 1000;
        }
        .cta-section:before {
            z-index: 1;
        }

        .cta-section:before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 70%);
            animation: pulse 8s infinite linear;
        }

        @keyframes pulse {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Floating Animation */
        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-15px); }
            100% { transform: translateY(0px); }
        }

        .floating-img {
            animation: float 6s ease-in-out infinite;
        }

        /* Particles Background */
        .particles {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
        }

        .particle {
            position: absolute;
            background: rgba(164, 53, 240, 0.2);
            border-radius: 50%;
        }
        .btn-primary {
            padding: 0.5rem 1rem; /* Match course-home size */
        }

        .hero-section .btn-primary {
            padding: 0.75rem 1.5rem; /* Slightly larger for hero */
        }

        .btn-outline-primary {
            padding: 0.5rem 1rem;
        }
    </style>
</head>
<body>
<!-- Animated Background -->
<div class="particles" id="particles-js"></div>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light sticky-top">
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
                    <a class="nav-link active" href="become_tutor.jsp">Become a Tutor</a>
                </li>
            </ul>
            <% String user = (String) session.getAttribute("username"); %>
            <% if (user == null) { %>
            <div class="d-flex">
                <a href="loginOptions.jsp" class="btn btn-outline-primary me-2">Log in</a>
                <a href="register.jsp" class="btn btn-primary">Sign up</a>
            </div>
            <% } else { %>
            <div>
                <a href="student.jsp" class="btn btn-primary">Dashboard</a>
                <a href="logout.jsp" class="btn btn-outline-primary">Log out</a>
            </div>
            <% } %>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="section">
    <div class="container">
        <div class="hero-section px-4 px-md-5 py-5">
            <div class="row align-items-center">
                <div class="col-lg-6 mb-4 mb-lg-0 text-center text-lg-start">
                    <h1 class="display-4 fw-bold mb-3">Work on your terms</h1>
                    <h2 class="fw-bold mb-3">Become an online tutor</h2>
                    <p class="lead mb-4">Flexible, fulfilling and fits perfectly into your schedule</p>
                    <a href="add_tutor.jsp" class="btn btn-primary btn-lg">
                        <span>APPLY NOW</span> <i class="fas fa-arrow-right ms-2"></i>
                    </a>
                </div>
                <div class="col-lg-6 text-center">
                    <img src="https://images.unsplash.com/photo-1580894732444-8ecded7900cd?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80"
                         alt="Online Tutor Illustration"
                         class="img-fluid rounded floating-img"
                         style="max-height: 400px; width: auto;">
                </div>
            </div>
        </div>
    </div>
</section>


<!-- Why Online Tutoring Section -->
<section class="section">
    <div class="container">
        <h2 class="section-title text-center">Why online tutoring?</h2>
        <p class="text-center mb-5 lead">The perfect job for students and graduates. Earn money, boost your CV, and experience the joy of helping others succeed.</p>

        <div class="row">
            <div class="col-md-4">
                <div class="benefit-card">
                    <div class="benefit-icon">
                        <i class="fas fa-laptop-house"></i>
                    </div>
                    <h3 class="mb-3">Remote</h3>
                    <p class="mb-4">Teach from anywhere in the world with just your laptop and internet connection.</p>
                    <a href="#" class="btn btn-outline-primary rounded-pill">LEARN MORE</a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="benefit-card">
                    <div class="benefit-icon">
                        <i class="fas fa-heart"></i>
                    </div>
                    <h3 class="mb-3">Rewarding</h3>
                    <p class="mb-4">Make a real impact on students' lives while developing valuable skills.</p>
                    <a href="#" class="btn btn-outline-primary rounded-pill">LEARN MORE</a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="benefit-card">
                    <div class="benefit-icon">
                        <i class="fas fa-pound-sign"></i>
                    </div>
                    <h3 class="mb-3">Well Paid</h3>
                    <p class="mb-4">Earn competitive rates with flexible hours that fit your schedule.</p>
                    <a href="#" class="btn btn-outline-primary rounded-pill">LEARN MORE</a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- How It Works Section -->
<section class="section gradient-bg text-white">
    <div class="container">
        <h2 class="section-title text-center">How does MetaTutor work?</h2>
        <p class="text-center mb-5 lead">Our innovative platform makes online tutoring simple, effective, and rewarding.</p>

        <div class="row align-items-center">
            <div class="col-lg-6 mb-5 mb-lg-0">
                <div class="p-4 bg-white rounded-3 shadow">
                    <img src="https://images.unsplash.com/photo-1588072432836-e10032774350?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80"
                         alt="Online tutoring platform" class="img-fluid rounded">
                </div>
            </div>
            <div class="col-lg-6">
                <div class="p-4">
                    <h3 class="mb-4"><i class="fas fa-hands-helping me-3"></i> Share your knowledge</h3>
                    <p class="mb-4">Make a real difference by helping students who might not otherwise access quality tutoring.</p>

                    <h3 class="mb-4"><i class="fas fa-clock me-3"></i> Flexible schedule</h3>
                    <p class="mb-4">Choose your own hours and work as much or as little as you want.</p>

                    <h3 class="mb-4"><i class="fas fa-pound-sign me-3"></i> Earn while you learn</h3>
                    <p>With rates from £15-£50 per hour, earn more than typical student jobs.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Testimonials Section -->
<section class="section">
    <div class="container">
        <h2 class="section-title text-center">Success Stories</h2>
        <p class="text-center mb-5 lead">Hear from our tutors about their experiences</p>

        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="testimonial-card">
                    <div class="mb-3">
                        <i class="fas fa-quote-left fa-2x text-muted"></i>
                    </div>
                    <p class="mb-4">"The flexibility is perfect for my university schedule. I've developed so many skills while making a real difference in students' lives."</p>
                    <div class="d-flex align-items-center">
                        <div class="me-3">
                            <img src="https://randomuser.me/api/portraits/women/44.jpg" class="rounded-circle" width="50" alt="Alana">
                        </div>
                        <div>
                            <h5 class="mb-0">Alana</h5>
                            <small class="text-muted">Maths Tutor</small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="testimonial-card">
                    <div class="mb-3">
                        <i class="fas fa-quote-left fa-2x text-muted"></i>
                    </div>
                    <p class="mb-4">"I've been able to tutor multiple subjects while studying. The platform makes everything so easy and the support is fantastic."</p>
                    <div class="d-flex align-items-center">
                        <div class="me-3">
                            <img src="https://randomuser.me/api/portraits/women/68.jpg" class="rounded-circle" width="50" alt="Katie">
                        </div>
                        <div>
                            <h5 class="mb-0">Katie</h5>
                            <small class="text-muted">Science Tutor</small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="testimonial-card">
                    <div class="mb-3">
                        <i class="fas fa-quote-left fa-2x text-muted"></i>
                    </div>
                    <p class="mb-4">"After 3 years with MetaTutor, I'm still impressed by the platform quality and the difference we make in students' education."</p>
                    <div class="d-flex align-items-center">
                        <div class="me-3">
                            <img src="https://randomuser.me/api/portraits/women/32.jpg" class="rounded-circle" width="50" alt="Preshayla">
                        </div>
                        <div>
                            <h5 class="mb-0">Preshayla</h5>
                            <small class="text-muted">English Tutor</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- CTA Section -->
<section class="section">
    <div class="cta-section">
        <h2 class="display-5 fw-bold mb-4">Ready to make an impact?</h2>
        <p class="lead mb-5">Join our community of passionate tutors today</p>
        <a href="add_tutor.jsp" class="btn btn-light btn-lg px-5 py-3"
           style="cursor: pointer; position: relative; z-index: 10;">
            Start Your Application <i class="fas fa-arrow-right ms-2"></i>
        </a>
    </div>
</section>

<!-- Footer -->
<footer class="bg-dark text-white py-5">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 mb-4 mb-lg-0">
                <h4 class="mb-4"><i class="fas fa-graduation-cap me-2"></i>MetaTutor</h4>
                <p>Connecting students with exceptional tutors for personalized learning experiences.</p>
                <div class="mt-4">
                    <a href="#" class="text-white me-3"><i class="fab fa-facebook-f fa-lg"></i></a>
                    <a href="#" class="text-white me-3"><i class="fab fa-twitter fa-lg"></i></a>
                    <a href="#" class="text-white me-3"><i class="fab fa-instagram fa-lg"></i></a>
                    <a href="#" class="text-white"><i class="fab fa-linkedin-in fa-lg"></i></a>
                </div>
            </div>
            <div class="col-lg-2 col-md-6 mb-4 mb-md-0">
                <h5 class="mb-4">Quick Links</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="#" class="text-white">About Us</a></li>
                    <li class="mb-2"><a href="#" class="text-white">Become a Tutor</a></li>
                    <li class="mb-2"><a href="#" class="text-white">Find a Tutor</a></li>
                    <li class="mb-2"><a href="#" class="text-white">Pricing</a></li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-6 mb-4 mb-md-0">
                <h5 class="mb-4">Support</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="#" class="text-white">FAQ</a></li>
                    <li class="mb-2"><a href="#" class="text-white">Help Center</a></li>
                    <li class="mb-2"><a href="#" class="text-white">Terms of Service</a></li>
                    <li class="mb-2"><a href="#" class="text-white">Privacy Policy</a></li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5 class="mb-4">Contact Us</h5>
                <ul class="list-unstyled">
                    <li class="mb-3"><i class="fas fa-envelope me-2"></i> hello@metatutor.com</li>
                    <li class="mb-3"><i class="fas fa-phone me-2"></i> +44 20 1234 5678</li>
                    <li><i class="fas fa-map-marker-alt me-2"></i> 123 Tutor St, London, UK</li>
                </ul>
            </div>
        </div>
        <hr class="my-4 bg-light">
        <div class="text-center">
            <p class="mb-0">&copy; 2023 MetaTutor. All rights reserved.</p>
        </div>
    </div>
</footer>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Create floating particles
    document.addEventListener('DOMContentLoaded', function() {
        const particles = document.getElementById('particles-js');
        const particleCount = 30;

        for (let i = 0; i < particleCount; i++) {
            const particle = document.createElement('div');
            particle.classList.add('particle');

            // Random properties
            const size = Math.random() * 10 + 5;
            const posX = Math.random() * 100;
            const posY = Math.random() * 100;
            const opacity = Math.random() * 0.4 + 0.1;
            const delay = Math.random() * 5;
            const duration = Math.random() * 10 + 10;

            particle.style.width = `${size}px`;
            particle.style.height = `${size}px`;
            particle.style.left = `${posX}%`;
            particle.style.top = `${posY}%`;
            particle.style.opacity = opacity;
            particle.style.animation = `float ${duration}s ease-in-out ${delay}s infinite`;

            particles.appendChild(particle);
        }
    });
</script>
</body>
</html>