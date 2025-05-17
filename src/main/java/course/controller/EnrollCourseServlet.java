package course.controller;

import course.model.Course;
import course.model.CourseStatus;
import course.utils.CourseFileUtil;
import course.utils.StudentCourseUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import java.io.IOException;
import java.util.List;

@WebServlet("/enrollCourse")
public class EnrollCourseServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = (String) request.getSession().getAttribute("username");
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String courseName = request.getParameter("name");
        String filePath = getServletContext().getRealPath("/WEB-INF/courses.txt");
        String studentPath = getServletContext().getRealPath("/WEB-INF/studentCourses.txt");


        List<Course> courses = CourseFileUtil.readCoursesFromFile(filePath);

        for (Course c : courses) {
            if (c.getName().equalsIgnoreCase(courseName)) {
                // Use the updated constructor: username + course + paid
                CourseStatus status = new CourseStatus(username, c, false);
                StudentCourseUtil.addCourse(studentPath, status);
                break;
            }
        }

        response.sendRedirect("MyCoursesServlet");
    }
}
