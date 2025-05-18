package tutor.servlet;

import tutor.model.Tutor;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Servlet to handle the loading of the tutor dashboard.
 * Ensures that the tutor is authenticated and then forwards to the dashboard JSP page.
 */
@WebServlet("/tutor/dashboard")
public class DashboardTutorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the current session, don't create a new one if it doesn't exist
        HttpSession session = request.getSession(false);

        // Try to retrieve the logged-in tutor from the session
        Tutor tutor = (session != null) ? (Tutor) session.getAttribute("tutor") : null;

        // If no tutor is found in session, redirect to the login page
        if (tutor == null) {
            response.sendRedirect("loginTutor.jsp");
            return;
        }

        // (Optional) Pass the tutor object to the request scope for JSP access
        request.setAttribute("tutor", tutor);

        // Forward to the tutor dashboard JSP page
        request.getRequestDispatcher("/tutor_dashboard.jsp").forward(request, response);
    }
}
