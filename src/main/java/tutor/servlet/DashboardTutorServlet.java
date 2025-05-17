package tutor.servlet;

import tutor.model.Tutor;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/tutor/dashboard")
public class DashboardTutorServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Tutor tutor = (session != null) ? (Tutor) session.getAttribute("tutor") : null;

        if (tutor == null) {
            response.sendRedirect("loginTutor.jsp");
            return;
        }

        request.setAttribute("tutor", tutor); // (optional) available via request scope
        request.getRequestDispatcher("/tutor_dashboard.jsp").forward(request, response);
    }
}
