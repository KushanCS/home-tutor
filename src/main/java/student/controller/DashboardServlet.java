// Updated DashboardServlet.java
package student.controller;

import student.model.Student;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class DashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Student student = (Student) session.getAttribute("student");
        request.setAttribute("username", student.getName());
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}
