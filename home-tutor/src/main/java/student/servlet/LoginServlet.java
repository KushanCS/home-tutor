package student.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import student.services.Student;
import student.model.StudentFileUtil;
import java.io.*;
import java.security.MessageDigest;
import java.nio.charset.StandardCharsets;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if ("register".equals(action)) {
            handleRegistration(request, response, username, password);
        } else if ("login".equals(action)) {
            handleLogin(request, response, username, password);
        }
    }

    private void handleRegistration(HttpServletRequest request, HttpServletResponse response,
                                    String username, String password)
            throws ServletException, IOException {

        String confirmPassword = request.getParameter("confirmPassword");
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try {
            if (StudentFileUtil.getStudentByUsername(username) != null) {
                request.setAttribute("error", "Username already exists!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            Student student = new Student(
                    generateStudentId(),
                    request.getParameter("fullName"),
                    username,
                    request.getParameter("email"),
                    request.getParameter("contact"),
                    request.getParameter("address"),
                    hashPassword(password),
                    request.getParameter("course"),
                    request.getParameter("dob")
            );

            StudentFileUtil.saveStudent(student);
            request.setAttribute("message", "Registration successful! You can now log in.");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } catch (IOException e) {
            request.setAttribute("error", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response,
                             String username, String password)
            throws ServletException, IOException {

        try {
            Student student = StudentFileUtil.getStudentByUsername(username);

            // Debug output
            System.out.println("Entered password: " + password);
            System.out.println("Hashed entered password: " + hashPassword(password));
            System.out.println("Stored password: " + (student != null ? student.getPassword() : "null"));

            if (student != null && student.getPassword().equals(hashPassword(password))) {
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("fullName", student.getName());
                session.setAttribute("student", student);
                response.sendRedirect("dashboard.jsp");
            } else {
                request.setAttribute("error", "Invalid username or password!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (IOException e) {
            request.setAttribute("error", "Login failed: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private String generateStudentId() {
        return "STU" + System.currentTimeMillis();
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