<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Course Management</title>
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
        .search-form { max-width: 600px; margin: 0 auto 20px; }
    </style>
</head>
<body>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                <h2>Course Management</h2>
                <a href="CourseManagementServlet?action=addCourseForm" class="btn btn-success">
                    <i class="fas fa-plus me-1"></i> Add New Course
                </a>
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

            <!-- Search Form -->
            <div class="card search-form">
                <div class="card-body">
                    <form action="CourseManagementServlet" method="get">
                        <input type="hidden" name="action" value="searchCourses">
                        <div class="input-group">
                            <input type="text" class="form-control" name="searchTerm"
                                   placeholder="Search courses..." value="${param.searchTerm}">
                            <button class="btn btn-primary" type="submit">
                                <i class="fas fa-search"></i> Search
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Courses Table -->
            <div class="card">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Tutor</th>
                                <th>Subject</th>
                                <th>Level</th>
                                <th>Price</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${courses}" var="course">
                                <tr>
                                    <td>${course.courseId}</td>
                                    <td>${course.name}</td>
                                    <td>${course.tutorName}</td>
                                    <td>${course.tutorSubject}</td>
                                    <td>${course.level}</td>
                                    <td>$${course.price}</td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="CourseManagementServlet?action=editCourseForm&id=${course.courseId}"
                                               class="btn btn-sm btn-outline-primary action-btn"
                                               title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="CourseManagementServlet?action=viewEnrollments${course.courseId}"
                                               class="btn btn-sm btn-outline-info action-btn"
                                               title="View Enrollments">
                                                <i class="fas fa-users"></i>
                                            </a>
                                            <form action="CourseManagementServlet" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="deleteCourse">
                                                <input type="hidden" name="id" value="${course.courseId}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger action-btn"
                                                        onclick="return confirm('Are you sure you want to delete this course?')"
                                                        title="Delete">
                                                    <i class="fas fa-trash-alt"></i>
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