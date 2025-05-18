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

@WebServlet("/AdminUpdateTutorServlet")
@MultipartConfig
public class AdminUpdateTutorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tutorId = request.getParameter("tutorId");
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String subject = request.getParameter("subject");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String about = request.getParameter("about");
        String newPassword = request.getParameter("newPassword");

        String filePath = getServletContext().getRealPath("/WEB-INF/tutors.txt");
        List<Tutor> tutors = TutorFileUtil.readTutors(filePath);

        boolean updated = false;
        for (Tutor tutor : tutors) {
            if (tutor.getTutorId().equals(tutorId)) {
                tutor.setName(name);
                tutor.setUsername(username);
                tutor.setSubject(subject);
                tutor.setEmail(email);
                tutor.setContact(contact);
                tutor.setAbout(about);

                if (newPassword != null && !newPassword.trim().isEmpty()) {
                    tutor.setPassword(newPassword);
                }

                Part imagePart = request.getPart("profileImage");
                if (imagePart != null && imagePart.getSize() > 0) {
                    String imageName = tutorId + "_" + imagePart.getSubmittedFileName();
                    String imageSavePath = getServletContext().getRealPath("/image") + File.separator + imageName;
                    imagePart.write(imageSavePath);
                    tutor.setProfileImage(imageName);
                }

                updated = true;
                break;
            }
        }

        if (updated) {
            TutorFileUtil.setFilePath(filePath); // ✅ required before saving
            TutorFileUtil.saveAllTutors(tutors); // ✅ now works
            request.getSession().setAttribute("message", "Tutor updated successfully.");
        } else {
            request.getSession().setAttribute("error", "Tutor not found.");
        }

        response.sendRedirect("TutorManagement.jsp");
    }
}
