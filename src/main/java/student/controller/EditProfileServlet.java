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
<<<<<<< Updated upstream
// This servlet handles editing and updating the student's profile
public class EditProfileServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "image"; // Directory to store profile pictures
=======
public class EditProfileServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "image";
>>>>>>> Stashed changes

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
<<<<<<< Updated upstream
        // Forward request to editProfile.jsp
=======
        // Simply forward to JSP; the JSP reads 'student' from session
>>>>>>> Stashed changes
        request.getRequestDispatcher("editProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

<<<<<<< Updated upstream
        // 1) Verify user session
=======
        // 1) Verify session
>>>>>>> Stashed changes
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
<<<<<<< Updated upstream

        String originalUsername = (String) session.getAttribute("username");
        String dataFilePath = getServletContext().getRealPath("/WEB-INF/students.txt");

        // 2) Load all students and find the current logged-in student
        List<Student> students = StudentFileUtil.readStudents(dataFilePath);
        Student current = students.stream()
                .filter(s -> s.getUserName().equalsIgnoreCase(originalUsername))
                .findFirst().orElse(null);

        if (current == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 3) Check if username is changed and ensure it's not already taken
=======
        String originalUsername = (String) session.getAttribute("username");
        String dataFilePath     = getServletContext().getRealPath("/WEB-INF/students.txt");

        // 2) Load students, find current
        List<Student> students = StudentFileUtil.readStudents(dataFilePath);
        Student current = students.stream()
                .filter(s -> s.getUserName().equalsIgnoreCase(originalUsername))
                .findFirst().orElse(null);

        if (current == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 3) If username changed, ensure no clash
>>>>>>> Stashed changes
        String newUsername = request.getParameter("username").trim();
        if (!newUsername.equalsIgnoreCase(originalUsername)) {
            Student clash = StudentFileUtil.getStudentByUsername(newUsername, dataFilePath);
            if (clash != null) {
                request.setAttribute("error", "Username already taken.");
                request.getRequestDispatcher("editProfile.jsp").forward(request, response);
                return;
            }
        }

<<<<<<< Updated upstream
        // 4) Handle old profile picture deletion (if it exists and is local)
=======
        // Add before saving new pic:
>>>>>>> Stashed changes
        String oldPicPath = current.getProfilePicPath();
        if (oldPicPath != null && !oldPicPath.startsWith("https://")) {
            File oldFile = new File(getServletContext().getRealPath(oldPicPath));
            if (oldFile.exists()) oldFile.delete();
        }

<<<<<<< Updated upstream
        // 5) Handle new profile picture upload (if provided)
        Part filePart = request.getPart("profilePic");
        String fileName = filePart.getSubmittedFileName();

        if (fileName != null && !fileName.isEmpty()) {
            String appPath = getServletContext().getRealPath("");
            File uploadDir = new File(appPath, UPLOAD_DIR);
=======
        // 4) Handle optional profile pic
        Part filePart = request.getPart("profilePic");
        String fileName = filePart.getSubmittedFileName();
        if (fileName != null && !fileName.isEmpty()) {
            String appPath = getServletContext().getRealPath("");
            File   uploadDir = new File(appPath, UPLOAD_DIR);
>>>>>>> Stashed changes
            if (!uploadDir.exists()) uploadDir.mkdirs();

            String ext = fileName.substring(fileName.lastIndexOf('.'));
            String unique = System.currentTimeMillis() + "_" + newUsername + ext;
<<<<<<< Updated upstream
            File dest = new File(uploadDir, unique);
=======
            File   dest = new File(uploadDir, unique);
>>>>>>> Stashed changes

            try (InputStream in = filePart.getInputStream();
                 OutputStream out = new FileOutputStream(dest)) {
                byte[] buf = new byte[1024];
<<<<<<< Updated upstream
                int len;
                while ((len = in.read(buf)) > 0) out.write(buf, 0, len);
            }

            current.setProfilePicPath(UPLOAD_DIR + "/" + unique);
        }

        // 6) Update the student object with new values
=======
                int    len;
                while ((len = in.read(buf)) > 0) out.write(buf, 0, len);
            }
            current.setProfilePicPath(UPLOAD_DIR + "/" + unique);
        }

        // 5) Update fields
>>>>>>> Stashed changes
        current.setName(request.getParameter("name").trim());
        current.setUserName(newUsername);
        current.setEmail(request.getParameter("email").trim());
        current.setPhone(request.getParameter("phone").trim());
        current.setAddress(request.getParameter("address").trim());
        current.setCourse(request.getParameter("course").trim());
        current.setDob(request.getParameter("dob").trim());

<<<<<<< Updated upstream
        // 7) If password field is filled, hash and update it
=======
>>>>>>> Stashed changes
        String pw = request.getParameter("password");
        if (pw != null && !pw.isEmpty()) {
            current.setPassword(hashPassword(pw));
        }

<<<<<<< Updated upstream
        // 8) Save all updated students back to file
        StudentFileUtil.writeStudents(students, dataFilePath);

        // 9) Update session and redirect to profile page
=======
        // 6) Persist back to file
        StudentFileUtil.writeStudents(students, dataFilePath);

        // 7) Update session and redirect
>>>>>>> Stashed changes
        session.setAttribute("username", newUsername);
        session.setAttribute("student", current);
        response.sendRedirect("profile.jsp");
    }

<<<<<<< Updated upstream
    // Hash password using SHA-256
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] bs = md.digest(password.getBytes(StandardCharsets.UTF_8));
=======
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[]        bs = md.digest(password.getBytes(StandardCharsets.UTF_8));
>>>>>>> Stashed changes
            StringBuilder sb = new StringBuilder();
            for (byte b : bs) sb.append(String.format("%02x", b));
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException("Hashing failed", e);
        }
    }
}
