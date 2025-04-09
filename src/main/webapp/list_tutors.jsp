<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="tutor.model.Tutor" %>
<html>
<head>
    <title>All Tutors</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">
<h2>List of Tutors</h2>
<a href="add_tutor.jsp" class="btn btn-success mb-3">+ Add New Tutor</a>
<table class="table table-bordered">
    <thead>
    <tr>
        <th>Name</th><th>Subject</th><th>Email</th><th>Contact</th><th>About</th><th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<Tutor> tutors = (List<Tutor>) request.getAttribute("tutors");
        if (tutors != null) {
            for (Tutor tutor : tutors) {
    %>
    <tr>
        <td><%= tutor.getName() %></td>
        <td><%= tutor.getSubject() %></td>
        <td><%= tutor.getEmail() %></td>
        <td><%= tutor.getContact() %></td>
        <td><%= tutor.getAbout() %></td>
        <td>
            <a href="edit_tutor.jsp?id=<%= tutor.getId() %>" class="btn btn-warning btn-sm">Edit</a>
            <a href="deleteTutor?id=<%= tutor.getId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a>
        </td>
    </tr>
    <%
            }
        }
    %>
    </tbody>
</table>
</body>
</html>
