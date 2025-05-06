<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="tutor.model.Tutor" %>
<%
    Tutor tutor = (Tutor) request.getAttribute("tutor");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Tutor Dashboard</title>

    <!-- Bootstrap + Icons + Chart.js + Flatpickr -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

    <style>
        body {
            background-color: #f8f9fa;
        }
        .sidebar {
            min-height: 100vh;
            background-color: #003566;
            color: white;
        }
        .sidebar a {
            color: white;
            text-decoration: none;
            display: block;
            padding: 14px 20px;
        }
        .sidebar a:hover {
            background-color: #00509d;
        }
        .content {
            padding: 30px;
        }
        .summary-card {
            border-left: 4px solid #0d6efd;
        }
        .card-title {
            font-weight: 600;
        }
        .avatar-sm {
            width: 24px;
            height: 24px;
            object-fit: cover;
        }
        .calendar-box {
            padding: 10px;
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-2 sidebar d-flex flex-column">
            <h4 class="text-center my-4">Meta Tutor</h4>
            <a href="tutorDashboard">Dashboard</a>
            <a href="#">My Courses</a>
            <a href="#">Students</a>
            <a href="#">Messages</a>
            <a href="edit_tutor.jsp">Settings</a>
            <a href="logout.jsp">Logout</a>
        </div>

        <!-- Main Dashboard Content -->
        <div class="col-md-7 content">
            <h4 class="mb-4">Welcome, <strong><%= tutor.getName() %></strong> 👋</h4>

            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card shadow-sm">
                        <div class="card-body text-center">
                            <h6>Total Students</h6>
                            <h4>31</h4>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card shadow-sm">
                        <div class="card-body text-center">
                            <h6>Active Classes</h6>
                            <h4>6</h4>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card shadow-sm">
                        <div class="card-body text-center">
                            <h6>Completed Tasks</h6>
                            <h4>18</h4>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card shadow-sm">
                        <div class="card-body text-center">
                            <h6>Today’s Attendance</h6>
                            <h4>24/31</h4>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Chart -->
            <div class="card mb-4 shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Student Progress</h5>
                    <canvas id="progressChart" height="120"></canvas>
                </div>
            </div>

            <!-- Schedule -->
            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <h5 class="card-title">Schedule</h5>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item">9:00 AM – English Class (Grade 7)</li>
                        <li class="list-group-item">10:30 AM – Team Meeting</li>
                        <li class="list-group-item">12:00 PM – Break</li>
                        <li class="list-group-item">2:00 PM – Science Class (Grade 10)</li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Right Sidebar -->
        <div class="col-md-3 content">
            <!-- Calendar -->
            <div class="calendar-box">
                <h5 class="card-title">Calendar</h5>
                <input type="text" id="calendar" class="form-control" />
            </div>

            <!-- Lessons -->
            <div class="card mb-4 shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Lessons</h5>
                    <div class="mb-3">
                        <div><strong style="color: orange;">|</strong> Common English</div>
                        <small>Thu 11:00 – 11:45 am</small><br>
                        <img src="https://i.pravatar.cc/24?img=1" class="rounded-circle avatar-sm me-1" />
                        <img src="https://i.pravatar.cc/24?img=2" class="rounded-circle avatar-sm me-1" />
                        <img src="https://i.pravatar.cc/24?img=3" class="rounded-circle avatar-sm" />
                    </div>
                    <div>
                        <div><strong style="color: #0d6efd;">|</strong> Speaking Club</div>
                        <small>Mon 5:00 – 5:45 pm</small><br>
                        <img src="https://i.pravatar.cc/24?img=4" class="rounded-circle avatar-sm me-1" />
                        <img src="https://i.pravatar.cc/24?img=5" class="rounded-circle avatar-sm" />
                    </div>
                </div>
            </div>

            <!-- Completed Tasks -->
            <div class="card shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Completed Tasks</h5>
                    <div class="d-flex align-items-center mb-2">
                        <i class="bi bi-check2-square text-success me-2"></i>
                        <div>
                            <div>English – Grammar Test</div>
                            <small class="text-muted">Today</small>
                        </div>
                    </div>
                    <div class="d-flex align-items-center mb-2">
                        <i class="bi bi-check2-square text-warning me-2"></i>
                        <div>
                            <div>Irregular Verb Test</div>
                            <small class="text-muted">2 days ago</small>
                        </div>
                    </div>
                    <div class="d-flex align-items-center">
                        <i class="bi bi-check2-square text-primary me-2"></i>
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

<!-- Chart.js Config -->
<script>
    const ctx = document.getElementById('progressChart').getContext('2d');
    const progressChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Student A', 'Student B', 'Student C', 'Student D'],
            datasets: [{
                label: 'Progress (%)',
                data: [78, 64, 83, 55],
                backgroundColor: '#0d6efd'
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
</script>

<!-- Flatpickr Calendar -->
<script>
    flatpickr("#calendarPicker", {
        inline: true,
        dateFormat: "Y-m-d",
        defaultDate: new Date()
    });
</script>

<script>
    flatpickr("#calendarPicker", {
        inline: true,
        dateFormat: "Y-m-d",
        defaultDate: new Date(),
        showMonths: 1,
        disableMobile: true
    });
</script>

<!-- Flatpickr JS -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script>
    flatpickr("#calendar", {
        inline: true,
        defaultDate: new Date()
    });
</script>

</body>
</html>
