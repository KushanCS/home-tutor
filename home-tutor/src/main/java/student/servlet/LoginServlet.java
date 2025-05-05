package student.servlet;

import student.model.StudentFileUtil;
import student.services.Student;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.MessageDigest;
import java.nio.charset.StandardCharsets;
import java.util.List;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String filePath = getServletContext().getRealPath("/WEB-INF/students.txt");

        if ("register".equals(action)) {
            handleRegistration(request, response, filePath);
        } else if ("login".equals(action)) {
            handleLogin(request, response, filePath);
        }
    }

    private void handleRegistration(HttpServletRequest request, HttpServletResponse response, String filePath)
            throws ServletException, IOException {

        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try {
            Student existing = StudentFileUtil.getStudentByUsername(request.getParameter("username"), filePath);
            if (existing != null) {
                request.setAttribute("error", "Username already exists!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            Student student = new Student(
                    generateStudentId(),
                    request.getParameter("fullName"),
                    request.getParameter("username"),
                    request.getParameter("email"),
                    request.getParameter("contact"),
                    request.getParameter("address"),
                    hashPassword(password),
                    request.getParameter("course"),
                    request.getParameter("dob")
            );

            List<Student> students = StudentFileUtil.readStudents(filePath);
            students.add(student);
            StudentFileUtil.writeStudents(students, filePath);

            request.setAttribute("message", "Registration successful! Please login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response, String filePath)
            throws ServletException, IOException {

        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            Student student = StudentFileUtil.getStudentByUsername(username, filePath);

            if (student != null && student.getPassword().equals(hashPassword(password))) {
                HttpSession session = request.getSession();
                session.setAttribute("username", student.getUserName());
                session.setAttribute("email", student.getEmail());
                session.setAttribute("student", student);
                response.sendRedirect("home-page.jsp");
            } else {
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Login failed: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private String generateStudentId() {
        return "STU" + (1000 + (int)(Math.random() * 9000));
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