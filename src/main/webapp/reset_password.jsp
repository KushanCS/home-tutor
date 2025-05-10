<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("resetUser");
    if (username == null) {
        response.sendRedirect("loginTutor.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reset Password - MetaTutor</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card mx-auto" style="max-width: 500px;">
        <div class="card-body">
            <h4 class="card-title text-center">Reset Your Password</h4>
            <form action="ResetPasswordServlet" method="post">
                <div class="mb-3">
                    <label for="password" class="form-label">New Password</label>
                    <input type="password" name="password" id="password" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label for="confirm" class="form-label">Confirm Password</label>
                    <input type="password" name="confirm" id="confirm" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-success w-100">Reset Password</button>
            </form>

            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger mt-3 text-center"><%= request.getAttribute("error") %></div>
            <% } %>
        </div>
    </div>
</div>
</body>
</html>
