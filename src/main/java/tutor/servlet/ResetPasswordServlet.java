package tutor.servlet;

import tutor.model.Tutor;
import tutor.util.TutorFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("resetUser");

        if (username == null) {
            response.sendRedirect("loginTutor.jsp");
            return;
        }

        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");

        if (!password.equals(confirm)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("reset_password.jsp").forward(request, response);
            return;
        }

        // Hash the new password
        String hashedPassword = hashPassword(password);

        List<Tutor> tutors = TutorFileUtil.getAllTutors();
        for (Tutor t : tutors) {
            if (t.getUsername().equalsIgnoreCase(username)) {
                t.setPassword(hashedPassword);
                break;
            }
        }

        TutorFileUtil.saveAllTutors(tutors);
        TutorFileUtil.reloadBST();

        session.removeAttribute("otp");
        session.removeAttribute("resetUser");

        response.sendRedirect("loginTutor.jsp?success=reset");
    }

    private String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] bytes = digest.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Password hashing failed", e);
        }
    }
}
