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

@WebServlet("/EnrollServlet")
public class EnrollServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = (String) request.getSession().getAttribute("username");
        String courseId = request.getParameter("courseId");

        String enrollPath = getServletContext().getRealPath("/WEB-INF/studentCourses.txt");
        String coursePath = getServletContext().getRealPath("/WEB-INF/courses.txt");

        // Read existing enrollments
        List<Enrollment> enrollments = EnrollmentFileUtil.readEnrollments(enrollPath);

        // Check for duplicate
        for (Enrollment e : enrollments) {
            if (e.getStudentUsername().equals(username) && e.getCourseId().equals(courseId)) {
                response.sendRedirect("enroll-success.jsp?courseId=" + courseId);
                return;
            }
        }

        // Get course info from file
        List<Course> allCourses = CourseFileUtil.getAllCourses(coursePath);
        Course selectedCourse = null;
        for (Course c : allCourses) {
            if (c.getCourseId().equals(courseId)) {
                selectedCourse = c;
                break;
            }
        }

        if (selectedCourse != null) {
            Enrollment newEnrollment = new Enrollment(
                    username,
                    selectedCourse.getCourseId(),
                    selectedCourse.getName(),
                    selectedCourse.getImage(),
                    selectedCourse.getPrice(),
                    selectedCourse.getDuration(),
                    "No" // Default paid status
            );
            EnrollmentFileUtil.saveEnrollment(newEnrollment, enrollPath);
        }

        response.sendRedirect("enroll-success.jsp?courseId=" + courseId);
    }
}
