package course.controller;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class RemoveCourseServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = (String) request.getSession().getAttribute("username");
        String course = request.getParameter("course");

        File inputFile = new File("C:/path/to/enrollments.txt");
        File tempFile = new File("C:/path/to/temp.txt");

        BufferedReader reader = new BufferedReader(new FileReader(inputFile));
        BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile));

        String line;
        while ((line = reader.readLine()) != null) {
            String[] parts = line.split(",");
            if (!(parts[0].equals(username) && parts[1].equals(course))) {
                writer.write(line);
                writer.newLine();
            }
        }

        reader.close();
        writer.close();

        inputFile.delete();
        tempFile.renameTo(inputFile);

        response.sendRedirect("MyCoursesServlet");
    }
}
