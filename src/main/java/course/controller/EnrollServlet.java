package course.controller;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class EnrollServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = (String) request.getSession().getAttribute("username");
        String course = request.getParameter("course");

        FileWriter fw = new FileWriter("C:/path/to/enrollments.txt", true); // use absolute path
        BufferedWriter bw = new BufferedWriter(fw);
        bw.write(username + "," + course + ",false");
        bw.newLine();
        bw.close();

        response.sendRedirect("student-course.jsp");
    }
}
