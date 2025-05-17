<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Enrollment Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .sidebar { background-color: #343a40; min-height: 100vh; color: white; }
        .sidebar .nav-link { color: rgba(255, 255, 255, 0.8); margin-bottom: 5px; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            color: white; background-color: rgba(255, 255, 255, 0.1);
        }
        .sidebar .nav-link i { margin-right: 10px; }
        .action-btn { padding: 0.25rem 0.5rem; font-size: 0.875rem; }
        .enrollment-card { margin-bottom: 20px; }
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
                    <a class="nav-link text-white" href="TutorManagementServlet?action=viewTutors">
                        <i class="fas fa-chalkboard-teacher"></i> Tutors
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="CourseManagementServlet?action=viewCourses">
                        <i class="fas fa-book"></i> Courses
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="CourseManagementServlet?action=viewEnrollments">
                        <i class="fas fa-clipboard-list"></i> Enrollments
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
                <h2>Enrollment Management</h2>
                <div>
                    <a href="CourseManagementServlet?action=viewCourses" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-1"></i> Back to Courses
                    </a>
                </div>
            </div>

            <!-- Messages -->
            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show">
                        ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show">
                        ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <!-- Enrollment Statistics -->
            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="card text-white bg-primary">
                        <div class="card-body">
                            <h5 class="card-title">Total Enrollments</h5>
                            <p class="card-text display-5">${enrollments.size()}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-white bg-success">
                        <div class="card-body">
                            <h5 class="card-title">Paid Enrollments</h5>
                            <p class="card-text display-5">
                                <c:set var="paidCount" value="0"/>
                                <c:forEach items="${enrollments}" var="enrollment">
                                    <c:if test="${enrollment.paidStatus eq 'Yes'}">
                                        <c:set var="paidCount" value="${paidCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${paidCount}
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-white bg-warning">
                        <div class="card-body">
                            <h5 class="card-title">Pending Payments</h5>
                            <p class="card-text display-5">${enrollments.size() - paidCount}</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Enrollments Table -->
            <div class="card">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                            <tr>
                                <th>Student</th>
                                <th>Course</th>
                                <th>Price</th>
                                <th>Duration</th>
                                <th>Payment Status</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${enrollments}" var="enrollment">
                                <tr>
                                    <td>${enrollment.studentUsername}</td>
                                    <td>${enrollment.courseName}</td>
                                    <td>$${enrollment.price}</td>
                                    <td>${enrollment.duration} days</td>
                                    <td>
                                        <span class="badge bg-${enrollment.paidStatus eq 'Yes' ? 'success' : 'warning'}">
                                                ${enrollment.paidStatus}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <form action="CourseManagementServlet" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="updateEnrollmentStatus">
                                                <input type="hidden" name="studentUsername" value="${enrollment.studentUsername}">
                                                <input type="hidden" name="courseId" value="${enrollment.courseId}">
                                                <select name="status" class="form-select form-select-sm" onchange="this.form.submit()">
                                                    <option value="Yes" ${enrollment.paidStatus eq 'Yes' ? 'selected' : ''}>Paid</option>
                                                    <option value="No" ${enrollment.paidStatus eq 'No' ? 'selected' : ''}>Not Paid</option>
                                                </select>
                                            </form>
                                            <form action="CourseManagementServlet" method="post" style="display:inline; margin-left: 5px;">
                                                <input type="hidden" name="action" value="removeEnrollment">
                                                <input type="hidden" name="studentUsername" value="${enrollment.studentUsername}">
                                                <input type="hidden" name="courseId" value="${enrollment.courseId}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger action-btn"
                                                        onclick="return confirm('Are you sure you want to remove this enrollment?')"
                                                        title="Remove">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>