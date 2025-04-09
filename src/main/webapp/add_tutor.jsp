<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Add Tutor</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">
<h2>Add New Tutor</h2>
<form method="post" action="addTutor">
    <div class="mb-3">
        <label>Name</label>
        <input type="text" name="name" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>Subject</label>
        <input type="text" name="subject" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>Email</label>
        <input type="email" name="email" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>Contact</label>
        <input type="text" name="contact" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>About</label>
        <textarea name="about" class="form-control" rows="4"></textarea>
    </div>
    <button type="submit" class="btn btn-primary">Add Tutor</button>
</form>
</body>
</html>
