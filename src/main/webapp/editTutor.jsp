<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Tutor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .sidebar { background-color: #343a40; min-height: 100vh; color: white; }
        .sidebar .nav-link { color: rgba(255, 255, 255, 0.8); margin-bottom: 5px; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            color: white; background-color: rgba(255, 255, 255, 0.1);
        }
        .sidebar .nav-link i { margin-right: 10px; }
        .form-section { max-width: 800px; margin: 0 auto; }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3 col-lg-2 d-md-block sidebar">
            <div class="text-center py-4">
                <h4>Meta Tutor Admin</h4>
            </div>
            <ul class="nav flex-column px-3">
                <li class="nav-item">
                    <a class="nav-link text-white" href="adminDashboard.jsp">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="StudentManagement.jsp">
                        <i class="fas fa-users"></i> Students
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="TutorManagementServlet?action=viewTutors">
                        <i class="fas fa-chalkboard-teacher"></i> Tutors
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="courseManagement.jsp">
                        <i class="fas fa-book"></i> Courses
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="#">
                        <i class="fas fa-cog"></i> Settings
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="logout.jsp">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </li>
            </ul>
        </div>

        <!-- Main Content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Edit Tutor</h2>
                <a href="TutorManagementServlet?action=viewTutors" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-1"></i> Back to List
                </a>
            </div>

            <!-- Messages -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show">
                        ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <!-- Edit Tutor Form -->
            <div class="card form-section">
                <div class="card-body">
                    <form action="TutorManagementServlet" method="post">
                        <input type="hidden" name="action" value="updateTutor">
                        <input type="hidden" name="tutorId" value="${tutor.tutorId}">

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="name" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="name" name="name"
                                       value="${tutor.name}" required>
                            </div>
                            <div class="col-md-6">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email"
                                       value="${tutor.email}" required>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="subject" class="form-label">Subject</label>
                                <input type="text" class="form-control" id="subject" name="subject"
                                       value="${tutor.subject}" required>
                            </div>
                            <div class="col-md-6">
                                <label for="contact" class="form-label">Contact Number</label>
                                <input type="tel" class="form-control" id="contact" name="contact"
                                       value="${tutor.contact}" required>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="campusName" class="form-label">Campus</label>
                                <select class="form-select" id="campusName" name="campusName" required>
                                    <option value="Main Campus" ${tutor.campusName eq 'Main Campus' ? 'selected' : ''}>Main Campus</option>
                                    <option value="North Campus" ${tutor.campusName eq 'North Campus' ? 'selected' : ''}>North Campus</option>
                                    <option value="South Campus" ${tutor.campusName eq 'South Campus' ? 'selected' : ''}>South Campus</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="degreeCourse" class="form-label">Degree Course</label>
                                <input type="text" class="form-control" id="degreeCourse" name="degreeCourse"
                                       value="${tutor.degreeCourse}" required>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="degreeLevel" class="form-label">Degree Level</label>
                                <select class="form-select" id="degreeLevel" name="degreeLevel" required>
                                    <option value="Bachelor" ${tutor.degreeLevel eq 'Bachelor' ? 'selected' : ''}>Bachelor</option>
                                    <option value="Master" ${tutor.degreeLevel eq 'Master' ? 'selected' : ''}>Master</option>
                                    <option value="PhD" ${tutor.degreeLevel eq 'PhD' ? 'selected' : ''}>PhD</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="newPassword" class="form-label">New Password (leave blank to keep current)</label>
                                <input type="password" class="form-control" id="newPassword" name="newPassword">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="address" class="form-label">Address</label>
                            <textarea class="form-control" id="address" name="address" rows="2" required>${tutor.address}</textarea>
                        </div>

                        <div class="mb-3">
                            <label for="about" class="form-label">About Tutor</label>
                            <textarea class="form-control" id="about" name="about" rows="3">${tutor.about}</textarea>
                        </div>

                        <div class="text-end">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-1"></i> Update Tutor
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
