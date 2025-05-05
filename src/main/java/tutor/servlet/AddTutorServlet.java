package tutor.servlet;

import tutor.model.Tutor;
import tutor.util.FileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.MessageDigest;
import java.nio.charset.StandardCharsets;
import java.util.UUID;

@WebServlet("/addTutor")
public class AddTutorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = UUID.randomUUID().toString();
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String subject = request.getParameter("subject");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String campusName = request.getParameter("campusName");
        String degreeCourse = request.getParameter("degreeCourse");
        String degreeLevel = request.getParameter("degreeLevel");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String about = request.getParameter("about");

        String filePath = getServletContext().getRealPath("/WEB-INF/tutor.txt");

        // Check for duplicate username
        if (FileUtil.getTutorByUsername(username, filePath) != null) {
            request.setAttribute("error", "Username already exists!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Hash password before saving
        String hashedPassword = hashPassword(password);

        Tutor tutor = new Tutor(id, username, name, subject, email, contact,
                campusName, degreeCourse, degreeLevel, address, hashedPassword, about);
        FileUtil.addTutor(tutor, filePath);

        response.sendRedirect("login.jsp?message=success");
    }

    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
        } catch (Exception e) {
            throw new RuntimeException("Password hashing failed", e);
        }
    }
}
