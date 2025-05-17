package tutor.servlet;

import tutor.model.Tutor;
import tutor.util.TutorFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.security.MessageDigest;

/**
 * This servlet handles tutor registration.
 * It saves tutor data to file and supports profile image upload.
 */
@WebServlet("/RegisterTutorServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,     // 1MB buffer before writing to disk
        maxFileSize = 1024 * 1024 * 5,       // 5MB max per file
        maxRequestSize = 1024 * 1024 * 10    // 10MB total request size
)
public class RegisterTutorServlet extends HttpServlet {

<<<<<<< Updated upstream
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Step 1: Set file path for tutor records
        TutorFileUtil.setFilePath(getServletContext().getRealPath("/WEB-INF/tutors.txt"));

        // Step 2: Check for existing username
=======
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TutorFileUtil.setFilePath(getServletContext().getRealPath("/WEB-INF/tutors.txt"));
>>>>>>> Stashed changes
        String username = request.getParameter("username");
        if (TutorFileUtil.usernameExists(username)) {
            response.sendRedirect("loginTutor.jsp?error=exists");
            return;
        }

        // Step 3: Check for existing email
        String email = request.getParameter("email");
        if (TutorFileUtil.emailExists(email)) {
            response.sendRedirect("loginTutor.jsp?error=emailexists");
            return;
        }

        // Step 4: Collect form input
        String tutorId = TutorFileUtil.generateUniqueTutorId();
        String fullName = request.getParameter("name");
        String subject = request.getParameter("subject");
        String contact = request.getParameter("contact");
        String campusName = request.getParameter("campusName");
        String degreeCourse = request.getParameter("degreeCourse");
        String degreeLevel = request.getParameter("degreeLevel");
        String address = request.getParameter("address");
        String password = hashPassword(request.getParameter("password")); // hashed password
        String about = request.getParameter("about");

        // Step 5: Handle profile image upload
        Part filePart = request.getPart("profileImage");
        String fileName = null;

        if (filePart != null && filePart.getSize() > 0) {
            String uploadPath = getServletContext().getRealPath("/") + "image";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            fileName = tutorId + "_" + System.currentTimeMillis() + ".jpg";
            filePart.write(uploadPath + File.separator + fileName);
        }

        // Step 6: Create Tutor object and save
        Tutor tutor = new Tutor(tutorId, username, fullName, subject, email, contact,
                campusName, degreeCourse, degreeLevel, address, password, about, fileName);

        TutorFileUtil.saveTutor(tutor); // Save tutor to file and BST

        // Step 7: Redirect to login page with success message
        response.sendRedirect("loginTutor.jsp?success=true");
    }

    /**
     * Hashes a password using SHA-256 for secure storage.
     *
     * @param password plain text password
     * @return hashed string in hexadecimal
     */
    private String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes());
            StringBuilder hex = new StringBuilder();
            for (byte b : hash) {
                hex.append(String.format("%02x", b));
            }
            return hex.toString();
        } catch (Exception e) {
            return password; // fallback (not recommended)
        }
    }
}
