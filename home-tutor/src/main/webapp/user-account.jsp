<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><html>
<head>
    <title>Student Account</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f7fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .card {
            width: 400px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            background-color: white;
            text-align: center;
        }
        .profile-img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            margin-bottom: 10px;
        }
        .info {
            font-size: 18px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

<c:forEach var="student" items="${studentDetails}">
    <div class="card">
        <img src="images/user.png" alt="Profile Picture" class="profile-img">
        <h2>${student.name}</h2>
        <p class="info"><strong>Username:</strong> ${student.username}</p>
        <p class="info"><strong>Email:</strong> ${student.email}</p>
        <p class="info"><strong>Phone:</strong> ${student.phone}</p>
        <p class="info"><strong>Address:</strong> ${student.address}</p>
        <p class="info"><strong>Student ID:</strong> ${student.stdId}</p>
    </div>
</c:forEach>

</body>
</html>
