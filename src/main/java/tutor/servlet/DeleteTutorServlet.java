package tutor.servlet;

import tutor.model.Tutor;
import tutor.util.TutorFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Servlet to delete the currently logged-in tutor from the system.
 * Removes the tutor from the file, updates the BST, invalidates session, and redirects to login.
 */
@WebServlet("/DeleteTutorServlet")
public class DeleteTutorServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve session and currently logged-in tutor
        HttpSession session = request.getSession(false);
        Tutor tutor = (session != null) ? (Tutor) session.getAttribute("tutor") : null;

        // If not logged in, redirect to tutor login page
        if (tutor == null) {
            response.sendRedirect("loginTutor.jsp");
            return;
        }

        // Load all tutors from file
        List<Tutor> allTutors = TutorFileUtil.getAllTutors();

        // Remove the tutor matching the current tutor's ID
        allTutors.removeIf(t -> t.getTutorId().equals(tutor.getTutorId()));

        // Save updated tutor list back to the file
        TutorFileUtil.saveAllTutors(allTutors);

        // Rebuild the in-memory BST after deletion
        TutorFileUtil.reloadBST();

        // Invalidate session to log the tutor out
        session.invalidate();

        // Redirect to login page with a success flag
        response.sendRedirect("loginTutor.jsp?deleted=true");
    }
}
