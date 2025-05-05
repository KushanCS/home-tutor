<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="tutor.util.FileUtil" %>
<%@ page import="tutor.model.Tutor" %>
<%
    String id = request.getParameter("id");
    Tutor tutor = FileUtil.getTutorById(id);
%>
<html>
<head>
    <title>Edit Tutor</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">
<h2>Edit Tutor</h2>
<form method="post" action="updateTutor">
    <input type="hidden" name="username" value="${tutor.username}">
    <input type="hidden" name="id" value="<%= tutor.getId() %>">
    <div class="mb-3">
        <label>Name</label>
        <input type="text" name="name" value="<%= tutor.getName() %>" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>Subject</label>
        <input type="text" name="subject" value="<%= tutor.getSubject() %>" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>Email</label>
        <input type="email" name="email" value="<%= tutor.getEmail() %>" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>Contact</label>
        <input type="text" name="contact" value="<%= tutor.getContact() %>" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>About</label>
        <textarea name="about" class="form-control" rows="4"><%= tutor.getAbout() %></textarea>
    </div>
    <button type="submit" class="btn btn-primary">Update Tutor</button>
</form>
</body>
</html>
