package student.controller;

import student.model.Student;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

// This servlet is responsible for displaying the student dashboard
public class DashboardServlet extends HttpServlet {

    // Handles GET requests to load the student dashboard
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the existing session, but do not create a new one
        HttpSession session = request.getSession(false);

        // If session is invalid or student is not logged in, redirect to login page
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get the logged-in student object from the session
        Student student = (Student) session.getAttribute("student");

        // Set the student's name as a request attribute to be displayed in the dashboard
        request.setAttribute("username", student.getName());

        // Forward the request to dashboard.jsp for rendering
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}
