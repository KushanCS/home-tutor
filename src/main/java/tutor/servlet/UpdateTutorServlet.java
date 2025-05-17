package tutor.servlet;

import tutor.model.Tutor;
import tutor.util.TutorFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * Servlet that handles tutor profile updates, including optional profile picture replacement.
 */
@WebServlet("/UpdateTutorServlet")
@MultipartConfig  // Enables file upload support (e.g., profile image)
public class UpdateTutorServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Step 1: Check if the tutor is logged in
        HttpSession session = request.getSession();
        Tutor loggedInTutor = (Tutor) session.getAttribute("tutor");

        if (loggedInTutor == null) {
            // Redirect to login if session expired or user not logged in
            response.sendRedirect("loginTutor.jsp");
            return;
        }

        // Step 2: Get updated form fields
        String name = request.getParameter("name");
        String subject = request.getParameter("subject");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String campusName = request.getParameter("campusName");
        String degreeCourse = request.getParameter("degreeCourse");
        String degreeLevel = request.getParameter("degreeLevel");
        String address = request.getParameter("address");
        String about = request.getParameter("about");

        // Step 3: Update tutor object in session
        loggedInTutor.setName(name);
        loggedInTutor.setSubject(subject);
        loggedInTutor.setEmail(email);
        loggedInTutor.setContact(contact);
        loggedInTutor.setCampusName(campusName);
        loggedInTutor.setDegreeCourse(degreeCourse);
        loggedInTutor.setDegreeLevel(degreeLevel);
        loggedInTutor.setAddress(address);
        loggedInTutor.setAbout(about);

        // Step 4: Handle optional profile image upload
        Part filePart = request.getPart("profileImage");
        if (filePart != null && filePart.getSize() > 0) {
            // Set up the image folder path
            String uploadPath = getServletContext().getRealPath("/") + "image";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            // Generate a unique file name
            String fileName = loggedInTutor.getTutorId() + "_" + System.currentTimeMillis() + ".jpg";
            filePart.write(uploadPath + File.separator + fileName);

            // Update tutor's profile image path
            loggedInTutor.setProfileImage(fileName);
        }

        // Step 5: Update the tutor in the file
        List<Tutor> allTutors = TutorFileUtil.getAllTutors();
        for (int i = 0; i < allTutors.size(); i++) {
            if (allTutors.get(i).getTutorId().equals(loggedInTutor.getTutorId())) {
                allTutors.set(i, loggedInTutor);  // Replace existing tutor
                break;
            }
        }
        TutorFileUtil.saveAllTutors(allTutors);  // Overwrite entire file with updated list

        // Step 6: Rebuild in-memory BST
        TutorFileUtil.reloadBST();

        // Step 7: Update session data and redirect
        session.setAttribute("tutor", loggedInTutor);
        response.sendRedirect("tutor_dashboard.jsp?success=profile");
    }
}
