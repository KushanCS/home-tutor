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
        fileSizeThreshold = 1024 * 1024,   // Temp storage threshold: 1MB
        maxFileSize = 5 * 1024 * 1024,     // Max upload size: 5MB
        maxRequestSize = 10 * 1024 * 1024  // Max form request size: 10MB
)
public class UpdateCourseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Get the logged-in tutor from the session
        Tutor tutor = (Tutor) request.getSession().getAttribute("tutor");

        // ✅ Redirect to login page if tutor session is missing
        if (tutor == null) {
            response.sendRedirect("loginTutor.jsp");
            return;
        }

        // ✅ Extract tutor details
        String tutorId = tutor.getTutorId();
        String tutorName = tutor.getName();
        String tutorSubject = tutor.getSubject();

        // ✅ Get form data from the update course form
        String courseId = request.getParameter("courseId");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String level = request.getParameter("level");
        String price = request.getParameter("price");
        String duration = request.getParameter("duration");

        // ✅ Handle the uploaded image (if any)
        Part imagePart = request.getPart("image");
        String imageFileName = imagePart.getSubmittedFileName();
        String imageFolderPath = getServletContext().getRealPath("/images");
        String filePath = getServletContext().getRealPath("/WEB-INF/courses.txt");

        // ✅ Default to current image if no new image is uploaded
        String currentImage = "";
        for (Course course : CourseFileUtil.getAllCourses(filePath)) {
            if (course.getCourseId().equals(courseId)) {
                currentImage = course.getImage();
                break;
            }
        }

        // ✅ If a new image is uploaded, save it to the server
        if (imageFileName != null && !imageFileName.isEmpty()) {
            File imageFolder = new File(imageFolderPath);
            if (!imageFolder.exists()) imageFolder.mkdirs(); // Create image directory if it doesn't exist

            File imageFile = new File(imageFolder, imageFileName);
            try (InputStream input = imagePart.getInputStream();
                 OutputStream output = new FileOutputStream(imageFile)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = input.read(buffer)) != -1) {
                    output.write(buffer, 0, bytesRead);
                }
            }

            // ✅ Update the image filename
            currentImage = imageFileName;
        }

        // ✅ Create updated course object with new or retained data
        Course updatedCourse = new Course(
                courseId, tutorId, tutorName, tutorSubject,
                name, description, level, currentImage, price, duration
        );

        // ✅ Save the updated course to file
        CourseFileUtil.updateCourse(updatedCourse, filePath);

        // ✅ Redirect to the course list page after successful update
        response.sendRedirect("view_courses.jsp");
    }
}
