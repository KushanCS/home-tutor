<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="student.model.Student" %>
<%
    Student student = (Student) session.getAttribute("student");
    if (student == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= student.getName() %>'s Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .profile-img {
            width: 150px;
            height: 150px;
            object-fit: cover;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="row">
        <div class="col-md-4">
            <div class="card">
                <div class="card-body text-center">
                    <img src="https://ui-avatars.com/api/?name=<%= student.getName() %>&background=random&size=150"
                         class="rounded-circle profile-img mb-3">
                    <h3><%= student.getName() %></h3>
                    <p class="text-muted"><%= student.getCourse() %></p>
                    <a href="edit-profile.jsp" class="btn btn-primary">Edit Profile</a>
                </div>
            </div>
        </div>
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h4>Profile Information</h4>
                </div>
                <div class="card-body">
                    <table class="table">
                        <tr>
                            <th>Student ID</th>
                            <td><%= student.getStdId() %></td>
                        </tr>
                        <tr>
                            <th>Username</th>
                            <td><%= student.getUserName() %></td>
                        </tr>
                        <tr>
                            <th>Email</th>
                            <td><%= student.getEmail() %></td>
                        </tr>
                        <tr>
                            <th>Phone</th>
                            <td><%= student.getPhone() %></td>
                        </tr>
                        <tr>
                            <th>Address</th>
                            <td><%= student.getAddress() %></td>
                        </tr>
                        <tr>
                            <th>Date of Birth</th>
                            <td><%= student.getDob() %></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>