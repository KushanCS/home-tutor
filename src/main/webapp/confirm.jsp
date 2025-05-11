<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="student" class="student.model.Student" scope="session"/>

<%
    String enrollFilePath = application.getRealPath("/WEB-INF/studentCourses.txt");
    List<String> enrolledCourseNames = CourseEnrollmentUtil.getStudentCourses(
            student.getStdId(), enrollFilePath);
    List<Course> allCourses = CourseFileUtil.readCoursesFromFile(
            application.getRealPath("/WEB-INF/courses.txt"));
    List<Course> enrolledCourses = new ArrayList<>();

    for (String courseName : enrolledCourseNames) {
        for (Course c : allCourses) {
            if (c.getName().equalsIgnoreCase(courseName)) {
                enrolledCourses.add(c);
                break;
            }
        }
    }
    request.setAttribute("enrolledCourses", enrolledCourses);
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Courses</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Enrolled Courses</h2>

    <table class="table">
        <thead>
        <tr>
            <th>Course Name</th>
            <th>Tutor</th>
            <th>Duration</th>
            <th>Price</th>
            <th>Description</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${enrolledCourses}" var="course">
            <tr>
                <td>${course.name}</td>
                <td>${course.tutor}</td>
                <td>${course.duration}</td>
                <td>$${course.price}</td>
                <td>${course.description}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>