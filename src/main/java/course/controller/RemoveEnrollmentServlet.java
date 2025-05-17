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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = (String) request.getSession().getAttribute("username");
        String courseId = request.getParameter("courseId");

        if (username == null || courseId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String filePath = getServletContext().getRealPath("/WEB-INF/studentCourses.txt");
        List<Enrollment> enrollments = EnrollmentFileUtil.readEnrollments(filePath);

        List<Enrollment> updated = enrollments.stream()
                .filter(e -> !(e.getStudentUsername().equals(username) && e.getCourseId().equals(courseId)))
                .collect(Collectors.toList());

        EnrollmentFileUtil.writeAllEnrollments(updated, filePath);
        response.sendRedirect("MyCoursesServlet");
    }
}
