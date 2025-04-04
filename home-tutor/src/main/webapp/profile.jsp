<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="student.services.Student" %>
<%@ page session="true" %>

<%
    Student student = (Student) session.getAttribute("student");
    if (student == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><%= student.getName() %>'s Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .profile-card {
            max-width: 600px;
            margin: 30px auto;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .profile-img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            margin: 0 auto 20px;
            display: block;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="profile-card">
        <img src="https://ui-avatars.com/api/?name=<%= student.getName() %>&size=150"
             alt="Profile" class="profile-img">

        <h2 class="text-center"><%= student.getName() %></h2>

        <div class="card mb-3">
            <div class="card-body">
                <p><strong>Username:</strong> <%= student.getUserName() %></p>
                <p><strong>Email:</strong> <%= student.getEmail() %></p>
                <p><strong>Phone:</strong> <%= student.getPhone() %></p>
                <p><strong>Address:</strong> <%= student.getAddress() %></p>
                <p><strong>Student ID:</strong> <%= student.getStdId() %></p>
            </div>
        </div>

        <a href="logout" class="btn btn-danger">Logout</a>
    </div>
</div>
</body>
</html>