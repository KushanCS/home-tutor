package course.controller;

import course.utils.StudentCourseUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/RemoveCourseServlet")
public class RemoveCourseServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get logged-in user
        String username = (String) request.getSession().getAttribute("username");
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get course name from form
        String courseName = request.getParameter("course");

        // Path to studentCourses.txt
        String path = getServletContext().getRealPath("/WEB-INF/studentCourses.txt");

        // Remove course for that user
        StudentCourseUtil.removeCourse(path, username, courseName);

        // Redirect to reload updated list
        response.sendRedirect("MyCoursesServlet");
    }
}
