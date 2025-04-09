<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            line-height: 1.6;
            background-color: #f4f4f4;
        }
        .header {
            background-color: #2d2d2d;
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .logo {
            font-size: 24px;
            font-weight: bold;
        }
        .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
        }
        .nav-links a:hover {
            text-decoration: underline;
        }
        .container {
            padding: 20px;
        }
        .btn {
            padding: 8px 16px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .search-bar {
            margin-bottom: 20px;
        }
        .search-bar input {
            padding: 8px;
            width: 300px;
            border-radius: 4px;
            border: 1px solid #ddd;
        }
        .footer {
            background-color: #2d2d2d;
            color: white;
            text-align: center;
            padding: 10px;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>
<body>
<div class="header">
    <div class="logo">Booking Manager</div>
    <div class="nav-links">
        <a href="dashboard.jsp">Dashboard</a>
        <a href="bookings.jsp">Bookings</a>
        <a href="customers.jsp">Customers</a>
        <a href="logout.jsp">Logout</a>
    </div>
</div>

<div class="container">
    <div class="search-bar">
        <input type="text" placeholder="Search bookings..." />
    </div>

    <!-- Sample Table -->
    <table>
        <thead>
        <tr>
            <th>Booking ID</th>
            <th>Customer Name</th>
            <th>Booking Date</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>1</td>
            <td>John Doe</td>
            <td>2025-04-08</td>
            <td>Confirmed</td>
            <td><button class="btn">View</button></td>
        </tr>
        <tr>
            <td>2</td>
            <td>Jane Smith</td>
            <td>2025-04-09</td>
            <td>Pending</td>
            <td><button class="btn">View</button></td>
        </tr>
        </tbody>
    </table>
</div>

<div class="footer">
    <p>&copy; 2025 Booking Management System. All rights reserved.</p>
</div>
</body>
</html>
