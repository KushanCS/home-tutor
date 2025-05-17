package tutor.servlet;

import tutor.model.Tutor;
import tutor.util.TutorFileUtil;
import tutor.bst.TutorBST;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.MessageDigest;

/**
 * This servlet handles login functionality for tutors.
 * It verifies credentials using a Binary Search Tree (BST) and redirects accordingly.
 */
@WebServlet("/LoginTutorServlet")
public class LoginTutorServlet extends HttpServlet {

    /**
     * Processes POST requests from the tutor login form.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
<<<<<<< Updated upstream

        // Set the path to the tutors file (used by TutorFileUtil)
        TutorFileUtil.setFilePath(getServletContext().getRealPath("/WEB-INF/tutors.txt"));

        // Step 1: Get login input
        String input = request.getParameter("username");  // Can be username or tutor ID
=======
        TutorFileUtil.setFilePath(getServletContext().getRealPath("/WEB-INF/tutors.txt"));
        String input = request.getParameter("username");
>>>>>>> Stashed changes
        String password = request.getParameter("password");
        String hashedPassword = hashPassword(password);   // Securely hash the password

        // Step 2: Get the BST and search for the tutor using input
        TutorBST bst = TutorFileUtil.getTutorBST();
        Tutor found = bst.search(input);  // Accepts username or ID

        // Step 3: Validate credentials
        if (found != null && found.getPassword().equals(hashedPassword)) {
            // Step 4: Create a session and store tutor information
            HttpSession session = request.getSession();
<<<<<<< Updated upstream
            session.setAttribute("tutor", found);              // Full Tutor object
            session.setAttribute("tutorId", found.getTutorId());
            session.setAttribute("role", "tutor");             // For role-based access

            // Step 5: Redirect to the tutor dashboard
=======
            session.setAttribute("tutor", found);
            session.setAttribute("tutorId", found.getTutorId());
            session.setAttribute("role", "tutor");
>>>>>>> Stashed changes
            response.sendRedirect("tutor_dashboard.jsp");
        } else {
            // Step 6: Redirect back to login with an error message
            response.sendRedirect("loginTutor.jsp?error=invalid");
        }
    }

    /**
     * Hashes a password using SHA-256 for secure storage and comparison.
     *
     * @param password the plain text password
     * @return hashed string in hexadecimal format
     */
    private String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes());

            // Convert byte array into hex string
            StringBuilder hex = new StringBuilder();
            for (byte b : hash) {
                hex.append(String.format("%02x", b));
            }
            return hex.toString();

        } catch (Exception e) {
            // Fallback: return raw password if hashing fails (not recommended)
            return password;
        }
    }
}
