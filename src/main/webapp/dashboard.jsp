<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Student Management Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --sidebar-bg: #2C3E50;
            --sidebar-hover: #34495E;
            --primary-color: #3498db;
            --secondary-color: #f8f9fa;
        }

        body {
            display: flex;
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--secondary-color);
        }

        .sidebar {
            width: 280px;
            background: var(--sidebar-bg);
            color: white;
            padding: 20px 0;
            position: fixed;
            height: 100%;
            transition: all 0.3s;
            z-index: 1000;
        }

        .sidebar-header {
            padding: 0 20px 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .sidebar-menu {
            padding: 20px;
        }

        .sidebar a {
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            padding: 12px 15px;
            border-radius: 5px;
            margin-bottom: 5px;
            transition: all 0.3s;
        }

        .sidebar a:hover {
            background: var(--sidebar-hover);
            transform: translateX(5px);
        }

        .sidebar a i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        .content {
            margin-left: 280px;
            padding: 20px;
            width: 100%;
            transition: all 0.3s;
        }

        .navbar {
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            transition: transform 0.3s;
            height: 100%;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .stat-card .card-body {
            display: flex;
            align-items: center;
        }

        .stat-icon {
            font-size: 2.5rem;
            margin-right: 15px;
            opacity: 0.8;
        }

        .stat-text {
            flex: 1;
        }

        .stat-number {
            font-size: 1.8rem;
            font-weight: bold;
        }

        .recent-table {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .table th {
            border-top: none;
            font-weight: 600;
        }

        .badge {
            padding: 6px 10px;
            font-weight: 500;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 80px;
                overflow: hidden;
            }

            .sidebar-header h4, .sidebar a span {
                display: none;
            }

            .sidebar a {
                justify-content: center;
            }

            .sidebar a i {
                margin-right: 0;
                font-size: 1.2rem;
            }

            .content {
                margin-left: 80px;
            }
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <div class="sidebar-header">
        <h4><i class="fas fa-graduation-cap me-2"></i> <span>EduManage</span></h4>
    </div>

    <div class="sidebar-menu">
        <a href="dashboard.jsp" class="active">
            <i class="fas fa-tachometer-alt"></i>
            <span>Dashboard</span>
        </a>
        <a href="students-table.jsp">
            <i class="fas fa-users"></i>
            <span>Students</span>
        </a>
        <a href="tutors-table.jsp">
            <i class="fas fa-chalkboard-teacher"></i>
            <span>Tutors</span>
        </a>
        <a href="courses-table.jsp">
            <i class="fas fa-book"></i>
            <span>Courses</span>
        </a>
        <a href="settings.jsp">
            <i class="fas fa-cog"></i>
            <span>Settings</span>
        </a>
        <a href="logout.jsp" class="text-danger">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </div>
</div>

<!-- Main Content -->
<div class="content">
    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm p-3 mb-4 rounded">
        <div class="container-fluid">
            <span class="navbar-brand mb-0 h4">
                <i class="fas fa-home me-2"></i> Dashboard Overview
            </span>
            <div class="d-flex align-items-center">
                <span class="me-3">Welcome, <strong><%= session.getAttribute("username") %></strong></span>
                <img src="https://ui-avatars.com/api/?name=<%= session.getAttribute("username") %>&background=random"
                     class="rounded-circle" width="40" height="40" alt="Profile">
            </div>
        </div>
    </nav>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Simple animation for cards on page load
    document.addEventListener('DOMContentLoaded', function() {
        const cards = document.querySelectorAll('.card');
        cards.forEach((card, index) => {
            setTimeout(() => {
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, index * 100);
        });
    });
</script>
</body>
</html>