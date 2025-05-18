package admin.servlet;

import tutor.util.TutorFileUtil;
import tutor.model.Tutor;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/AdminDeleteTutorServlet")
public class AdminDeleteTutorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String filePath = getServletContext().getRealPath("/WEB-INF/tutors.txt");
        TutorFileUtil.setFilePath(filePath);

        String tutorId = request.getParameter("id");
        if (tutorId == null || tutorId.trim().isEmpty()) {
            request.getSession().setAttribute("error", "Tutor ID not provided.");
            response.sendRedirect("TutorManagementServlet?action=viewTutors");
            return;
        }

        // ✅ FIX: read from correct path
        List<Tutor> tutors = TutorFileUtil.readTutors(filePath);
        boolean removed = tutors.removeIf(t -> t.getTutorId().equalsIgnoreCase(tutorId));

        if (removed) {
            TutorFileUtil.saveAllTutors(tutors);  // ✅ overwrite file
            TutorFileUtil.reloadBST();            // ✅ update in-memory list
            request.getSession().setAttribute("message", "Tutor deleted successfully.");
        } else {
            request.getSession().setAttribute("error", "Tutor not found or could not be deleted.");
        }

        response.sendRedirect("TutorManagementServlet?action=viewTutors");
    }
}
