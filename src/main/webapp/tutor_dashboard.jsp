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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="background-color: #f8f9fa;">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Meta Tutor</a>
        <div class="d-flex">
            <span class="navbar-text text-white me-3">
                Welcome, <strong><%= tutor.getName() %></strong>
            </span>
            <a href="logout.jsp" class="btn btn-outline-light btn-sm ms-3">Logout</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="card shadow-sm mx-auto" style="max-width: 700px;">
        <div class="card-body">
            <h4 class="card-title mb-4 text-primary">Tutor Profile</h4>
            <ul class="list-group list-group-flush">
                <li class="list-group-item"><strong>Username:</strong> <%= tutor.getUsername() %></li>
                <li class="list-group-item"><strong>Subject:</strong> <%= tutor.getSubject() %></li>
                <li class="list-group-item"><strong>Email:</strong> <%= tutor.getEmail() %></li>
                <li class="list-group-item"><strong>Contact:</strong> <%= tutor.getContact() %></li>
                <li class="list-group-item"><strong>Campus:</strong> <%= tutor.getCampusName() %></li>
                <li class="list-group-item"><strong>Degree:</strong> <%= tutor.getDegreeCourse() %> (<%= tutor.getDegreeLevel() %>)</li>
                <li class="list-group-item"><strong>Address:</strong> <%= tutor.getAddress() %></li>
                <li class="list-group-item"><strong>Bio:</strong> <%= tutor.getAbout() %></li>
            </ul>
        </div>
    </div>
</div>

</body>
</html>
