<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="tutor.model.Tutor" %>
<%
    Tutor tutor = (Tutor) session.getAttribute("tutor");
    if (tutor == null) {
        response.sendRedirect("loginTutor.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Tutor Dashboard</title>
    <link href="css/dashboard.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" rel="stylesheet">
</head>
<body class="d-flex">

<!-- Sidebar -->
<div class="sidebar">
    <h4>MetaTutor</h4>
    <a href="#" class="active"><i class="fas fa-home"></i> Dashboard</a>
    <a href="#"><i class="fas fa-chart-line"></i> Analysis</a>
    <a href="#"><i class="fas fa-envelope"></i> Inbox</a>
    <a href="#"><i class="fas fa-cog"></i> Settings</a>
    <a href="logoutTutor.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>

<!-- Main Content -->
<div class="content container">
    <h2>Welcome back, <%= tutor.getName() %> 👋</h2>
    <p class="text-muted">Your subject: <strong><%= tutor.getSubject() %></strong></p>

    <div class="row mt-4">
        <!-- Summary Card -->
        <div class="col-md-6">
            <div class="card summary-card p-3">
                <h5 class="card-title">Tutor Profile</h5>
                <p><strong>Tutor ID:</strong> <%= tutor.getTutorId() %></p>
                <p><strong>Name:</strong> <%= tutor.getName() %></p>
                <p><strong>Username:</strong> <%= tutor.getUsername() %></p>
                <p><strong>Email:</strong> <%= tutor.getEmail() %></p>
                <p><strong>Contact:</strong> <%= tutor.getContact() %></p>
                <p><strong>Campus:</strong> <%= tutor.getCampusName() %></p>
                <p><strong>Degree:</strong> <%= tutor.getDegreeCourse() %> (<%= tutor.getDegreeLevel() %>)</p>
                <p><strong>Address:</strong> <%= tutor.getAddress() %></p>
                <p><strong>About:</strong> <%= tutor.getAbout() %></p>
            </div>
        </div>

        <!-- Calendar -->
        <div class="col-md-6">
            <div class="calendar-box">
                <label>Select Date:</label>
                <input type="text" id="calendar" class="form-control flatpickr" placeholder="Pick a day">
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script>
    flatpickr(".flatpickr", {
        enableTime: false,
        dateFormat: "Y-m-d"
    });
</script>
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</body>
</html>
