
package course.controller;

import course.utils.CourseFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeleteCourseServlet")
public class DeleteCourseServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String courseId = request.getParameter("id");

        if (courseId != null && !courseId.trim().isEmpty()) {
            String filePath = getServletContext().getRealPath("/WEB-INF/courses.txt");
            CourseFileUtil.deleteCourse(courseId, filePath);
        }

        response.sendRedirect("view_courses.jsp");
    }
}
