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
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class UpdateCourseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Get tutor from session
        Tutor tutor = (Tutor) request.getSession().getAttribute("tutor");
        if (tutor == null) {
            response.sendRedirect("loginTutor.jsp");
            return;
        }

        String tutorId = tutor.getTutorId();
        String tutorName = tutor.getName();
        String tutorSubject = tutor.getSubject();

        // Get other form data
        String courseId = request.getParameter("courseId");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String level = request.getParameter("level");
        String price = request.getParameter("price");
        String duration = request.getParameter("duration");

        Part imagePart = request.getPart("image");
        String imageFileName = imagePart.getSubmittedFileName();
        String imageFolderPath = getServletContext().getRealPath("/images");
        String filePath = getServletContext().getRealPath("/WEB-INF/courses.txt");

        // Load current image if no new one uploaded
        String currentImage = "";
        for (Course course : CourseFileUtil.getAllCourses(filePath)) {
            if (course.getCourseId().equals(courseId)) {
                currentImage = course.getImage();
                break;
            }
        }

        if (imageFileName != null && !imageFileName.isEmpty()) {
            File imageFolder = new File(imageFolderPath);
            if (!imageFolder.exists()) imageFolder.mkdirs();

            File imageFile = new File(imageFolder, imageFileName);
            try (InputStream input = imagePart.getInputStream();
                 OutputStream output = new FileOutputStream(imageFile)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = input.read(buffer)) != -1) {
                    output.write(buffer, 0, bytesRead);
                }
            }
            currentImage = imageFileName;
        }

        Course updatedCourse = new Course(courseId, tutorId, tutorName, tutorSubject, name, description, level, currentImage, price, duration);
        CourseFileUtil.updateCourse(updatedCourse, filePath);

        response.sendRedirect("view_courses.jsp");
    }
}
