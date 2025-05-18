<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tutor Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .action-btn { padding: 0.25rem 0.5rem; font-size: 0.875rem; }
        .sidebar { background-color: #343a40; min-height: 100vh; color: white; }
        .sidebar .nav-link { color: rgba(255, 255, 255, 0.8); margin-bottom: 5px; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            color: white; background-color: rgba(255, 255, 255, 0.1);
        }
        .sidebar .nav-link i { margin-right: 10px; }
    </style>
</head>
<body>

<!-- Session Message Alerts -->
<c:if test="${not empty sessionScope.error}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${sessionScope.error}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <c:remove var="error" scope="session"/>
</c:if>

<c:if test="${not empty sessionScope.message}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${sessionScope.message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <c:remove var="message" scope="session"/>
</c:if>

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
                    <a class="nav-link text-white active" href="TutorManagementServlet?action=viewTutors">
                        <i class="fas fa-chalkboard-teacher"></i> Tutors
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="courseManagement.jsp">
                        <i class="fas fa-book"></i> Courses
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white active" href="adminPayments.jsp">
                        <i class="fas fa-credit-card me-2"></i> Payments
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
                <h2>Tutor Management</h2>
                <span class="badge bg-secondary p-2">
                    Welcome, ${sessionScope.fullName} <i class="fas fa-user-shield ms-2"></i>
                </span>
            </div>

            <!-- Search + Add New -->
            <div class="card mb-4">
                <div class="card-body">
                    <form action="TutorManagementServlet" method="get">
                        <input type="hidden" name="action" value="searchTutors">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-search"></i></span>
                                    <input type="text" name="searchTerm" class="form-control"
                                           placeholder="Search by ID, Name or Subject" value="${param.searchTerm}">
                                </div>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-search me-1"></i> Search
                                </button>
                            </div>
                            <div class="col-md-6 text-end">
                                <a href="addTutor.jsp" class="btn btn-success">
                                    <i class="fas fa-plus me-1"></i> Add New Tutor
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Tutors Table -->
            <div class="card">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Subject</th>
                                <th>Campus</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${tutors}" var="tutor">
                                <tr>
                                    <td>${tutor.tutorId}</td>
                                    <td>${tutor.name}</td>
                                    <td>${tutor.email}</td>
                                    <td>${tutor.subject}</td>
                                    <td>${tutor.campusName}</td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="TutorManagementServlet?action=editTutorForm&id=${tutor.tutorId}"
                                               class="btn btn-sm btn-outline-primary action-btn" title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <form action="AdminDeleteTutorServlet" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="${tutor.tutorId}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger action-btn"
                                                        onclick="return confirm('Are you sure you want to delete this tutor?')">
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty tutors}">
                                <tr>
                                    <td colspan="6" class="text-center text-muted">No tutors found.</td>
                                </tr>
                            </c:if>
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
