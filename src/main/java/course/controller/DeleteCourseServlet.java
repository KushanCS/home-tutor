<<<<<<< Updated upstream
=======

>>>>>>> Stashed changes
package course.controller;

import course.utils.CourseFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeleteCourseServlet")
<<<<<<< Updated upstream
// This servlet handles deleting a course based on its ID
public class DeleteCourseServlet extends HttpServlet {

    // Handles GET requests to delete a course
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve the course ID from the request parameter
        String courseId = request.getParameter("id");

        // If the course ID is valid (not null or empty), proceed with deletion
        if (courseId != null && !courseId.trim().isEmpty()) {

            // Get the absolute path to the file storing course data
            String filePath = getServletContext().getRealPath("/WEB-INF/courses.txt");

            // Call utility method to delete the course by ID from the file
            CourseFileUtil.deleteCourse(courseId, filePath);
        }

        // Redirect the user back to the courses view page after deletion
=======
public class DeleteCourseServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String courseId = request.getParameter("id");

        if (courseId != null && !courseId.trim().isEmpty()) {
            String filePath = getServletContext().getRealPath("/WEB-INF/courses.txt");
            CourseFileUtil.deleteCourse(courseId, filePath);
        }

>>>>>>> Stashed changes
        response.sendRedirect("view_courses.jsp");
    }
}
