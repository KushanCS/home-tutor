package course.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.FileWriter;
import java.io.IOException;

@WebServlet(name = "AddCourseServlet", urlPatterns = "/add-course")
public class AddCourseServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String coursesFilePath = getServletContext().getRealPath("/WEB-INF/courses.txt");

        // Collect form fields
        String name        = request.getParameter("name");
        String tutor       = request.getParameter("tutor");
        double price       = Double.parseDouble(request.getParameter("price"));
        String duration    = request.getParameter("duration");
        String description = request.getParameter("description");

        String courseData = name + "," + tutor + "," + price + "," + duration + "," + description + System.lineSeparator();

        try (FileWriter writer = new FileWriter(coursesFilePath, true)) {
            writer.write(courseData);
        }

        response.sendRedirect("course-home.jsp");
    }
}
