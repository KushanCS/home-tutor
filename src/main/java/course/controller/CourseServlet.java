package course.controller;

import course.model.Course;
import course.utils.CourseFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/courses")
public class CourseServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String filePath = getServletContext().getRealPath("/WEB-INF/courses.txt");
        List<Course> allCourses = CourseFileUtil.readCoursesFromFile(filePath);

        request.setAttribute("courses", allCourses);
        request.getRequestDispatcher("course-home.jsp").forward(request, response);
    }
}