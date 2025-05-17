package tutor.servlet;

import tutor.model.Tutor;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * This servlet handles requests to the tutor's dashboard page.
 * It verifies session, retrieves the logged-in tutor,
 * and forwards the request to the dashboard JSP.
 */
@WebServlet("/tutor/dashboard")
public class DashboardTutorServlet extends HttpServlet {

    /**
     * Handles GET requests to show the tutor dashboard.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get existing session without creating a new one
        HttpSession session = request.getSession(false);

        // Retrieve tutor object from session (null if not logged in)
        Tutor tutor = (session != null) ? (Tutor) session.getAttribute("tutor") : null;

        // If not logged in, redirect to tutor login page
        if (tutor == null) {
            response.sendRedirect("loginTutor.jsp");
            return;
        }

        // Optional: Set the tutor object into request scope for use in JSP
        request.setAttribute("tutor", tutor);

        // Forward to the tutor dashboard JSP page
        request.getRequestDispatcher("/tutor_dashboard.jsp").forward(request, response);
    }
}
