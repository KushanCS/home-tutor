package tutor.servlet;

import tutor.model.Tutor;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class TutorDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check if tutor is logged in
        if (session == null || session.getAttribute("tutor") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Tutor tutor = (Tutor) session.getAttribute("tutor");
        request.setAttribute("tutor", tutor);

        // Forward to JSP page for display
        request.getRequestDispatcher("tutor_dashboard.jsp").forward(request, response);
    }
}
