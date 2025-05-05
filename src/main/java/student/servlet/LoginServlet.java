package student.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.security.MessageDigest;
import java.nio.charset.StandardCharsets;

import student.services.Student;
import tutor.model.Tutor;
import student.model.StudentFileUtil;
import tutor.util.FileUtil;

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
            String filePath = getServletContext().getRealPath("/WEB-INF/student.txt");

            if (StudentFileUtil.getStudentByUsername(username, filePath) != null) {
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

            StudentFileUtil.saveStudent(student, filePath);
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

        String studentPath = getServletContext().getRealPath("/WEB-INF/student.txt");
        String tutorPath = getServletContext().getRealPath("/WEB-INF/tutor.txt");

        try {
            // Try student login
            Student student = StudentFileUtil.getStudentByUsername(username, studentPath);
            if (student != null) {
                String hashedInput = hashPassword(password);
                System.out.println("[DEBUG] Student Login → Hashed Entered: " + hashedInput);
                System.out.println("[DEBUG] Student Stored → Password: " + student.getPassword());

                if (student.getPassword().equals(hashedInput)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("role", "student");
                    session.setAttribute("username", username);
                    session.setAttribute("fullName", student.getName());
                    session.setAttribute("student", student);
                    response.sendRedirect("dashboard.jsp");
                    return;
                }
            }

            // Try tutor login
            Tutor tutor = FileUtil.getTutorByUsername(username, tutorPath);
            if (tutor != null) {
                String hashedInput = hashPassword(password);
                System.out.println("[DEBUG] Tutor Login → Hashed Entered: " + hashedInput);
                System.out.println("[DEBUG] Tutor Stored → Password: " + tutor.getPassword());

                if (tutor.getPassword().equals(hashedInput)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("role", "tutor");
                    session.setAttribute("username", username);
                    session.setAttribute("tutor", tutor);
                    response.sendRedirect("tutorDashboard"); // must be mapped in web.xml
                    return;
                }
            }

            // If neither match
            request.setAttribute("error", "Invalid username or password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } catch (IOException e) {
            request.setAttribute("error", "Login failed: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private String generateStudentId() {
        int randomNum = 1000 + (int)(Math.random() * 9000);
        return "STU" + randomNum;
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
