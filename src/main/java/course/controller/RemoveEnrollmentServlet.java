package course.controller;

import course.model.Enrollment;
import course.utils.EnrollmentFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/RemoveEnrollmentServlet")
// This servlet handles unenrolling a student from a course
public class RemoveEnrollmentServlet extends HttpServlet {

    // Handles POST requests to remove a student's enrollment from a course
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve the currently logged-in student's username from session
        String username = (String) request.getSession().getAttribute("username");

        // Get the course ID from the request
        String courseId = request.getParameter("courseId");

        // If the user is not logged in or course ID is missing, redirect to login
        if (username == null || courseId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Resolve the path to the file storing all course enrollments
        String filePath = getServletContext().getRealPath("/WEB-INF/studentCourses.txt");

        // Read all current enrollments from the file
        List<Enrollment> enrollments = EnrollmentFileUtil.readEnrollments(filePath);

        // Filter out the enrollment matching this student and course ID (i.e., remove it)
        List<Enrollment> updated = enrollments.stream()
                .filter(e -> !(e.getStudentUsername().equals(username) && e.getCourseId().equals(courseId)))
                .collect(Collectors.toList());

        // Save the updated list back to the file
        EnrollmentFileUtil.writeAllEnrollments(updated, filePath);

        // Redirect back to the "My Courses" page after unenrollment
        response.sendRedirect("MyCoursesServlet");
    }
}
