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
        fileSizeThreshold = 1024 * 1024,    // Temporary file size threshold (1MB)
        maxFileSize = 5 * 1024 * 1024,      // Max single file size (5MB)
        maxRequestSize = 10 * 1024 * 1024   // Max total request size (10MB)
)
public class AddCourseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Retrieve logged-in tutor object from session
        Tutor tutor = (Tutor) request.getSession().getAttribute("tutor");

        // If no tutor is logged in, redirect to login page
        if (tutor == null) {
            response.sendRedirect("loginTutor.jsp");
            return;
        }

        // ✅ Extract basic tutor details
        String tutorId = tutor.getTutorId();
        String tutorName = tutor.getName();
        String tutorSubject = tutor.getSubject();

        // ✅ Retrieve course details from the submitted form
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String level = request.getParameter("level");
        String price = request.getParameter("price");
        String duration = request.getParameter("duration");

        // ✅ Handle uploaded image file
        Part imagePart = request.getPart("image");
        String imageFileName = imagePart.getSubmittedFileName(); // Get the file name
        String imageFolderPath = getServletContext().getRealPath("/images"); // Server path to store images

        // Create the image folder if it doesn't exist
        File imageFolder = new File(imageFolderPath);
        if (!imageFolder.exists()) imageFolder.mkdirs();

        // Save the uploaded image file to the server
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

        // ✅ Generate a unique ID for the new course
        String courseId = CourseFileUtil.generateCourseId();

        // ✅ Path to the file where course data is stored
        String filePath = getServletContext().getRealPath("/WEB-INF/courses.txt");

        // ✅ Create a new Course object with all data
        Course course = new Course(
                courseId, tutorId, tutorName, tutorSubject,
                name, description, level, imageFileName, price, duration
        );

        // ✅ Save the course to file
        CourseFileUtil.saveCourse(course, filePath);

        // ✅ Redirect to the course viewing page after successful creation
        response.sendRedirect("view_courses.jsp");
    }
}
