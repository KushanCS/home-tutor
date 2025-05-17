// Updated RegisterServlet.java
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
public class RegisterServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "image";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String filePath = getServletContext().getRealPath("/WEB-INF/students.txt");
        String appPath = request.getServletContext().getRealPath("");
        File uploadDir = new File(appPath, UPLOAD_DIR);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        if (!password.equals(confirmPassword)) {
            response.sendRedirect("login.jsp?error=nomatch");
            return;
        }

        try {
            String requestUsername = request.getParameter("username");
            Student existing = StudentFileUtil.getStudentByUsername(requestUsername, filePath);
            if (existing != null) {
                response.sendRedirect("login.jsp?error=exists");
                return;
            }

            Part filePart = request.getPart("profilePic");
            String submittedName = filePart.getSubmittedFileName();
            String ext = submittedName.substring(submittedName.lastIndexOf('.'));
            String uniqueName = "student_" + System.currentTimeMillis() + "_" + requestUsername + ext;
            File file = new File(uploadDir, uniqueName);

            try (InputStream in = filePart.getInputStream();
                 FileOutputStream out = new FileOutputStream(file)) {
                byte[] buf = new byte[1024];
                int len;
                while ((len = in.read(buf)) > 0) out.write(buf, 0, len);
            }

            String relativePath = UPLOAD_DIR + "/" + uniqueName;

            Student student = new Student(
                    generateStudentId(),
                    request.getParameter("fullName"),
                    request.getParameter("username"),
                    request.getParameter("email"),
                    request.getParameter("contact"),
                    request.getParameter("address"),
                    hashPassword(password),
                    request.getParameter("course"),
                    request.getParameter("dob"),
                    relativePath
            );

            List<Student> students = StudentFileUtil.readStudents(filePath);
            students.add(student);
            StudentFileUtil.writeStudents(students, filePath);

            response.sendRedirect("login.jsp?message=registered");

        } catch (Exception e) {
            response.sendRedirect("login.jsp?error=failed");
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
