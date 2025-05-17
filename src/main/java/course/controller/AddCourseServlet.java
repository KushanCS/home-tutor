package course.controller;

import course.model.Course;
import course.utils.CourseFileUtil;
import tutor.model.Tutor;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/AddCourseServlet")
@MultipartConfig(
<<<<<<< Updated upstream
        fileSizeThreshold = 1024 * 1024,    // 1MB - when file exceeds this size, it's written to disk
        maxFileSize = 5 * 1024 * 1024,      // 5MB - maximum allowed size for uploaded file
        maxRequestSize = 10 * 1024 * 1024   // 10MB - maximum allowed size for multipart/form-data request
=======
        fileSizeThreshold = 1024 * 1024,    // 1MB
        maxFileSize = 5 * 1024 * 1024,      // 5MB
        maxRequestSize = 10 * 1024 * 1024   // 10MB
>>>>>>> Stashed changes
)
public class AddCourseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

<<<<<<< Updated upstream
        // Get the currently logged-in tutor from the session
        Tutor tutor = (Tutor) request.getSession().getAttribute("tutor");

        // If no tutor is found in session (not logged in), redirect to tutor login page
=======
        // ✅ Get tutor from session
        Tutor tutor = (Tutor) request.getSession().getAttribute("tutor");
>>>>>>> Stashed changes
        if (tutor == null) {
            response.sendRedirect("loginTutor.jsp");
            return;
        }

<<<<<<< Updated upstream
        // Extract tutor details to associate with the new course
=======
>>>>>>> Stashed changes
        String tutorId = tutor.getTutorId();
        String tutorName = tutor.getName();
        String tutorSubject = tutor.getSubject();

<<<<<<< Updated upstream
        // Retrieve course details submitted via the form
=======
        // Get form data
>>>>>>> Stashed changes
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String level = request.getParameter("level");
        String price = request.getParameter("price");
        String duration = request.getParameter("duration");

<<<<<<< Updated upstream
        // Handle image upload from the form
        Part imagePart = request.getPart("image"); // Get the uploaded image part
        String imageFileName = imagePart.getSubmittedFileName(); // Extract filename

        // Define the folder path to save uploaded images on server
        String imageFolderPath = getServletContext().getRealPath("/images");

        // Create image directory if it does not exist
        File imageFolder = new File(imageFolderPath);
        if (!imageFolder.exists()) imageFolder.mkdirs();

        // Save the uploaded image file to the server
=======
        // Handle image upload
        Part imagePart = request.getPart("image");
        String imageFileName = imagePart.getSubmittedFileName();
        String imageFolderPath = getServletContext().getRealPath("/images");

        File imageFolder = new File(imageFolderPath);
        if (!imageFolder.exists()) imageFolder.mkdirs();

>>>>>>> Stashed changes
        if (imageFileName != null && !imageFileName.isEmpty()) {
            File imageFile = new File(imageFolder, imageFileName);
            try (InputStream input = imagePart.getInputStream();
                 OutputStream output = new FileOutputStream(imageFile)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = input.read(buffer)) != -1) {
                    output.write(buffer, 0, bytesRead);
                }
            }
        }

<<<<<<< Updated upstream
        // Generate a unique ID for the new course
        String courseId = CourseFileUtil.generateCourseId();

        // Define the path to the course storage file
        String filePath = getServletContext().getRealPath("/WEB-INF/courses.txt");

        // Create a new Course object with all the gathered data
        Course course = new Course(
                courseId, tutorId, tutorName, tutorSubject,
                name, description, level, imageFileName, price, duration
        );

        // Save the course to the file
        CourseFileUtil.saveCourse(course, filePath);

        // Redirect tutor to view the list of their courses
=======
        String courseId = CourseFileUtil.generateCourseId();
        String filePath = getServletContext().getRealPath("/WEB-INF/courses.txt");

        Course course = new Course(courseId, tutorId, tutorName, tutorSubject, name, description, level, imageFileName, price, duration);
        CourseFileUtil.saveCourse(course, filePath);

>>>>>>> Stashed changes
        response.sendRedirect("view_courses.jsp");
    }
}
