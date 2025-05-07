<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Add Student</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <style>
        /* Custom CSS to modify input box and button sizes */
        input[type="text"], input[type="password"], input[type="email"], select, input[type = "date"] {
            width: 100%;
            max-width: 400px;
            height: 40px;
            padding: 10px;
            font-size: 16px;
        }

        button {
            padding: 12px 20px;
            font-size: 16px;
            width: 200px;
            height: 50px;
        }

        label {
            font-size: 18px;
            margin-bottom: 10px;
        }

        /* Centering content */
        body, html {
            height: 100%;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f4f7fa; /* Optional background color */
        }

        .container {
            background-color: white;
            padding: 40px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Optional shadow effect */
            border-radius: 8px; /* Optional rounded corners */
            width: 100%;
            max-width: 600px; /* Controls the maximum width of the form */
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center">Add New Student</h2>
    <form action="add" method="post">
        <div class="mb-3">
            <label class="form-label">Student ID</label>
            <input type="text" class="form-control" name="studentId" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Full Name</label>
            <input type="text" class="form-control" name="fullName" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" class="form-control" name="email" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Course</label>
            <select class="form-select" name="course">
                <option value="Computer Science">Computer Science</option>
                <option value="Information Technology">Information Technology</option>
                <option value="Software Engineering">Software Engineering</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Contact Number</label>
            <input type="text" class="form-control" name="contact" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Date of Birth</label>
            <input type="date" class="form-control" name="dob" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Address</label>
            <input type="text" class="form-control" name="address" required>
        </div>

        <button type="submit" class="btn btn-primary">Add Student</button>

        <% String msg = (String) request.getAttribute("message"); %>
        <% if (msg != null) { %>
        <div class="alert alert-info text-center" role="alert">
            <%= msg %>
        </div>
        <% } %>

    </form>
</div>
</body>
</html>
