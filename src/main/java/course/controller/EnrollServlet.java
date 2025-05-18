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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Get currently logged-in student's username from session
        String username = (String) request.getSession().getAttribute("username");

        // ✅ Get the course ID from the request parameter
        String courseId = request.getParameter("courseId");

        // ✅ Resolve file paths for enrollments and courses
        String enrollPath = getServletContext().getRealPath("/WEB-INF/studentCourses.txt");
        String coursePath = getServletContext().getRealPath("/WEB-INF/courses.txt");

        // ✅ Load existing enrollments
        List<Enrollment> enrollments = EnrollmentFileUtil.readEnrollments(enrollPath);

        // ✅ Check if the student is already enrolled in the course
        for (Enrollment e : enrollments) {
            if (e.getStudentUsername().equals(username) && e.getCourseId().equals(courseId)) {
                // ✅ If already enrolled, redirect to success page (no duplicate entry)
                response.sendRedirect("enroll-success.jsp?courseId=" + courseId);
                return;
            }
        }

        // ✅ Load all available courses to find the selected one
        List<Course> allCourses = CourseFileUtil.getAllCourses(coursePath);
        Course selectedCourse = null;

        for (Course c : allCourses) {
            if (c.getCourseId().equals(courseId)) {
                selectedCourse = c;
                break;
            }
        }

        // ✅ If course found, create a new enrollment object and save it
        if (selectedCourse != null) {
            Enrollment newEnrollment = new Enrollment(
                    username,
                    selectedCourse.getCourseId(),
                    selectedCourse.getName(),
                    selectedCourse.getImage(),
                    selectedCourse.getPrice(),
                    selectedCourse.getDuration(),
                    "No" // Payment status is initially set to "No"
            );

            // ✅ Save new enrollment to file
            EnrollmentFileUtil.saveEnrollment(newEnrollment, enrollPath);
        }

        // ✅ Redirect to enrollment success page with course ID parameter
        response.sendRedirect("enroll-success.jsp?courseId=" + courseId);
    }
}
