package tutor.servlet;

import tutor.model.Tutor;
import tutor.util.TutorFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Servlet responsible for deleting the currently logged-in tutor's profile.
 * Once deleted, the tutor is logged out and redirected to the login page.
 */
@WebServlet("/DeleteTutorServlet")
public class DeleteTutorServlet extends HttpServlet {

    /**
     * Handles POST request to delete a tutor account.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Step 1: Validate session and retrieve the logged-in tutor
        HttpSession session = request.getSession(false);
        Tutor tutor = (session != null) ? (Tutor) session.getAttribute("tutor") : null;

        if (tutor == null) {
            // If no tutor is logged in, redirect to login page
            response.sendRedirect("loginTutor.jsp");
            return;
        }

        // Step 2: Load all tutors from the file
        List<Tutor> allTutors = TutorFileUtil.getAllTutors();

        // Step 3: Remove the current tutor from the list by matching tutorId
        allTutors.removeIf(t -> t.getTutorId().equals(tutor.getTutorId()));

        // Step 4: Save updated tutor list back to file
        TutorFileUtil.saveAllTutors(allTutors);

        // Step 5: Rebuild the BST (used for searching/logins)
        TutorFileUtil.reloadBST();

        // Step 6: Invalidate session to log the tutor out
        session.invalidate();

        // Step 7: Redirect to login page with success message
        response.sendRedirect("loginTutor.jsp?deleted=true");
    }
}
