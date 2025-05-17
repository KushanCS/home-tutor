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
        HttpSession session = request.getSession();

// First check for admin login
        if ("dinijaya633".equals(username) && "123456789".equals(password)) {
            session.setAttribute("userType", "admin");
            session.setAttribute("username", username);
            session.setAttribute("fullName", "Administrator");
            response.sendRedirect(request.getContextPath() + "/adminDashboard.jsp");
            return;
        }

// Then check for student login
        try {
            String filePath = getServletContext().getRealPath("/WEB-INF/students.txt");
            Student student = StudentFileUtil.getStudentByUsername(username, filePath);

            if (student != null && student.getPassword().equals(hashPassword(password))) {
                session.setAttribute("userType", "student");
                session.setAttribute("username", student.getUserName());
                session.setAttribute("fullName", student.getName());
                session.setAttribute("email", student.getEmail()); // ✅ Added
                session.setAttribute("role", "student");            // ✅ Added
                session.setAttribute("student", student);
                response.sendRedirect("home-page.jsp");             // ✅ Changed from /student.jsp
                return;
            }

            // If neither admin nor student login succeeded
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("/login.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Login failed: " + e.getMessage());
            request.getRequestDispatcher("/login.jsp").forward(request, response);
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
