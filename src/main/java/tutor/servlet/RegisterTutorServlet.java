package tutor.servlet;

import tutor.model.Tutor;
import tutor.util.TutorFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.MessageDigest;

@WebServlet("/RegisterTutorServlet")
public class RegisterTutorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        if (TutorFileUtil.usernameExists(username)) {
            response.sendRedirect("loginTutor.jsp?error=exists");
            return;
        }

        String tutorId = TutorFileUtil.generateUniqueTutorId();
        String fullName = request.getParameter("name");
        String subject = request.getParameter("subject");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String campusName = request.getParameter("campusName");
        String degreeCourse = request.getParameter("degreeCourse");
        String degreeLevel = request.getParameter("degreeLevel");
        String address = request.getParameter("address");
        String password = hashPassword(request.getParameter("password"));
        String about = request.getParameter("about");

        Tutor tutor = new Tutor(tutorId, username, fullName, subject, email, contact, campusName,
                degreeCourse, degreeLevel, address, password, about);
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
