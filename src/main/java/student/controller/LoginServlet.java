// Updated LoginServlet.java
package student.controller;

import student.utils.StudentFileUtil;
import student.model.Student;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.MessageDigest;
import java.nio.charset.StandardCharsets;

@WebServlet("/loginStudent")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String filePath = getServletContext().getRealPath("/WEB-INF/students.txt");

        try {
            Student student = StudentFileUtil.getStudentByUsername(username, filePath);

            if (student != null && student.getPassword().equals(hashPassword(password))) {
                HttpSession session = request.getSession();
                session.setAttribute("username", student.getUserName());
                session.setAttribute("email", student.getEmail());
                session.setAttribute("student", student);
                response.sendRedirect("home-page.jsp");
            } else {
                response.sendRedirect("login.jsp?error=invalid");
            }
        } catch (Exception e) {
            response.sendRedirect("login.jsp?error=exception");
        }
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
