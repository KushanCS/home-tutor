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

    // Handles student and admin login
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get login form data
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();

        // ==== 1) Check for admin login ====
        if ("dinijaya633".equals(username) && "123456789".equals(password)) {
            session.setAttribute("userType", "admin");
            session.setAttribute("username", username);
            session.setAttribute("fullName", "Administrator");
            // Redirect to admin dashboard if admin credentials are correct
            response.sendRedirect(request.getContextPath() + "/adminDashboard.jsp");
            return;
        }

        // ==== 2) Check for student login ====
        try {
            // Load student file and search by username
            String filePath = getServletContext().getRealPath("/WEB-INF/students.txt");
            Student student = StudentFileUtil.getStudentByUsername(username, filePath);

            // Check if student exists and password matches after hashing
            if (student != null && student.getPassword().equals(hashPassword(password))) {
                // Store student data in session
                session.setAttribute("userType", "student");
                session.setAttribute("username", student.getUserName());
                session.setAttribute("fullName", student.getName());
                session.setAttribute("email", student.getEmail()); // Used for personalization
                session.setAttribute("role", "student");           // Useful for role-based control
                session.setAttribute("student", student);          // Store full object for easy access

                // Redirect to student home page after successful login
                response.sendRedirect("home-page.jsp");
                return;
            }

            // If login fails (invalid credentials)
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("/login.jsp").forward(request, response);

        } catch (Exception e) {
            // Handle unexpected errors during login process
            request.setAttribute("error", "Login failed: " + e.getMessage());
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    // Utility method to hash passwords using SHA-256
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
