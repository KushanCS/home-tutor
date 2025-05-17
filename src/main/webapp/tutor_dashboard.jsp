<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="tutor.model.Tutor" %>
<%
    Tutor tutor = (Tutor) session.getAttribute("tutor");
    if (tutor == null) {
        response.sendRedirect("loginTutor.jsp");
        return;
    }
%>

<%
    String updateSuccess = request.getParameter("success");
    if ("profile".equals(updateSuccess)) {
%>
<div id="successAlert" class="alert alert-success alert-dismissible fade show position-fixed top-0 start-50 translate-middle-x mt-3 shadow" role="alert" style="z-index: 2000; width: auto; max-width: 90%;">
    ✅ Profile updated successfully!
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Tutor Dashboard - MetaTutor</title>

    <!-- Core Styles and Libraries -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" rel="stylesheet">

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
        }

        .sidebar {
            min-height: 100vh;
            background-color: var(--sidebar-color);
            color: white;
            padding: 0;
        }

        .sidebar-header {
            padding: 20px;
            border-bottom: 1px solid #3e4143;
        }

        .sidebar a {
            color: #cec0fc;
            text-decoration: none;
            display: block;
            padding: 12px 20px;
            transition: all 0.3s;
            border-left: 3px solid transparent;
        }

        .sidebar a:hover, .sidebar a.active {
            color: white;
            background-color: #2a2b2d;
            border-left: 3px solid var(--primary-color);
        }

        .sidebar a i {
            width: 24px;
            text-align: center;
            margin-right: 10px;
        }

        .content {
            padding: 30px;
        }

        .card {
            border: none;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s;
            margin-bottom: 20px;
        }

        .card:hover {
            transform: translateY(-2px);
        }

        .card-title {
            font-weight: 600;
            color: var(--primary-color);
        }

        .summary-card {
            border-left: 4px solid var(--primary-color);
        }

        .summary-card h4 {
            color: var(--primary-color);
        }

        .avatar-sm {
            width: 24px;
            height: 24px;
            object-fit: cover;
        }

        .welcome-message {
            color: var(--primary-color);
            margin-bottom: 25px;
        }

        .list-group-item {
            border-left: none;
            border-right: none;
            padding: 12px 20px;
        }

        .list-group-item:first-child {
            border-top: none;
        }
    </style>
</head>
<body class="d-flex">
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-2 sidebar">
            <div class="sidebar-header">
                <a href="home-page.jsp" class="d-flex align-items-center text-white text-decoration-none">
                    <i class="fas fa-graduation-cap me-2"></i>
                    <span class="fs-5 fw-bold">MetaTutor</span>
                </a>
            </div>
            <div class="pt-2">
                <a href="tutor_dashboard.jsp" class="active"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                <li><a href="view_courses.jsp"><i class="fas fa-book"></i> My Courses</a></li>
                <a href="#"><i class="fas fa-users"></i> Students</a>
                <a href="#"><i class="fas fa-envelope"></i> Messages</a>
                <a href="profileTutor.jsp"><i class="fas fa-user"></i> Profile</a>
                <a href="edit_tutor.jsp"><i class="fas fa-cog"></i> Settings</a>
                <a href="logoutTutor.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>

        <!-- Dashboard Content -->
        <div class="col-md-7 content">
            <h4 class="welcome-message">Welcome back, <strong><%= tutor.getName() %></strong> 👋</h4>

            <!-- Summary Cards -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card summary-card">
                        <div class="card-body text-center">
                            <h6>Total Students</h6>
                            <h4>31</h4>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card summary-card">
                        <div class="card-body text-center">
                            <h6>Active Classes</h6>
                            <h4>6</h4>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card summary-card">
                        <div class="card-body text-center">
                            <h6>Completed Tasks</h6>
                            <h4>18</h4>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card summary-card">
                        <div class="card-body text-center">
                            <h6>Today's Attendance</h6>
                            <h4>24/31</h4>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Student Progress Chart -->
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">Student Progress</h5>
                    <canvas id="progressChart" height="120"></canvas>
                </div>
            </div>

            <!-- Schedule -->
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">Today's Schedule</h5>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <span>9:00 AM – English Class (Grade 7)</span>
                            <span class="badge bg-primary rounded-pill">In Progress</span>
                        </li>
                        <li class="list-group-item">10:30 AM – Team Meeting</li>
                        <li class="list-group-item">12:00 PM – Break</li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <span>2:00 PM – Science Class (Grade 10)</span>
                            <span class="badge bg-secondary rounded-pill">Upcoming</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Right Sidebar -->
        <div class="col-md-3 content">
            <!-- Calendar -->
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">Calendar</h5>
                    <input id="calendar" class="form-control" />
                </div>
            </div>

            <!-- Lessons Section -->
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">Upcoming Lessons</h5>
                    <div class="mb-3">
                        <div class="d-flex align-items-center">
                            <span class="badge bg-warning me-2"></span>
                            <div>
                                <div>Common English</div>
                                <small class="text-muted">Thu 11:00 – 11:45 am</small>
                            </div>
                        </div>
                        <div class="mt-2">
                            <img src="https://i.pravatar.cc/24?img=1" class="rounded-circle avatar-sm me-1" />
                            <img src="https://i.pravatar.cc/24?img=2" class="rounded-circle avatar-sm me-1" />
                            <img src="https://i.pravatar.cc/24?img=3" class="rounded-circle avatar-sm" />
                        </div>
                    </div>
                    <div>
                        <div class="d-flex align-items-center">
                            <span class="badge bg-primary me-2"></span>
                            <div>
                                <div>Speaking Club</div>
                                <small class="text-muted">Mon 5:00 – 5:45 pm</small>
                            </div>
                        </div>
                        <div class="mt-2">
                            <img src="https://i.pravatar.cc/24?img=4" class="rounded-circle avatar-sm me-1" />
                            <img src="https://i.pravatar.cc/24?img=5" class="rounded-circle avatar-sm" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Completed Tasks -->
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Recent Tasks</h5>
                    <div class="d-flex align-items-center mb-2">
                        <i class="fas fa-check-circle text-success me-2"></i>
                        <div>
                            <div>English – Grammar Test</div>
                            <small class="text-muted">Today</small>
                        </div>
                    </div>
                    <div class="d-flex align-items-center mb-2">
                        <i class="fas fa-check-circle text-warning me-2"></i>
                        <div>
                            <div>Irregular Verb Test</div>
                            <small class="text-muted">2 days ago</small>
                        </div>
                    </div>
                    <div class="d-flex align-items-center">
                        <i class="fas fa-check-circle text-primary me-2"></i>
                        <div>
                            <div>Spanish – Essay</div>
                            <small class="text-muted">5 days ago</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script>
    // Auto-close success alert
    setTimeout(function () {
        const alertEl = document.getElementById('successAlert');
        if (alertEl) {
            const alert = bootstrap.Alert.getOrCreateInstance(alertEl);
            alert.close();
        }
    }, 3000);

    // Chart JS
    const ctx = document.getElementById('progressChart').getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Student A', 'Student B', 'Student C', 'Student D'],
            datasets: [{
                label: 'Progress (%)',
                data: [78, 64, 83, 55],
                backgroundColor: '#5624d0'
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    max: 100
                }
            }
        }
    });

    // Flatpickr Calendar
    flatpickr("#calendar", {
        inline: true,
        defaultDate: new Date()
    });
</script>
</body>
</html>