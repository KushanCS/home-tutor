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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutor Dashboard - MetaTutor</title>

    <!-- Core Styles and Libraries -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.css" rel="stylesheet">

    <style>
        :root {
            --primary-color: #5624d0;
            --primary-light: #845ef7;
            --secondary-color: #f7f9fa;
            --accent-color: #a435f0;
            --sidebar-color: #1c1d1f;
            --success-color: #40c057;
            --warning-color: #fcc419;
            --danger-color: #fa5252;
        }

        body {
            background-color: #f8f9fa;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
        }

        .sidebar {
            min-height: 100vh;
            background-color: var(--sidebar-color);
            color: white;
            padding: 0;
            position: fixed;
            width: 250px;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
            z-index: 1000;
        }

        .sidebar-header {
            padding: 20px;
            border-bottom: 1px solid #3e4143;
            height: 70px;
        }

        .sidebar-nav {
            padding-top: 15px;
        }

        .sidebar a {
            color: #cec0fc;
            text-decoration: none;
            display: block;
            padding: 12px 20px;
            transition: all 0.3s;
            border-left: 3px solid transparent;
            margin: 2px 0;
            font-size: 0.9rem;
            font-weight: 500;
        }

        .sidebar a:hover, .sidebar a.active {
            color: white;
            background-color: #2a2b2d;
            border-left: 3px solid var(--primary-color);
        }

        .sidebar a i {
            width: 20px;
            text-align: center;
            margin-right: 10px;
            font-size: 0.9rem;
        }

        .main-content {
            margin-left: 250px;
            padding: 30px;
            min-height: 100vh;
        }

        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.05);
            transition: transform 0.3s, box-shadow 0.3s;
            margin-bottom: 25px;
            background-color: white;
        }

        .card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }

        .card-header {
            background-color: transparent;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            padding: 15px 20px;
            font-weight: 600;
        }

        .card-body {
            padding: 20px;
        }

        .summary-card {
            border-left: 4px solid var(--primary-color);
        }

        .summary-card .icon {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
        }

        .summary-card.students .icon { background-color: rgba(86, 36, 208, 0.1); color: var(--primary-color); }
        .summary-card.classes .icon { background-color: rgba(164, 53, 240, 0.1); color: var(--accent-color); }
        .summary-card.tasks .icon { background-color: rgba(64, 192, 87, 0.1); color: var(--success-color); }
        .summary-card.attendance .icon { background-color: rgba(252, 196, 25, 0.1); color: var(--warning-color); }

        .welcome-message {
            color: var(--primary-color);
            margin-bottom: 25px;
            font-weight: 600;
        }

        .badge {
            font-weight: 500;
            padding: 5px 10px;
        }

        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }

        .avatar-sm {
            width: 28px;
            height: 28px;
            object-fit: cover;
            border-radius: 50%;
        }

        .schedule-item {
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 8px;
            transition: all 0.2s;
        }

        .schedule-item:hover {
            background-color: #f8f9fa;
        }

        .progress-thin {
            height: 6px;
        }

        .upcoming-lesson {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 15px;
            background-color: #f8f9fa;
        }

        .upcoming-lesson:hover {
            background-color: #f1f3f5;
        }

        /* Responsive adjustments */
        @media (max-width: 992px) {
            .sidebar {
                width: 70px;
                overflow: hidden;
            }
            .sidebar span {
                display: none;
            }
            .sidebar-header span {
                display: none;
            }
            .sidebar a {
                text-align: center;
                padding: 15px 0;
            }
            .sidebar a i {
                margin-right: 0;
                font-size: 1.1rem;
            }
            .main-content {
                margin-left: 70px;
            }
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 20px 15px;
            }
        }
        .dropdown-menu {
            border: none;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            border-radius: 8px;
            padding: 8px;
        }

        .dropdown-item {
            padding: 8px 12px;
            border-radius: 6px;
            font-size: 0.9rem;
        }

        .dropdown-item:hover {
            background-color: #f8f9fa;
        }

        .dropdown-divider {
            margin: 6px 0;
            opacity: 0.5;
        }
    </style>
</head>
<body>
<div class="d-flex">
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header d-flex align-items-center">
            <i class="fas fa-graduation-cap me-2 fs-4"></i>
            <span class="fs-5 fw-bold">MetaTutor</span>
        </div>
        <div class="sidebar-nav">
            <a href="tutor_dashboard.jsp" class="active">
                <i class="fas fa-tachometer-alt"></i>
                <span>Dashboard</span>
            </a>
            <a href="view_courses.jsp">
                <i class="fas fa-book"></i>
                <span>My Courses</span>
            </a>
            <a href="#">
                <i class="fas fa-users"></i>
                <span>Students</span>
            </a>
            <a href="#">
                <i class="fas fa-envelope"></i>
                <span>Messages</span>
            </a>
            <a href="profileTutor.jsp">
                <i class="fas fa-user"></i>
                <span>Profile</span>
            </a>
            <a href="edit_tutor.jsp">
                <i class="fas fa-cog"></i>
                <span>Settings</span>
            </a>
            <a href="logoutTutor.jsp">
                <i class="fas fa-sign-out-alt"></i>
                <span>Logout</span>
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="container-fluid">
            <!-- Welcome Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4 class="welcome-message mb-0">
                    Welcome back, <strong><%= tutor.getName() %></strong> 👋
                </h4>
                <div class="d-flex align-items-center">
                    <div class="dropdown me-3">
                        <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-calendar-alt me-2"></i>
                            Today, <%= new java.text.SimpleDateFormat("MMM d").format(new java.util.Date()) %>
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <li><a class="dropdown-item" href="#">This Week</a></li>
                            <li><a class="dropdown-item" href="#">This Month</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="#">Custom Range</a></li>
                        </ul>
                    </div>

                    <!-- Profile section using tutor's actual details -->
                    <div class="dropdown">
                        <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle" id="dropdownUser" data-bs-toggle="dropdown" aria-expanded="false">
                            <% if (tutor.getProfileImage() != null && !tutor.getProfileImage().isEmpty()) { %>
                            <img src="image/<%= tutor.getProfileImage() %>" alt="Profile photo" class="rounded-circle me-2" style="width: 40px; height: 40px; object-fit: cover;">
                            <% } else { %>
                            <img src="https://i.pravatar.cc/40?img=5" alt="Profile photo" class="rounded-circle me-2" style="width: 40px; height: 40px; object-fit: cover;">
                            <% } %>
                            <div class="d-none d-sm-block">
                                <strong><%= tutor.getName() %></strong>
                                <div class="small text-muted"><%= tutor.getEmail() %></div>
                            </div>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="dropdownUser">
                            <li><a class="dropdown-item" href="profileTutor.jsp"><i class="fas fa-user me-2"></i> Profile</a></li>
                            <li><a class="dropdown-item" href="edit_tutor.jsp"><i class="fas fa-cog me-2"></i> Settings</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="logoutTutor.jsp"><i class="fas fa-sign-out-alt me-2"></i> Logout</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Summary Cards -->
            <div class="row mb-4">
                <div class="col-md-6 col-lg-3">
                    <div class="card summary-card students">
                        <div class="card-body">
                            <div class="icon">
                                <i class="fas fa-users"></i>
                            </div>
                            <h6 class="text-muted mb-2">TOTAL STUDENTS</h6>
                            <div class="d-flex justify-content-between align-items-center">
                                <h3 class="mb-0">31</h3>
                                <span class="badge bg-primary bg-opacity-10 text-primary">+3.2%</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="card summary-card classes">
                        <div class="card-body">
                            <div class="icon">
                                <i class="fas fa-chalkboard-teacher"></i>
                            </div>
                            <h6 class="text-muted mb-2">ACTIVE CLASSES</h6>
                            <div class="d-flex justify-content-between align-items-center">
                                <h3 class="mb-0">6</h3>
                                <span class="badge bg-success bg-opacity-10 text-success">+1 new</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="card summary-card tasks">
                        <div class="card-body">
                            <div class="icon">
                                <i class="fas fa-tasks"></i>
                            </div>
                            <h6 class="text-muted mb-2">COMPLETED TASKS</h6>
                            <div class="d-flex justify-content-between align-items-center">
                                <h3 class="mb-0">18</h3>
                                <div class="text-success">
                                    <i class="fas fa-arrow-up"></i> 12%
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="card summary-card attendance">
                        <div class="card-body">
                            <div class="icon">
                                <i class="fas fa-user-check"></i>
                            </div>
                            <h6 class="text-muted mb-2">TODAY'S ATTENDANCE</h6>
                            <div class="d-flex justify-content-between align-items-center">
                                <h3 class="mb-0">24/31</h3>
                                <div class="text-danger">
                                    <i class="fas fa-arrow-down"></i> 8%
                                </div>
                            </div>
                            <div class="progress progress-thin mt-2">
                                <div class="progress-bar bg-warning" style="width: 77%"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <!-- Left Column -->
                <div class="col-lg-8">
                    <!-- Student Progress Chart -->
                    <div class="card mb-4">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Student Progress</h5>
                            <div class="dropdown">
                                <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="chartDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                    This Week
                                </button>
                                <ul class="dropdown-menu" aria-labelledby="chartDropdown">
                                    <li><a class="dropdown-item" href="#">Today</a></li>
                                    <li><a class="dropdown-item" href="#">This Week</a></li>
                                    <li><a class="dropdown-item" href="#">This Month</a></li>
                                    <li><a class="dropdown-item" href="#">This Semester</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="card-body">
                            <canvas id="progressChart" height="250"></canvas>
                        </div>
                    </div>

                    <!-- Today's Schedule -->
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Today's Schedule</h5>
                            <a href="#" class="btn btn-sm btn-outline-primary">View All</a>
                        </div>
                        <div class="card-body">
                            <div class="schedule-item d-flex justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <div class="me-3 text-primary">
                                        <i class="fas fa-circle-notch fa-spin"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-0">English Class (Grade 7)</h6>
                                        <small class="text-muted">9:00 AM - 10:30 AM</small>
                                    </div>
                                </div>
                                <span class="badge bg-primary bg-opacity-10 text-primary">In Progress</span>
                            </div>

                            <div class="schedule-item d-flex justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <div class="me-3 text-secondary">
                                        <i class="far fa-clock"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-0">Team Meeting</h6>
                                        <small class="text-muted">10:30 AM - 11:30 AM</small>
                                    </div>
                                </div>
                                <span class="badge bg-secondary bg-opacity-10 text-secondary">Upcoming</span>
                            </div>

                            <div class="schedule-item d-flex justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <div class="me-3 text-warning">
                                        <i class="fas fa-utensils"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-0">Break</h6>
                                        <small class="text-muted">12:00 PM - 1:00 PM</small>
                                    </div>
                                </div>
                                <span class="badge bg-warning bg-opacity-10 text-warning">Break</span>
                            </div>

                            <div class="schedule-item d-flex justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <div class="me-3 text-info">
                                        <i class="fas fa-flask"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-0">Science Class (Grade 10)</h6>
                                        <small class="text-muted">2:00 PM - 3:30 PM</small>
                                    </div>
                                </div>
                                <span class="badge bg-info bg-opacity-10 text-info">Upcoming</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Column -->
                <div class="col-lg-4">
                    <!-- Calendar -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <h5 class="mb-0">Calendar</h5>
                        </div>
                        <div class="card-body p-0">
                            <div id="calendar" class="p-3"></div>
                            <div class="border-top p-3">
                                <button class="btn btn-primary w-100">
                                    <i class="fas fa-plus me-2"></i> Add Event
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Upcoming Lessons -->
                    <div class="card mb-4">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Upcoming Lessons</h5>
                            <a href="#" class="btn btn-sm btn-outline-secondary">View All</a>
                        </div>
                        <div class="card-body">
                            <div class="upcoming-lesson">
                                <div class="d-flex align-items-center mb-2">
                                    <span class="badge bg-warning me-2"></span>
                                    <div>
                                        <h6 class="mb-0">Common English</h6>
                                        <small class="text-muted">Thu 11:00 – 11:45 am</small>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center justify-content-between">
                                    <div class="d-flex">
                                        <img src="https://i.pravatar.cc/24?img=1" class="rounded-circle avatar-sm me-1" title="Student 1" />
                                        <img src="https://i.pravatar.cc/24?img=2" class="rounded-circle avatar-sm me-1" title="Student 2" />
                                        <img src="https://i.pravatar.cc/24?img=3" class="rounded-circle avatar-sm" title="Student 3" />
                                    </div>
                                    <button class="btn btn-sm btn-outline-primary">Join</button>
                                </div>
                            </div>

                            <div class="upcoming-lesson">
                                <div class="d-flex align-items-center mb-2">
                                    <span class="badge bg-primary me-2"></span>
                                    <div>
                                        <h6 class="mb-0">Speaking Club</h6>
                                        <small class="text-muted">Mon 5:00 – 5:45 pm</small>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center justify-content-between">
                                    <div class="d-flex">
                                        <img src="https://i.pravatar.cc/24?img=4" class="rounded-circle avatar-sm me-1" title="Student 4" />
                                        <img src="https://i.pravatar.cc/24?img=5" class="rounded-circle avatar-sm" title="Student 5" />
                                    </div>
                                    <button class="btn btn-sm btn-outline-secondary">Details</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Tasks -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">Recent Tasks</h5>
                        </div>
                        <div class="card-body">
                            <div class="d-flex align-items-center mb-3">
                                <div class="bg-success bg-opacity-10 p-2 rounded me-3">
                                    <i class="fas fa-check-circle text-success"></i>
                                </div>
                                <div>
                                    <h6 class="mb-0">English – Grammar Test</h6>
                                    <small class="text-muted">Today • 12 students completed</small>
                                </div>
                            </div>

                            <div class="d-flex align-items-center mb-3">
                                <div class="bg-warning bg-opacity-10 p-2 rounded me-3">
                                    <i class="fas fa-check-circle text-warning"></i>
                                </div>
                                <div>
                                    <h6 class="mb-0">Irregular Verb Test</h6>
                                    <small class="text-muted">2 days ago • 8 students completed</small>
                                </div>
                            </div>

                            <div class="d-flex align-items-center">
                                <div class="bg-primary bg-opacity-10 p-2 rounded me-3">
                                    <i class="fas fa-check-circle text-primary"></i>
                                </div>
                                <div>
                                    <h6 class="mb-0">Spanish – Essay</h6>
                                    <small class="text-muted">5 days ago • 15 students completed</small>
                                </div>
                            </div>
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

    // Chart JS - Student Progress
    const ctx = document.getElementById('progressChart').getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Mary Johnson', 'David Smith', 'Sarah Williams', 'James Brown', 'Emma Davis', 'Michael Wilson'],
            datasets: [{
                label: 'Completion Rate (%)',
                data: [92, 78, 85, 64, 88, 72],
                backgroundColor: '#5624d0',
                borderRadius: 6,
                borderSkipped: false
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    backgroundColor: '#1c1d1f',
                    titleFont: {
                        size: 14,
                        weight: 'bold'
                    },
                    bodyFont: {
                        size: 12
                    },
                    padding: 12,
                    cornerRadius: 8,
                    displayColors: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    max: 100,
                    grid: {
                        drawBorder: false,
                        color: 'rgba(0,0,0,0.05)'
                    },
                    ticks: {
                        stepSize: 20
                    }
                },
                x: {
                    grid: {
                        display: false
                    }
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