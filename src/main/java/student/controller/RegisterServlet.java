package student.controller;

import student.utils.StudentFileUtil;
import student.model.Student;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.security.MessageDigest;
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet("/registerStudent")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,     // 1MB
        maxFileSize       = 5 * 1024 * 1024, // 5MB
        maxRequestSize    = 6 * 1024 * 1024  // 6MB
)
// This servlet handles student registration including file upload and validation
public class RegisterServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "image"; // Folder to store profile pictures

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Step 1: Get form input
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String filePath = getServletContext().getRealPath("/WEB-INF/students.txt"); // Student data file
        String appPath = request.getServletContext().getRealPath("");               // App root for file upload
        File uploadDir = new File(appPath, UPLOAD_DIR);
        if (!uploadDir.exists()) uploadDir.mkdirs(); // Create directory if not exists

        // Step 2: Check if passwords match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("login.jsp?error=nomatch");
            return;
        }

        try {
            // Step 3: Check if username already exists
            String requestUsername = request.getParameter("username");
            Student existing = StudentFileUtil.getStudentByUsername(requestUsername, filePath);
            if (existing != null) {
                response.sendRedirect("login.jsp?error=exists");
                return;
            }

            // Step 4: Handle profile picture upload
            Part filePart = request.getPart("profilePic");
            String submittedName = filePart.getSubmittedFileName();
            String ext = submittedName.substring(submittedName.lastIndexOf('.'));
            String uniqueName = "student_" + System.currentTimeMillis() + "_" + requestUsername + ext;
            File file = new File(uploadDir, uniqueName);

            // Save uploaded image to server
            try (InputStream in = filePart.getInputStream();
                 FileOutputStream out = new FileOutputStream(file)) {
                byte[] buf = new byte[1024];
                int len;
                while ((len = in.read(buf)) > 0) out.write(buf, 0, len);
            }

            // Relative path to saved profile image
            String relativePath = UPLOAD_DIR + "/" + uniqueName;

            // Step 5: Create a new Student object with form input and image path
            Student student = new Student(
                    generateStudentId(),
                    request.getParameter("fullName"),
                    requestUsername,
                    request.getParameter("email"),
                    request.getParameter("contact"),
                    request.getParameter("address"),
                    hashPassword(password),                        // Store hashed password
                    request.getParameter("course"),
                    request.getParameter("dob"),
                    relativePath
            );

            // Step 6: Save new student to file
            List<Student> students = StudentFileUtil.readStudents(filePath);
            students.add(student);
            StudentFileUtil.writeStudents(students, filePath);

            // Step 7: Redirect with success message
            response.sendRedirect("login.jsp?message=registered");

        } catch (Exception e) {
            // If registration fails, redirect with error flag
            response.sendRedirect("login.jsp?error=failed");
        }
    }

    /**
     * Generates a unique student ID like STU1234.
     */
    private String generateStudentId() {
        return "STU" + (1000 + (int)(Math.random() * 9000));
    }

    /**
     * Hashes the password using SHA-256 for security.
     */
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
