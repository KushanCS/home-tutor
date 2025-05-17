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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = (String) request.getSession().getAttribute("username");
        String courseId = request.getParameter("courseId");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get course details
        String coursePath = getServletContext().getRealPath("/WEB-INF/courses.txt");
        List<Course> allCourses = CourseFileUtil.getAllCourses(coursePath);
        Course course = null;

        for (Course c : allCourses) {
            if (c.getCourseId().equals(courseId)) {
                course = c;
                break;
            }
        }

        if (course == null) {
            response.sendRedirect("student-course.jsp");
            return;
        }

        // Check if student is enrolled and payment status
        String enrollPath = getServletContext().getRealPath("/WEB-INF/studentCourses.txt");
        List<Enrollment> enrollments = EnrollmentFileUtil.readEnrollments(enrollPath);
        boolean isEnrolled = false;
        boolean isPaid = false;

        for (Enrollment e : enrollments) {
            if (e.getStudentUsername().equals(username) && e.getCourseId().equals(courseId)) {
                isEnrolled = true;
                isPaid = "Yes".equalsIgnoreCase(e.getPaidStatus());
                break;
            }
        }

        request.setAttribute("course", course);
        request.setAttribute("isEnrolled", isEnrolled);
        request.setAttribute("isPaid", isPaid);
        request.getRequestDispatcher("course-details.jsp").forward(request, response);
    }
}