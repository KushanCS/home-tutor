<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="tutor.model.Tutor" %>
<%
    Tutor tutor = (Tutor) session.getAttribute("tutor");
    if (tutor == null) {
        response.sendRedirect("loginTutor.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Profile - MetaTutor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #5624d0;
            --secondary-color: #f7f9fa;
            --accent-color: #a435f0;
            --sidebar-color: #1c1d1f;
        }

        body {
            background-color: var(--secondary-color);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-top: 0;
        }

        .profile-container {
            max-width: 900px;
            margin: 30px auto;
            background: white;
            padding: 0;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .profile-header {
            background-color: var(--primary-color);
            color: white;
            padding: 30px;
            position: relative;
        }

        .profile-avatar-container {
            position: relative;
            width: 120px;
            height: 120px;
            margin-right: 25px;
        }

        .profile-avatar {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid white;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .avatar-placeholder {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            font-size: 3rem;
            border: 4px solid white;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .profile-name {
            font-weight: 600;
            font-size: 1.8rem;
            margin-bottom: 5px;
        }

        .profile-subject {
            font-size: 1.1rem;
            opacity: 0.9;
            background-color: rgba(255,255,255,0.15);
            padding: 4px 12px;
            border-radius: 20px;
            display: inline-block;
            margin-top: 5px;
        }

        .profile-body {
            padding: 30px;
        }

        .profile-section {
            margin-bottom: 30px;
        }

        .section-title {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #eee;
            display: flex;
            align-items: center;
        }

        .section-title i {
            margin-right: 10px;
            font-size: 1.2em;
        }

        .info-row {
            display: flex;
            margin-bottom: 15px;
            align-items: flex-start;
        }

        .info-label {
            font-weight: 500;
            color: #555;
            width: 180px;
            min-width: 180px;
        }

        .info-value {
            flex-grow: 1;
            color: #333;
        }

        .navbar {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        .navbar-brand {
            font-weight: 700;
            color: var(--primary-color) !important;
        }

        .btn-primary {
            background-color: #6c63ff;
            border-color: #6c63ff;
        }

        .btn-primary:hover {
            background-color: #5a52d6;
            border-color: #5a52d6;
        }

        footer {
            background-color: #2d3436;
            color: white;
            padding: 3rem 0;
        }

        .footer-link {
            color: rgba(255,255,255,0.7);
            text-decoration: none;
            transition: color 0.2s ease;
        }

        .footer-link:hover {
            color: white;
        }

        .footer-hr {
            background-color: rgba(255,255,255,0.1);
        }

        .badge-subject {
            background-color: var(--accent-color);
            font-size: 0.85em;
            font-weight: 500;
        }

        @media (max-width: 768px) {
            .profile-header {
                text-align: center;
                flex-direction: column;
            }

            .profile-avatar-container {
                margin: 0 auto 20px auto;
            }

            .info-row {
                flex-direction: column;
            }

            .info-label {
                width: 100%;
                margin-bottom: 5px;
            }
        }

        /* Animation for profile photo */
        .profile-avatar-container:hover .profile-avatar {
            transform: scale(1.03);
            transition: transform 0.3s ease;
        }

        .profile-avatar, .avatar-placeholder {
            transition: transform 0.3s ease;
        }
    </style>
</head>
<body>

<!-- Navigation Bar with Return Button -->
<nav class="navbar navbar-expand-lg navbar-light sticky-top">
    <div class="container">
        <a class="navbar-brand" href="home-page.jsp">
            <i class="fas fa-graduation-cap me-2"></i>MetaTutor
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <div class="ms-auto d-flex align-items-center">
                <a href="tutor_dashboard.jsp" class="btn btn-outline-secondary me-2">
                    <i class="fas fa-arrow-left me-1"></i> Back to Dashboard
                </a>
                <a href="edit_tutor.jsp" class="btn btn-outline-primary me-2">
                    <i class="fas fa-edit me-1"></i> Edit Profile
                </a>
                <a href="logoutTutor.jsp" class="btn btn-outline-danger">
                    <i class="fas fa-sign-out-alt me-1"></i> Logout
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- Profile Content -->
<div class="container-fluid">
    <div class="profile-container">
        <!-- Profile Header -->
        <div class="profile-header d-flex align-items-center">
            <div class="profile-avatar-container">
                <% if (tutor.getProfileImage() != null && !tutor.getProfileImage().isEmpty()) { %>
                <img src="image/<%= tutor.getProfileImage() %>" alt="Profile Picture" class="profile-avatar">
                <% } else { %>
                <div class="avatar-placeholder">
                    <i class="fas fa-user-tie"></i>
                </div>
                <% } %>
            </div>
            <div>
                <h1 class="profile-name"><%= tutor.getName() %></h1>
                <div class="profile-subject"><i class="fas fa-chalkboard-teacher me-1"></i><%= tutor.getSubject() %> Tutor</div>
            </div>
        </div>

        <!-- Profile Body -->
        <div class="profile-body">
            <!-- Personal Information Section -->
            <div class="profile-section">
                <h3 class="section-title">
                    <i class="fas fa-user-circle"></i>Personal Information
                </h3>
                <div class="info-row">
                    <div class="info-label">Email</div>
                    <div class="info-value"><%= tutor.getEmail() %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Contact Number</div>
                    <div class="info-value"><%= tutor.getContact() != null ? tutor.getContact() : "Not provided" %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Address</div>
                    <div class="info-value"><%= tutor.getAddress() != null ? tutor.getAddress() : "Not provided" %></div>
                </div>
            </div>

            <!-- Academic Information Section -->
            <div class="profile-section">
                <h3 class="section-title">
                    <i class="fas fa-graduation-cap"></i>Academic Information
                </h3>
                <div class="info-row">
                    <div class="info-label">Teaching Subject</div>
                    <div class="info-value">
                        <%= tutor.getSubject() %>
                    </div>
                </div>
                <div class="info-row">
                    <div class="info-label">University/Campus</div>
                    <div class="info-value"><%= tutor.getCampusName() != null ? tutor.getCampusName() : "Not provided" %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Degree Program</div>
                    <div class="info-value"><%= tutor.getDegreeCourse() != null ? tutor.getDegreeCourse() : "Not provided" %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Education Level</div>
                    <div class="info-value"><%= tutor.getDegreeLevel() != null ? tutor.getDegreeLevel() : "Not provided" %></div>
                </div>
            </div>

            <!-- About Section -->
            <div class="profile-section">
                <h3 class="section-title">
                    <i class="fas fa-info-circle"></i>About Me
                </h3>
                <div class="info-row">
                    <div class="info-value">
                        <% if (tutor.getAbout() != null && !tutor.getAbout().isEmpty()) { %>
                        <%= tutor.getAbout() %>
                        <% } else { %>
                        <div class="text-muted font-italic">No description provided</div>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="d-flex justify-content-end mt-4 pt-3 border-top">
                <a href="edit_tutor.jsp" class="btn btn-primary px-4">
                    <i class="fas fa-edit me-1"></i> Edit Profile
                </a>
            </div>
        </div>
    </div>
</div>

<footer class="mt-5">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 mb-4">
                <h5 class="mb-3"><i class="fas fa-graduation-cap me-2"></i>MetaTutor</h5>
                <p>Connecting students with expert tutors for personalized learning experiences.</p>
            </div>
            <div class="col-lg-2 col-md-4 mb-4">
                <h5 class="mb-3">Navigation</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="#" class="footer-link">Home</a></li>
                    <li class="mb-2"><a href="#" class="footer-link">Find Tutors</a></li>
                    <li class="mb-2"><a href="#" class="footer-link">Courses</a></li>
                </ul>
            </div>
            <div class="col-lg-2 col-md-4 mb-4">
                <h5 class="mb-3">Support</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="#" class="footer-link">Help Center</a></li>
                    <li class="mb-2"><a href="#" class="footer-link">Contact Us</a></li>
                    <li class="mb-2"><a href="#" class="footer-link">FAQ</a></li>
                </ul>
            </div>
            <div class="col-lg-4 col-md-4 mb-4">
                <h5 class="mb-3">Stay Connected</h5>
                <div class="mb-3">
                    <a href="#" class="footer-link me-3"><i class="fab fa-facebook-f fa-lg"></i></a>
                    <a href="#" class="footer-link me-3"><i class="fab fa-twitter fa-lg"></i></a>
                    <a href="#" class="footer-link me-3"><i class="fab fa-instagram fa-lg"></i></a>
                    <a href="#" class="footer-link"><i class="fab fa-linkedin-in fa-lg"></i></a>
                </div>
                <small>Subscribe to our newsletter for updates</small>
                <div class="input-group mt-2">
                    <input type="email" class="form-control form-control-sm" placeholder="Your email">
                    <button class="btn btn-primary btn-sm" type="button">Subscribe</button>
                </div>
            </div>
        </div>
        <hr class="my-4 footer-hr">
        <div class="row">
            <div class="col-md-6 mb-3 mb-md-0">
                <p class="small mb-0">&copy; 2023 MetaTutor. All rights reserved.</p>
            </div>
            <div class="col-md-6 text-md-end">
                <a href="#" class="footer-link small me-3">Terms of Service</a>
                <a href="#" class="footer-link small me-3">Privacy Policy</a>
                <a href="#" class="footer-link small">Cookie Policy</a>
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>