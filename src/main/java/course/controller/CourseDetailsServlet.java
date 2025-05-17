package course.controller;

import course.model.Course;
import course.model.Enrollment;
import course.utils.CourseFileUtil;
import course.utils.EnrollmentFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/CourseDetailsServlet")
// This servlet handles displaying detailed information about a specific course
public class CourseDetailsServlet extends HttpServlet {

    // Handles GET requests to show course details
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve the logged-in student's username from session
        String username = (String) request.getSession().getAttribute("username");

        // Get the course ID from the request parameter
        String courseId = request.getParameter("courseId");

        // If the user is not logged in, redirect to the login page
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get the file path where courses are stored
        String coursePath = getServletContext().getRealPath("/WEB-INF/courses.txt");

        // Retrieve all courses from file
        List<Course> allCourses = CourseFileUtil.getAllCourses(coursePath);
        Course course = null;

        // Find the course by matching courseId
        for (Course c : allCourses) {
            if (c.getCourseId().equals(courseId)) {
                course = c;
                break;
            }
        }

        // If course is not found, redirect back to course list
        if (course == null) {
            response.sendRedirect("student-course.jsp");
            return;
        }

        // Get the file path where student enrollments are stored
        String enrollPath = getServletContext().getRealPath("/WEB-INF/studentCourses.txt");

        // Read all enrollments from the file
        List<Enrollment> enrollments = EnrollmentFileUtil.readEnrollments(enrollPath);

        boolean isEnrolled = false;
        boolean isPaid = false;

        // Check if the current student is enrolled and paid for this course
        for (Enrollment e : enrollments) {
            if (e.getStudentUsername().equals(username) && e.getCourseId().equals(courseId)) {
                isEnrolled = true;
                isPaid = "Yes".equalsIgnoreCase(e.getPaidStatus());
                break;
            }
        }

        // Pass course and enrollment status to the JSP for rendering
        request.setAttribute("course", course);
        request.setAttribute("isEnrolled", isEnrolled);
        request.setAttribute("isPaid", isPaid);

        // Forward the request to course-details.jsp
        request.getRequestDispatcher("course-details.jsp").forward(request, response);
    }
}
