package student.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import student.services.Student;
import student.model.StudentFileUtil;
import java.io.*;
import java.security.MessageDigest;
import java.nio.charset.StandardCharsets;

public class LoginServlet extends HttpServlet {

    private static final String ADMIN_USERNAME = "dinijaya633";
    private static final String ADMIN_PASSWORD = "123456789";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String path = request.getServletPath();

        System.out.println("Path: " + path + ", Action: " + action); // Debug

        if ("register".equals(action)) {
            handleRegistration(request, response);
        } else if ("login".equals(action)) {
            handleLogin(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();

        try {
            // Admin login check
            if (ADMIN_USERNAME.equals(username)) {
                if (ADMIN_PASSWORD.equals(password)) {
                    session.setAttribute("userType", "admin");
                    session.setAttribute("username", username);
                    session.setAttribute("fullName", "Administrator");
                    System.out.println("Redirecting to admin dashboard");
                    response.sendRedirect(request.getContextPath() + "/adminDashboard.jsp");
                    return;
                } else {
                    request.setAttribute("error", "Invalid admin password!");
                    request.getRequestDispatcher("/login.jsp").forward(request, response);
                    return;
                }
            }

            // Student login logic
            String studentFilePath = getServletContext().getRealPath("/WEB-INF/student.txt");
            Student student = StudentFileUtil.getStudentByUsername(username, studentFilePath);

            if (student != null && student.getPassword().equals(hashPassword(password))) {
                session.setAttribute("user", student);
                session.setAttribute("userType", "student");
                session.setAttribute("username", username);
                session.setAttribute("fullName", student.getName());
                response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
                return;
            }

            request.setAttribute("error", "Invalid username or password!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Login failed: " + e.getMessage());
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    private void handleRegistration(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String username = request.getParameter("username");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        try {
            String studentFilePath = getServletContext().getRealPath("/WEB-INF/student.txt");

            if (StudentFileUtil.getStudentByUsername(username, studentFilePath) != null) {
                request.setAttribute("error", "Username already exists!");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
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

            StudentFileUtil.saveStudent(student, studentFilePath);
            request.setAttribute("message", "Registration successful! Please login.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }

    private String generateStudentId() {
        return "STU" + (1000 + (int)(Math.random() * 9000));
    }

    private String hashPassword(String password) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(password.getBytes(StandardCharsets.UTF_8));
        StringBuilder hexString = new StringBuilder();
        for (byte b : hash) {
            hexString.append(String.format("%02x", b));
        }
        return hexString.toString();
    }
}