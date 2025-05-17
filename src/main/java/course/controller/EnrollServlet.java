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
<<<<<<< Updated upstream
// This servlet handles course enrollment requests from students
public class EnrollServlet extends HttpServlet {

    // Handles POST requests when a student tries to enroll in a course
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve the username of the logged-in student from session
        String username = (String) request.getSession().getAttribute("username");

        // Get the courseId from the request parameter
        String courseId = request.getParameter("courseId");

        // Resolve file paths for enrollments and courses
        String enrollPath = getServletContext().getRealPath("/WEB-INF/studentCourses.txt");
        String coursePath = getServletContext().getRealPath("/WEB-INF/courses.txt");

        // Read all existing enrollments from file
        List<Enrollment> enrollments = EnrollmentFileUtil.readEnrollments(enrollPath);

        // Check if the student has already enrolled in the course
        for (Enrollment e : enrollments) {
            if (e.getStudentUsername().equals(username) && e.getCourseId().equals(courseId)) {
                // If already enrolled, redirect to success page without duplicating
=======
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
>>>>>>> Stashed changes
                response.sendRedirect("enroll-success.jsp?courseId=" + courseId);
                return;
            }
        }

<<<<<<< Updated upstream
        // Read all courses and find the course matching the given courseId
=======
        // Get course info from file
>>>>>>> Stashed changes
        List<Course> allCourses = CourseFileUtil.getAllCourses(coursePath);
        Course selectedCourse = null;
        for (Course c : allCourses) {
            if (c.getCourseId().equals(courseId)) {
                selectedCourse = c;
                break;
            }
        }

<<<<<<< Updated upstream
        // If the course is found, create a new Enrollment and save it
=======
>>>>>>> Stashed changes
        if (selectedCourse != null) {
            Enrollment newEnrollment = new Enrollment(
                    username,
                    selectedCourse.getCourseId(),
                    selectedCourse.getName(),
                    selectedCourse.getImage(),
                    selectedCourse.getPrice(),
                    selectedCourse.getDuration(),
<<<<<<< Updated upstream
                    "No" // Default paid status set to "No"
            );

            // Save the new enrollment to the file
            EnrollmentFileUtil.saveEnrollment(newEnrollment, enrollPath);
        }

        // Redirect to the enrollment success page (even if course wasn't found, for safety)
=======
                    "No" // Default paid status
            );
            EnrollmentFileUtil.saveEnrollment(newEnrollment, enrollPath);
        }

>>>>>>> Stashed changes
        response.sendRedirect("enroll-success.jsp?courseId=" + courseId);
    }
}
