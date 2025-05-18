package tutor.servlet;

import tutor.model.Tutor;
import tutor.util.TutorFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/DeleteTutorServlet")
public class DeleteTutorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Tutor tutor = (Tutor) session.getAttribute("tutor");

        if (tutor == null) {
            response.sendRedirect("loginTutor.jsp");
            return;
        }

        List<Tutor> allTutors = TutorFileUtil.getAllTutors();
        allTutors.removeIf(t -> t.getTutorId().equals(tutor.getTutorId()));
        TutorFileUtil.saveAllTutors(allTutors);
        TutorFileUtil.reloadBST();

        session.invalidate(); // logout
        response.sendRedirect("loginTutor.jsp?deleted=true");
    }
}
