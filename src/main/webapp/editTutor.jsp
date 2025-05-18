<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="tutor.model.Tutor" %>
<%
    Tutor tutor = (Tutor) request.getAttribute("tutor");
    if (tutor == null) {
        response.sendRedirect("TutorManagementServlet?action=viewTutors");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Tutor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', sans-serif;
        }
        .navbar {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .navbar-brand {
            font-weight: 600;
            color: #5624d0;
        }
        .form-container {
            background: white;
            padding: 2rem 3rem;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            max-width: 850px;
            margin: 2rem auto;
        }
        .form-control, .form-select {
            border-radius: 10px;
            padding: 0.75rem;
        }
        .btn-primary {
            padding: 0.75rem;
            font-weight: 500;
            background-color: #5624d0;
            border-color: #5624d0;
        }
        .current-image {
            border: 2px solid #e9ecef;
            transition: all 0.3s ease;
        }
        .current-image:hover {
            border-color: #5624d0;
            transform: scale(1.05);
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light sticky-top">
    <div class="container">
        <a class="navbar-brand" href="adminDashboard.jsp">
            <i class="fas fa-chalkboard-teacher me-2"></i>MetaTutor Admin
        </a>
        <div class="ms-auto">
            <a href="TutorManagementServlet?action=viewTutors" class="btn-close btn-close-purple" aria-label="Close"></a>
        </div>
    </div>
</nav>

<!-- Form Container -->
<div class="container">
    <div class="form-container">
        <h3 class="text-center mb-4">Edit Tutor</h3>

        <form action="TutorManagementServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="updateTutor">
            <input type="hidden" name="tutorId" value="<%= tutor.getTutorId() %>">

            <div class="row g-3">
                <div class="col-md-6">
                    <input type="text" name="username" class="form-control" value="<%= tutor.getUsername() %>" placeholder="Username" required>
                </div>
                <div class="col-md-6">
                    <input type="text" name="name" class="form-control" value="<%= tutor.getName() %>" placeholder="Full Name" required>
                </div>
                <div class="col-md-6">
                    <input type="text" name="subject" class="form-control" value="<%= tutor.getSubject() %>" placeholder="Subject" required>
                </div>
                <div class="col-md-6">
                    <input type="email" name="email" class="form-control" value="<%= tutor.getEmail() %>" placeholder="Email" required>
                </div>
                <div class="col-md-6">
                    <input type="text" name="contact" class="form-control" value="<%= tutor.getContact() %>" placeholder="Contact Number" required>
                </div>
                <div class="col-md-6">
                    <input type="text" name="campusName" class="form-control" value="<%= tutor.getCampusName() %>" placeholder="Campus Name" required>
                </div>
                <div class="col-md-6">
                    <input type="text" name="degreeCourse" class="form-control" value="<%= tutor.getDegreeCourse() %>" placeholder="Degree Course" required>
                </div>
                <div class="col-md-6">
                    <select name="degreeLevel" class="form-select" required>
                        <option value="Undergraduate" <%= "Bachelor".equals(tutor.getDegreeLevel()) ? "selected" : "" %>>Undergraduate</option>
                        <option value="BSc" <%= "Master".equals(tutor.getDegreeLevel()) ? "selected" : "" %>>BSc</option>
                        <option value="MSc" <%= "PhD".equals(tutor.getDegreeLevel()) ? "selected" : "" %>>MSc</option>
                        <option value="PhD" <%= "PhD".equals(tutor.getDegreeLevel()) ? "selected" : "" %>>PhD</option>
                    </select>
                </div>
                <div class="col-12">
                    <input type="text" name="address" class="form-control" value="<%= tutor.getAddress() %>" placeholder="Address" required>
                </div>
                <div class="col-12">
                    <label class="form-label">Current Profile Image:</label><br>
                    <img src="image/<%= tutor.getProfileImage() %>" width="100" class="rounded current-image">
                </div>
                <div class="col-12">
                    <label for="profileImage" class="form-label">Upload New Profile Image (optional)</label>
                    <input type="file" name="profileImage" id="profileImage" class="form-control" accept="image/*">
                </div>
                <div class="col-12">
                    <textarea name="about" class="form-control" rows="3" placeholder="About Tutor..."><%= tutor.getAbout() %></textarea>
                </div>
                <div class="col-md-6">
                    <input type="password" id="newPassword" name="newPassword" class="form-control" placeholder="New Password (leave blank to keep existing)">
                    <div class="progress mt-1"><div id="password-strength" class="progress-bar bg-danger" role="progressbar" style="width: 0%"></div></div>
                </div>
                <div class="col-md-6">
                    <input type="password" id="confirmPassword" class="form-control" placeholder="Confirm New Password">
                    <span id="match-message" class="form-text"></span>
                </div>
                <div class="col-12 text-end">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="fas fa-save me-1"></i> Update Tutor
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const password = document.getElementById("newPassword");
    const confirmPassword = document.getElementById("confirmPassword");
    const matchMessage = document.getElementById("match-message");
    const strengthBar = document.getElementById("password-strength");

    function updateStrengthBar() {
        const val = password.value;
        let strength = 0;
        if (val.length >= 8) strength++;
        if (/[A-Z]/.test(val)) strength++;
        if (/[0-9]/.test(val)) strength++;
        if (/[^A-Za-z0-9]/.test(val)) strength++;
        const widths = ["0%", "25%", "50%", "75%", "100%"];
        const colors = ["bg-danger", "bg-warning", "bg-info", "bg-primary", "bg-success"];
        strengthBar.style.width = widths[strength];
        strengthBar.className = "progress-bar " + colors[strength];
    }

    function checkMatch() {
        if (password.value && confirmPassword.value) {
            if (password.value === confirmPassword.value) {
                matchMessage.textContent = "Passwords match";
                matchMessage.className = "form-text text-success";
            } else {
                matchMessage.textContent = "Passwords do not match";
                matchMessage.className = "form-text text-danger";
            }
        } else {
            matchMessage.textContent = "";
        }
    }

    password.addEventListener("input", () => {
        updateStrengthBar();
        checkMatch();
    });
    confirmPassword.addEventListener("input", checkMatch);
</script>
</body>
</html>