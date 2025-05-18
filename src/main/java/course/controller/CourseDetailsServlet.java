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
public class CourseDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Get currently logged-in student's username from session
        String username = (String) request.getSession().getAttribute("username");

        // ✅ Get the course ID from the request parameter
        String courseId = request.getParameter("courseId");

        // ✅ Redirect to login page if user is not logged in
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // ✅ Load all courses from the file
        String coursePath = getServletContext().getRealPath("/WEB-INF/courses.txt");
        List<Course> allCourses = CourseFileUtil.getAllCourses(coursePath);
        Course course = null;

        // ✅ Find the course that matches the given course ID
        for (Course c : allCourses) {
            if (c.getCourseId().equals(courseId)) {
                course = c;
                break;
            }
        }

        // ✅ If course is not found, redirect back to course list
        if (course == null) {
            response.sendRedirect("student-course.jsp");
            return;
        }

        // ✅ Check enrollment and payment status for this student
        String enrollPath = getServletContext().getRealPath("/WEB-INF/studentCourses.txt");
        List<Enrollment> enrollments = EnrollmentFileUtil.readEnrollments(enrollPath);
        boolean isEnrolled = false;
        boolean isPaid = false;

        for (Enrollment e : enrollments) {
            if (e.getStudentUsername().equals(username) && e.getCourseId().equals(courseId)) {
                isEnrolled = true;
                isPaid = "Yes".equalsIgnoreCase(e.getPaidStatus()); // Mark as paid if "Yes"
                break;
            }
        }

        // ✅ Set course and enrollment/payment status as request attributes for the JSP
        request.setAttribute("course", course);
        request.setAttribute("isEnrolled", isEnrolled);
        request.setAttribute("isPaid", isPaid);

        // ✅ Forward to course-details.jsp for displaying detailed view
        request.getRequestDispatcher("course-details.jsp").forward(request, response);
    }
}
