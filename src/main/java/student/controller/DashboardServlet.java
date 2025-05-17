// DashboardServlet.java - Handles student dashboard page loading logic

package student.controller;

import student.model.Student;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class DashboardServlet extends HttpServlet {

    // Handles GET requests to display the student dashboard
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve the current session, but don't create a new one if it doesn't exist
        HttpSession session = request.getSession(false);

        // If there's no active session or no student logged in, redirect to login page
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve the Student object from session
        Student student = (Student) session.getAttribute("student");

        // Set the student's name as a request attribute to be accessed in the dashboard JSP
        request.setAttribute("username", student.getName());

        // Forward the request to dashboard.jsp for rendering the student's personalized dashboard
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}
