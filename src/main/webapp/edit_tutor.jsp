<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="tutor.model.Tutor" %>
<%
    HttpSession session = request.getSession(false);
    Tutor tutor = (Tutor) session != null ? (Tutor) session.getAttribute("tutor") : null;

    if (tutor == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h5>Edit Profile</h5>
        </div>
        <div class="card-body">
            <form action="updateTutor" method="post">
                <input type="hidden" name="id" value="<%= tutor.getId() %>">

                <div class="mb-3">
                    <label class="form-label">Full Name</label>
                    <input type="text" class="form-control" name="name" value="<%= tutor.getName() %>">
                </div>
                <div class="mb-3">
                    <label class="form-label">Subject</label>
                    <input type="text" class="form-control" name="subject" value="<%= tutor.getSubject() %>">
                </div>
                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" class="form-control" name="email" value="<%= tutor.getEmail() %>">
                </div>
                <div class="mb-3">
                    <label class="form-label">Contact</label>
                    <input type="text" class="form-control" name="contact" value="<%= tutor.getContact() %>">
                </div>
                <div class="mb-3">
                    <label class="form-label">Campus Name</label>
                    <input type="text" class="form-control" name="campus" value="<%= tutor.getCampusName() %>">
                </div>
                <div class="mb-3">
                    <label class="form-label">Degree Course</label>
                    <input type="text" class="form-control" name="degreeCourse" value="<%= tutor.getDegreeCourse() %>">
                </div>
                <div class="mb-3">
                    <label class="form-label">Degree Level</label>
                    <input type="text" class="form-control" name="degreeLevel" value="<%= tutor.getDegreeLevel() %>">
                </div>
                <div class="mb-3">
                    <label class="form-label">Address</label>
                    <input type="text" class="form-control" name="address" value="<%= tutor.getAddress() %>">
                </div>
                <div class="mb-3">
                    <label class="form-label">Short Bio</label>
                    <textarea class="form-control" name="about"><%= tutor.getAbout() %></textarea>
                </div>

                <button type="submit" class="btn btn-primary">Update Profile</button>
            </form>
        </div>
    </div>
</div>

</body>
</html>
