package course.controller;

import course.model.Course;
import course.utils.CourseFileUtil;
import tutor.model.Tutor;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/UpdateCourseServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,    // 1MB
        maxFileSize = 5 * 1024 * 1024,      // 5MB
        maxRequestSize = 10 * 1024 * 1024   // 10MB
)
// This servlet handles course update requests from tutors
public class UpdateCourseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Get logged-in tutor from session
        Tutor tutor = (Tutor) request.getSession().getAttribute("tutor");

        // Redirect to login if tutor is not logged in
        if (tutor == null) {
            response.sendRedirect("loginTutor.jsp");
            return;
        }

        // Extract tutor info to retain with the updated course
        String tutorId = tutor.getTutorId();
        String tutorName = tutor.getName();
        String tutorSubject = tutor.getSubject();

        // Get course data from the form
        String courseId = request.getParameter("courseId");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String level = request.getParameter("level");
        String price = request.getParameter("price");
        String duration = request.getParameter("duration");

        // Handle file upload (image)
        Part imagePart = request.getPart("image");
        String imageFileName = imagePart.getSubmittedFileName();
        String imageFolderPath = getServletContext().getRealPath("/images");
        String filePath = getServletContext().getRealPath("/WEB-INF/courses.txt");

        // Load current course image name if no new image is uploaded
        String currentImage = "";
        for (Course course : CourseFileUtil.getAllCourses(filePath)) {
            if (course.getCourseId().equals(courseId)) {
                currentImage = course.getImage(); // existing image
                break;
            }
        }

        // If a new image is uploaded, save it and update the image filename
        if (imageFileName != null && !imageFileName.isEmpty()) {
            File imageFolder = new File(imageFolderPath);
            if (!imageFolder.exists()) imageFolder.mkdirs(); // Create folder if not exists

            File imageFile = new File(imageFolder, imageFileName);
            try (InputStream input = imagePart.getInputStream();
                 OutputStream output = new FileOutputStream(imageFile)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = input.read(buffer)) != -1) {
                    output.write(buffer, 0, bytesRead);
                }
            }
            currentImage = imageFileName; // Update to new image
        }

        // Create updated course object with all the data
        Course updatedCourse = new Course(
                courseId,
                tutorId,
                tutorName,
                tutorSubject,
                name,
                description,
                level,
                currentImage,
                price,
                duration
        );

        // Save updated course to file
        CourseFileUtil.updateCourse(updatedCourse, filePath);

        // Redirect tutor back to the view courses page
        response.sendRedirect("view_courses.jsp");
    }
}
