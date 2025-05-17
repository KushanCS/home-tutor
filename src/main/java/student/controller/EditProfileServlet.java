package student.controller;

import student.utils.StudentFileUtil;
import student.model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.http.Part;
import java.io.*;
import java.security.MessageDigest;
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet("/editProfile")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,    // 1MB
        maxFileSize       = 5 * 1024 * 1024, // 5MB
        maxRequestSize    = 6 * 1024 * 1024  // 6MB
)
public class EditProfileServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "image"; // Folder to store uploaded profile pictures

    // Handle GET request – display edit profile page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward request to editProfile.jsp; student info is loaded from session
        request.getRequestDispatcher("editProfile.jsp").forward(request, response);
    }

    // Handle POST request – update student profile data
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1) Verify session (must be logged in)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String originalUsername = (String) session.getAttribute("username");
        String dataFilePath     = getServletContext().getRealPath("/WEB-INF/students.txt");

        // 2) Load all students and find the currently logged-in one
        List<Student> students = StudentFileUtil.readStudents(dataFilePath);
        Student current = students.stream()
                .filter(s -> s.getUserName().equalsIgnoreCase(originalUsername))
                .findFirst().orElse(null);

        if (current == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 3) Check if username was changed and avoid duplicates
        String newUsername = request.getParameter("username").trim();
        if (!newUsername.equalsIgnoreCase(originalUsername)) {
            Student clash = StudentFileUtil.getStudentByUsername(newUsername, dataFilePath);
            if (clash != null) {
                request.setAttribute("error", "Username already taken.");
                request.getRequestDispatcher("editProfile.jsp").forward(request, response);
                return;
            }
        }

        // 4) If a new profile picture is uploaded, delete the old one
        String oldPicPath = current.getProfilePicPath();
        if (oldPicPath != null && !oldPicPath.startsWith("https://")) {
            File oldFile = new File(getServletContext().getRealPath(oldPicPath));
            if (oldFile.exists()) oldFile.delete();
        }

        // 5) Handle new profile picture upload (optional)
        Part filePart = request.getPart("profilePic");
        String fileName = filePart.getSubmittedFileName();
        if (fileName != null && !fileName.isEmpty()) {
            String appPath = getServletContext().getRealPath("");
            File   uploadDir = new File(appPath, UPLOAD_DIR);
            if (!uploadDir.exists()) uploadDir.mkdirs(); // Create folder if it doesn't exist

            String ext = fileName.substring(fileName.lastIndexOf('.'));
            String unique = System.currentTimeMillis() + "_" + newUsername + ext; // Unique file name
            File   dest = new File(uploadDir, unique);

            try (InputStream in = filePart.getInputStream();
                 OutputStream out = new FileOutputStream(dest)) {
                byte[] buf = new byte[1024];
                int    len;
                while ((len = in.read(buf)) > 0) out.write(buf, 0, len);
            }

            // Set new image path for student
            current.setProfilePicPath(UPLOAD_DIR + "/" + unique);
        }

        // 6) Update student information from the form
        current.setName(request.getParameter("name").trim());
        current.setUserName(newUsername);
        current.setEmail(request.getParameter("email").trim());
        current.setPhone(request.getParameter("phone").trim());
        current.setAddress(request.getParameter("address").trim());
        current.setCourse(request.getParameter("course").trim());
        current.setDob(request.getParameter("dob").trim());

        // If password is provided, update it with hashed value
        String pw = request.getParameter("password");
        if (pw != null && !pw.isEmpty()) {
            current.setPassword(hashPassword(pw));
        }

        // 7) Save the updated student list to the file
        StudentFileUtil.writeStudents(students, dataFilePath);

        // 8) Update session data and redirect to profile page
        session.setAttribute("username", newUsername);
        session.setAttribute("student", current);
        response.sendRedirect("profile.jsp");
    }

    // Utility method to hash password using SHA-256
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[]        bs = md.digest(password.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (byte b : bs) sb.append(String.format("%02x", b));
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException("Hashing failed", e);
        }
    }
}
