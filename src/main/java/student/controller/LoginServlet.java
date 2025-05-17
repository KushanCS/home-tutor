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
// This servlet handles login requests for both students and the admin
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get login credentials from the request
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();

        // ✅ First, check for admin login
        if ("dinijaya633".equals(username) && "123456789".equals(password)) {
            session.setAttribute("userType", "admin");
            session.setAttribute("username", username);
            session.setAttribute("fullName", "Administrator");
            response.sendRedirect(request.getContextPath() + "/adminDashboard.jsp");
            return;
        }

        // ✅ Next, check for valid student credentials
        try {
            String filePath = getServletContext().getRealPath("/WEB-INF/students.txt");

            // Look up the student by username
            Student student = StudentFileUtil.getStudentByUsername(username, filePath);

            // If the student is found and password matches
            if (student != null && student.getPassword().equals(hashPassword(password))) {

                // Set all relevant session attributes for student
                session.setAttribute("userType", "student");
                session.setAttribute("username", student.getUserName());
                session.setAttribute("fullName", student.getName());
                session.setAttribute("email", student.getEmail()); // ✅ Additional info
                session.setAttribute("role", "student");           // ✅ For role-based features
                session.setAttribute("student", student);          // ✅ Store full student object

                // Redirect to student home page
                response.sendRedirect("home-page.jsp");
                return;
            }

            // ❌ If login fails (no matching admin or student)
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("/login.jsp").forward(request, response);

        } catch (Exception e) {
            // ⚠️ Handle unexpected errors during login
            request.setAttribute("error", "Login failed: " + e.getMessage());
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    // Utility method to hash passwords using SHA-256
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes(StandardCharsets.UTF_8));

            // Convert hashed bytes into a hexadecimal string
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
