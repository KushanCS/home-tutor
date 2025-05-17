package tutor.servlet;

import tutor.model.Tutor;
import tutor.util.TutorFileUtil;
import tutor.bst.TutorBST;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.MessageDigest;

@WebServlet("/LoginTutorServlet")
public class LoginTutorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TutorFileUtil.setFilePath(getServletContext().getRealPath("/WEB-INF/tutors.txt"));
        String input = request.getParameter("username");
        String password = request.getParameter("password");
        String hashedPassword = hashPassword(password);

        TutorBST bst = TutorFileUtil.getTutorBST();
        Tutor found = bst.search(input); // could be ID or username

        if (found != null && found.getPassword().equals(hashedPassword)) {
            HttpSession session = request.getSession();
            session.setAttribute("tutor", found);
            session.setAttribute("tutorId", found.getTutorId());
            session.setAttribute("role", "tutor");
            response.sendRedirect("tutor_dashboard.jsp");
        } else {
            response.sendRedirect("loginTutor.jsp?error=invalid");
        }
    }

    private String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes());
            StringBuilder hex = new StringBuilder();
            for (byte b : hash) hex.append(String.format("%02x", b));
            return hex.toString();
        } catch (Exception e) {
            return password;
        }
    }
}
