package tutor.servlet;

import tutor.model.Tutor;
import tutor.util.TutorFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.security.MessageDigest;

@WebServlet("/RegisterTutorServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 5, // 5MB
        maxRequestSize = 1024 * 1024 * 10) // 10MB
public class RegisterTutorServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TutorFileUtil.setFilePath(getServletContext().getRealPath("/WEB-INF/tutors.txt"));
        String username = request.getParameter("username");
        if (TutorFileUtil.usernameExists(username)) {
            response.sendRedirect("loginTutor.jsp?error=exists");
            return;
        }


        String email = request.getParameter("email");
        if (TutorFileUtil.emailExists(email)) {
            response.sendRedirect("loginTutor.jsp?error=emailexists");
            return;
        }

        String tutorId = TutorFileUtil.generateUniqueTutorId();
        String fullName = request.getParameter("name");
        String subject = request.getParameter("subject");
        String contact = request.getParameter("contact");
        String campusName = request.getParameter("campusName");
        String degreeCourse = request.getParameter("degreeCourse");
        String degreeLevel = request.getParameter("degreeLevel");
        String address = request.getParameter("address");
        String password = hashPassword(request.getParameter("password"));
        String about = request.getParameter("about");

        // Handle image upload
        Part filePart = request.getPart("profileImage");
        String fileName = null;
        if (filePart != null && filePart.getSize() > 0) {
            String uploadPath = getServletContext().getRealPath("/") + "image";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            fileName = tutorId + "_" + System.currentTimeMillis() + ".jpg";
            filePart.write(uploadPath + File.separator + fileName);
        }

        Tutor tutor = new Tutor(tutorId, username, fullName, subject, email, contact, campusName,
                degreeCourse, degreeLevel, address, password, about, fileName);

        TutorFileUtil.saveTutor(tutor);
        response.sendRedirect("loginTutor.jsp?success=true");
    }

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
            return password;
        }
    }
}
