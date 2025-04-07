<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="student.services.Student" %>
<%@ page session="true" %>

<%
    Student student = (Student) session.getAttribute("student");
    if (student == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= student.getName() %>'s Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .rounded-3 {
            border-radius: 0.5rem !important;
        }
        .profile-img {
            width: 150px;
            height: 150px;
            object-fit: cover;
        }
        .social-icon {
            font-size: 1.2rem;
        }
        .progress {
            height: 5px;
        }
        .card {
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border: none;
        }
        .breadcrumb {
            background-color: #f8f9fa;
            padding: 0.75rem 1rem;
        }
    </style>
</head>
<body>
<section style="background-color: #eee;">
    <div class="container py-5">
        <div class="row">
            <div class="col">
                <nav aria-label="breadcrumb" class="bg-body-tertiary rounded-3 p-3 mb-4">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                        <li class="breadcrumb-item"><a href="#">Student</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Student Profile</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-4">
                <div class="card mb-4">
                    <div class="card-body text-center">
                        <img src="https://ui-avatars.com/api/?name=<%= student.getName() %>&background=random&size=150"
                             alt="avatar" class="rounded-circle img-fluid profile-img">
                        <h5 class="my-3"><%= student.getName() %></h5>
                        <p class="text-muted mb-1">Student ID: <%= student.getStdId() %></p>
                        <p class="text-muted mb-4"><%= student.getAddress() %></p>
                        <div class="d-flex justify-content-center mb-2">
                            <a href="edit-profile.jsp" class="btn btn-primary">Edit Profile</a>
                            <a href="logout" class="btn btn-outline-primary ms-1">Logout</a>
                        </div>
                    </div>
                </div>
                <div class="card mb-4 mb-lg-0">
                    <div class="card-body p-0">
                        <ul class="list-group list-group-flush rounded-3">
                            <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                <i class="fas fa-envelope fa-lg text-warning social-icon"></i>
                                <p class="mb-0"><%= student.getEmail() %></p>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                <i class="fas fa-phone fa-lg text-primary social-icon"></i>
                                <p class="mb-0"><%= student.getPhone() %></p>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                <i class="fas fa-user fa-lg text-info social-icon"></i>
                                <p class="mb-0"><%= student.getUserName() %></p>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                <i class="fas fa-calendar-alt fa-lg text-success social-icon"></i>
                                <p class="mb-0">Joined: Jan 2023</p>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-lg-8">
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0">Full Name</p>
                            </div>
                            <div class="col-sm-9">
                                <p class="text-muted mb-0"><%= student.getName() %></p>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0">Username</p>
                            </div>
                            <div class="col-sm-9">
                                <p class="text-muted mb-0"><%= student.getUserName() %></p>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0">Email</p>
                            </div>
                            <div class="col-sm-9">
                                <p class="text-muted mb-0"><%= student.getEmail() %></p>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0">Phone</p>
                            </div>
                            <div class="col-sm-9">
                                <p class="text-muted mb-0"><%= student.getPhone() %></p>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0">Address</p>
                            </div>
                            <div class="col-sm-9">
                                <p class="text-muted mb-0"><%= student.getAddress() %></p>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0">Student ID</p>
                            </div>
                            <div class="col-sm-9">
                                <p class="text-muted mb-0"><%= student.getStdId() %></p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="card mb-4 mb-md-0">
                            <div class="card-body">
                                <h5 class="card-title text-primary mb-4">Academic Progress</h5>
                                <p class="mb-1">Computer Science</p>
                                <div class="progress rounded mb-3">
                                    <div class="progress-bar bg-success" role="progressbar" style="width: 85%" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <p class="mb-1">Mathematics</p>
                                <div class="progress rounded mb-3">
                                    <div class="progress-bar bg-info" role="progressbar" style="width: 72%" aria-valuenow="72" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <p class="mb-1">Physics</p>
                                <div class="progress rounded mb-3">
                                    <div class="progress-bar bg-warning" role="progressbar" style="width: 65%" aria-valuenow="65" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card mb-4 mb-md-0">
                            <div class="card-body">
                                <h5 class="card-title text-primary mb-4">Attendance</h5>
                                <p class="mb-1">Computer Science</p>
                                <div class="progress rounded mb-3">
                                    <div class="progress-bar bg-success" role="progressbar" style="width: 95%" aria-valuenow="95" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <p class="mb-1">Mathematics</p>
                                <div class="progress rounded mb-3">
                                    <div class="progress-bar bg-success" role="progressbar" style="width: 90%" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <p class="mb-1">Physics</p>
                                <div class="progress rounded mb-3">
                                    <div class="progress-bar bg-success" role="progressbar" style="width: 88%" aria-valuenow="88" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>