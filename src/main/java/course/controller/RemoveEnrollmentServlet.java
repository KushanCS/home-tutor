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
public class RemoveEnrollmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Get currently logged-in student's username from session
        String username = (String) request.getSession().getAttribute("username");

        // ✅ Get the course ID to be removed from request parameters
        String courseId = request.getParameter("courseId");

        // ✅ If user not logged in or course ID missing, redirect to login
        if (username == null || courseId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // ✅ Get the path to the enrollment file
        String filePath = getServletContext().getRealPath("/WEB-INF/studentCourses.txt");

        // ✅ Read current list of enrollments from file
        List<Enrollment> enrollments = EnrollmentFileUtil.readEnrollments(filePath);

        // ✅ Filter out the specific enrollment entry matching username and courseId
        List<Enrollment> updated = enrollments.stream()
                .filter(e -> !(e.getStudentUsername().equals(username) && e.getCourseId().equals(courseId)))
                .collect(Collectors.toList());

        // ✅ Overwrite the file with the updated list (removing the selected course enrollment)
        EnrollmentFileUtil.writeAllEnrollments(updated, filePath);

        // ✅ Redirect back to My Courses page after removal
        response.sendRedirect("MyCoursesServlet");
    }
}
