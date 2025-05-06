package student.controller;

import student.utils.StudentFileUtil;
import student.model.Student;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.MessageDigest;
import java.nio.charset.StandardCharsets;
import java.util.List;

public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String filePath = getServletContext().getRealPath("/WEB-INF/students.txt");

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
