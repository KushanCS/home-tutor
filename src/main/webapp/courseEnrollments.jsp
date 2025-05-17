<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${course.name} Enrollments</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .course-header {
            background-color: #f8f9fa;
            border-radius: 5px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .enrollment-card {
            margin-bottom: 15px;
            border-left: 4px solid #0d6efd;
        }
        .paid-card {
            border-left-color: #198754;
        }
        .unpaid-card {
            border-left-color: #fd7e14;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <jsp:include page="sidebar.jsp"/>

        <!-- Main Content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>${course.name} Enrollments</h2>
                <div>
                    <a href="CourseManagementServlet?action=viewCourses" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-1"></i> Back to Courses
                    </a>
                    <a href="CourseManagementServlet?action=viewEnrollments" class="btn btn-info ms-2">
                        <i class="fas fa-clipboard-list me-1"></i> All Enrollments
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

            <!-- Course Info -->
            <div class="course-header">
                <div class="row">
                    <div class="col-md-6">
                        <h3>${course.name}</h3>
                        <p class="text-muted">${course.description}</p>
                    </div>
                    <div class="col-md-6">
                        <div class="row">
                            <div class="col-6">
                                <p><strong>Tutor:</strong> ${course.tutorName}</p>
                                <p><strong>Subject:</strong> ${course.tutorSubject}</p>
                            </div>
                            <div class="col-6">
                                <p><strong>Price:</strong> $${course.price}</p>
                                <p><strong>Duration:</strong> ${course.duration} weeks</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Enrollment Cards -->
            <div class="row">
                <div class="col-md-4">
                    <div class="card mb-4">
                        <div class="card-body text-center">
                            <h5 class="card-title">Total Enrolled</h5>
                            <p class="display-4">${enrollments.size()}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card mb-4">
                        <div class="card-body text-center">
                            <h5 class="card-title">Paid</h5>
                            <p class="display-4 text-success">
                                <c:set var="paidCount" value="0"/>
                                <c:forEach items="${enrollments}" var="enrollment">
                                    <c:if test="${enrollment.paid eq 'Yes'}">
                                        <c:set var="paidCount" value="${paidCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${paidCount}
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card mb-4">
                        <div class="card-body text-center">
                            <h5 class="card-title">Unpaid</h5>
                            <p class="display-4 text-warning">${enrollments.size() - paidCount}</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Enrollments List -->
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">Student Enrollments</h5>
                </div>
                <div class="card-body">
                    <c:forEach items="${enrollments}" var="enrollment">
                        <div class="card enrollment-card ${enrollment.paid eq 'Yes' ? 'paid-card' : 'unpaid-card'} mb-3">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h5>${enrollment.studentUsername}</h5>
                                        <p class="mb-1">Enrolled on: ${enrollment.enrollmentDate}</p>
                                        <span class="badge bg-${enrollment.paid eq 'Yes' ? 'success' : 'warning'}">
                                                ${enrollment.paid}
                                        </span>
                                    </div>
                                    <div class="text-end">
                                        <p class="mb-1"><strong>Price:</strong> $${enrollment.price}</p>
                                        <form action="CourseManagementServlet" method="post" class="mt-2">
                                            <input type="hidden" name="action" value="removeEnrollment">
                                            <input type="hidden" name="id" value="${enrollment.enrollmentId}">
                                            <button type="submit" class="btn btn-sm btn-outline-danger"
                                                    onclick="return confirm('Remove this enrollment?')">
                                                <i class="fas fa-user-minus"></i> Remove
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
