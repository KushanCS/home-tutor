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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile | MetaTutor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #5624d0;
            --secondary-color: #f8f9fa;
            --accent-color: #4d44db;
            --danger-color: #ff4d6d;
            --success-color: #52b788;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background-color: #f5f7fa;
            color: #2d3436;
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
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            transition: all 0.2s ease;
        }

        .btn-primary:hover {
            background-color: var(--accent-color);
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(108, 99, 255, 0.2);
        }

        .btn-danger {
            background-color: var(--danger-color);
            border-color: var(--danger-color);
        }

        .profile-card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            padding: 2rem;
            margin-bottom: 2rem;
            border: none;
        }

        .section-title {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 1.5rem;
            position: relative;
            padding-bottom: 0.5rem;
        }

        .section-title:after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 50px;
            height: 3px;
            background: var(--primary-color);
            border-radius: 3px;
        }

        .form-control, .form-select {
            border-radius: 8px;
            padding: 0.75rem 1rem;
            border: 1px solid #e0e0e0;
            transition: all 0.2s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(108, 99, 255, 0.15);
        }

        .form-label {
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: #4a4a4a;
        }

        .required-field:after {
            content: '*';
            color: var(--danger-color);
            margin-left: 4px;
        }

        .char-counter {
            font-size: 0.875rem;
            color: #6c757d;
        }

        .char-counter.warning {
            color: #ffaa00;
        }

        .char-counter.danger {
            color: var(--danger-color);
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

        .profile-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .profile-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background-color: var(--secondary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            font-size: 2rem;
            margin-right: 1.5rem;
        }

        .profile-info {
            flex-grow: 1;
        }

        .profile-name {
            font-weight: 600;
            margin-bottom: 0.25rem;
        }

        .profile-subject {
            color: #6c757d;
            font-size: 0.9rem;
        }

        .save-btn {
            padding: 0.75rem 2rem;
            font-weight: 500;
        }

        @media (max-width: 768px) {
            .profile-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .profile-avatar {
                margin-bottom: 1rem;
            }
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light sticky-top">
    <div class="container">
        <a class="navbar-brand" href="tutor_dashboard.jsp">
            <i class="fas fa-graduation-cap me-2"></i>MetaTutor
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <div class="ms-auto d-flex align-items-center">
                <a href="tutor_dashboard.jsp" class="btn btn-outline-secondary me-2">
                    <i class="fas fa-tachometer-alt me-1"></i> Dashboard
                </a>
                <form action="DeleteTutorServlet" method="post" class="me-2" onsubmit="return confirm('Are you sure you want to delete your profile? This cannot be undone.');">
                    <input type="hidden" name="tutorId" value="<%= tutor.getTutorId() %>">
                    <button type="submit" class="btn btn-outline-danger">
                        <i class="fas fa-trash-alt me-1"></i> Delete Profile
                    </button>
                </form>
                <a href="logoutTutor.jsp" class="btn btn-outline-primary">
                    <i class="fas fa-sign-out-alt me-1"></i> Logout
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- Main Content -->
<section class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="profile-card">
                    <div class="profile-header">
                        <div class="d-flex align-items-center">
                            <div class="position-relative me-4">
                                <div class="profile-avatar-edit">
                                    <% if (tutor.getProfileImage() != null && !tutor.getProfileImage().isEmpty()) { %>
                                    <img src="image/<%= tutor.getProfileImage() %>" id="profileImagePreview"
                                         class="rounded-circle shadow" width="120" height="120"
                                         style="object-fit: cover; border: 3px solid white;">
                                    <% } else { %>
                                    <div id="profileImagePreview" class="rounded-circle d-flex align-items-center justify-content-center"
                                         style="width:120px; height:120px; background-color: #e9ecef; border: 3px solid white;">
                                        <i class="fas fa-user-tie fa-3x text-secondary"></i>
                                    </div>
                                    <% } %>
                                    <label for="profileImage" class="profile-upload-btn">
                                        <i class="fas fa-camera"></i>
                                        <input type="file" id="profileImage" name="profileImage"
                                               accept="image/*" style="display: none;">
                                    </label>
                                </div>
                            </div>
                            <div class="profile-info">
                                <h3 class="profile-name"><%= tutor.getName() %></h3>
                                <div class="profile-subject"><%= tutor.getSubject() %> Tutor</div>
                            </div>
                        </div>
                        <a href="tutor_dashboard.jsp" class="btn btn-outline-secondary d-none d-md-block">
                            <i class="fas fa-arrow-left me-1"></i> Back
                        </a>
                    </div>

                    <form action="UpdateTutorServlet" method="post" enctype="multipart/form-data" id="profileForm">
                        <input type="hidden" name="tutorId" value="<%= tutor.getTutorId() %>"/>

                        <div class="mb-4">
                            <h4 class="section-title">
                                <i class="fas fa-image me-2"></i>Profile Picture
                            </h4>
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle me-2"></i>Recommended size: 500x500 pixels (1:1 ratio)
                            </div>
                            <div class="mb-3">
                                <label for="profileImage" class="form-label">Upload new profile picture</label>
                                <input type="file" class="form-control" id="profileImage" name="profileImage" accept="image/*">
                            </div>
                        </div>

                        <!-- Personal Information Section -->
                        <div class="mb-5">
                            <h4 class="section-title">
                                <i class="fas fa-user me-2"></i>Personal Information
                            </h4>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="name" class="form-label required-field">Full Name</label>
                                    <input type="text" id="name" name="name" class="form-control"
                                           value="<%= tutor.getName() %>" required>
                                    <div class="invalid-feedback">Please provide your full name.</div>
                                </div>
                                <div class="col-md-6">
                                    <label for="email" class="form-label required-field">Email</label>
                                    <input type="email" id="email" name="email" class="form-control"
                                           value="<%= tutor.getEmail() %>" required>
                                    <div class="invalid-feedback">Please provide a valid email address.</div>
                                </div>
                                <div class="col-md-6">
                                    <label for="contact" class="form-label">Contact Number</label>
                                    <input type="tel" id="contact" name="contact" class="form-control"
                                           value="<%= tutor.getContact() %>" placeholder="+60 12-345 6789">
                                </div>
                                <div class="col-md-6">
                                    <label for="address" class="form-label">Address</label>
                                    <input type="text" id="address" name="address" class="form-control"
                                           value="<%= tutor.getAddress() %>" placeholder="Your current location">
                                </div>
                            </div>
                        </div>

                        <!-- Academic Information Section -->
                        <div class="mb-5">
                            <h4 class="section-title">
                                <i class="fas fa-graduation-cap me-2"></i>Academic Information
                            </h4>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="subject" class="form-label required-field">Teaching Subject</label>
                                    <input type="text" id="subject" name="subject" class="form-control"
                                           value="<%= tutor.getSubject() %>" required placeholder="e.g. Mathematics, Physics">
                                    <div class="invalid-feedback">Please specify your teaching subject.</div>
                                </div>
                                <div class="col-md-6">
                                    <label for="campusName" class="form-label">University/Campus</label>
                                    <input type="text" id="campusName" name="campusName" class="form-control"
                                           value="<%= tutor.getCampusName() %>" placeholder="Your university name">
                                </div>
                                <div class="col-md-6">
                                    <label for="degreeCourse" class="form-label">Degree Program</label>
                                    <input type="text" id="degreeCourse" name="degreeCourse" class="form-control"
                                           value="<%= tutor.getDegreeCourse() %>" placeholder="e.g. Computer Science">
                                </div>
                                <div class="col-md-6">
                                    <label for="degreeLevel" class="form-label">Education Level</label>
                                    <select id="degreeLevel" name="degreeLevel" class="form-select">
                                        <option value="" disabled>Select your level</option>
                                        <option value="Undergraduate" <%= "Undergraduate".equals(tutor.getDegreeLevel()) ? "selected" : "" %>>Undergraduate</option>
                                        <option value="BSc" <%= "BSc".equals(tutor.getDegreeLevel()) ? "selected" : "" %>>Bachelor's Degree</option>
                                        <option value="MSc" <%= "MSc".equals(tutor.getDegreeLevel()) ? "selected" : "" %>>Master's Degree</option>
                                        <option value="PhD" <%= "PhD".equals(tutor.getDegreeLevel()) ? "selected" : "" %>>Doctorate (PhD)</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- About Section -->
                        <div class="mb-4">
                            <h4 class="section-title">
                                <i class="fas fa-edit me-2"></i>Profile Description
                            </h4>
                            <div class="mb-3">
                                <label for="about" class="form-label">About You</label>
                                <textarea id="about" name="about" class="form-control" rows="6"
                                          placeholder="Tell students about your teaching experience, methods, and expertise..."><%= tutor.getAbout() %></textarea>
                                <div class="d-flex justify-content-between mt-2">
                                    <small class="form-text text-muted">This will be displayed on your public profile.</small>
                                    <div id="charCounter" class="char-counter">0/500 characters</div>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end align-items-center mt-5 pt-3 border-top">
                            <button type="submit" class="btn btn-primary save-btn">
                                <i class="fas fa-save me-1"></i> Save Changes
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
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
        <hr class="my-4 bg-light">
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
<script>
    // Form validation
    (function() {
        'use strict'

        const form = document.getElementById('profileForm')

        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault()
                event.stopPropagation()
            }

            form.classList.add('was-validated')
        }, false)
    })()

    // Character counter for about textarea
    document.addEventListener('DOMContentLoaded', function() {
        const aboutTextarea = document.getElementById('about')
        const charCounter = document.getElementById('charCounter')

        function updateCounter() {
            const length = aboutTextarea.value.length
            charCounter.textContent = `${length}/500 characters`

            if (length > 450 && length <= 500) {
                charCounter.classList.add('warning')
                charCounter.classList.remove('danger')
            } else if (length > 500) {
                charCounter.classList.remove('warning')
                charCounter.classList.add('danger')
            } else {
                charCounter.classList.remove('warning')
                charCounter.classList.remove('danger')
            }
        }

        aboutTextarea.addEventListener('input', updateCounter)
        updateCounter() // Initialize counter
    })
</script>
</body>
</html>