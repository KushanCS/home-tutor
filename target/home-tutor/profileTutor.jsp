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

        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            font-size: 2.5rem;
            margin-right: 20px;
            border: 4px solid white;
        }

        .profile-name {
            font-weight: 600;
            font-size: 1.8rem;
            margin-bottom: 5px;
        }

        .profile-subject {
            font-size: 1.1rem;
            opacity: 0.9;
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
        }

        .info-row {
            display: flex;
            margin-bottom: 15px;
        }

        .info-label {
            font-weight: 500;
            color: #555;
            width: 180px;
            min-width: 180px;
        }

        .info-value {
            flex-grow: 1;
        }

        .navbar {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        .navbar-brand {
            font-weight: 700;
            color: var(--primary-color) !important;
        }

        .btn-outline-primary {
            color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-outline-primary:hover {
            background-color: var(--primary-color);
            color: white;
        }

        @media (max-width: 768px) {
            .profile-header {
                text-align: center;
                flex-direction: column;
            }

            .profile-avatar {
                margin: 0 auto 15px auto;
            }

            .info-row {
                flex-direction: column;
            }

            .info-label {
                width: 100%;
                margin-bottom: 5px;
            }
        .rounded-circle {
            object-fit: cover;
            border: 3px solid #0d6efd;
        }
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
            <div class="profile-avatar text-center mb-3">
                <% if (tutor.getProfileImage() != null && !tutor.getProfileImage().isEmpty()) { %>
                <img src="image/<%= tutor.getProfileImage() %>" alt="Profile Picture" class="rounded-circle" width="120" height="120">
                <% } else { %>
                <i class="fas fa-user-tie fa-5x text-secondary"></i>
                <% } %>
            </div>
            <div>
                <h1 class="profile-name"><%= tutor.getName() %></h1>
                <div class="profile-subject"><%= tutor.getSubject() %> Tutor</div>
            </div>
        </div>

        <!-- Profile Body -->
        <div class="profile-body">
            <!-- Personal Information Section -->
            <div class="profile-section">
                <h3 class="section-title">
                    <i class="fas fa-user-circle me-2"></i>Personal Information
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
                    <i class="fas fa-graduation-cap me-2"></i>Academic Information
                </h3>
                <div class="info-row">
                    <div class="info-label">Teaching Subject</div>
                    <div class="info-value"><%= tutor.getSubject() %></div>
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
                    <i class="fas fa-info-circle me-2"></i>About Me
                </h3>
                <div class="info-row">
                    <div class="info-value">
                        <%= tutor.getAbout() != null && !tutor.getAbout().isEmpty() ? tutor.getAbout() : "No description provided" %>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="d-flex justify-content-end mt-4 pt-3 border-top">
                <a href="edit_tutor.jsp" class="btn btn-primary">
                    <i class="fas fa-edit me-1"></i> Edit Profile
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>