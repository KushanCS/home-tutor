package course.controller;

import course.utils.CourseFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeleteCourseServlet")
public class DeleteCourseServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Get the course ID from the request parameter (URL)
        String courseId = request.getParameter("id");

        // ✅ If the course ID is valid (not null or empty), proceed to delete
        if (courseId != null && !courseId.trim().isEmpty()) {
            // ✅ Get the path to the courses.txt file
            String filePath = getServletContext().getRealPath("/WEB-INF/courses.txt");

            // ✅ Call utility method to delete the course from the file
            CourseFileUtil.deleteCourse(courseId, filePath);
        }

        // ✅ Redirect back to the view_courses.jsp page after deletion
        response.sendRedirect("view_courses.jsp");
    }
}
