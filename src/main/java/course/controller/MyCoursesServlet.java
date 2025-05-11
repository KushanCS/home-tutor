package course.controller;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class MyCoursesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = (String) request.getSession().getAttribute("username");
        List<String[]> myCourses = new ArrayList<>();

        BufferedReader br = new BufferedReader(new FileReader("C:/path/to/enrollments.txt"));
        String line;
        while ((line = br.readLine()) != null) {
            String[] parts = line.split(",");
            if (parts[0].equals(username)) {
                myCourses.add(parts);
            }
        }
        br.close();

        request.setAttribute("courses", myCourses);
        RequestDispatcher rd = request.getRequestDispatcher("student-course.jsp");
        rd.forward(request, response);
    }
}
