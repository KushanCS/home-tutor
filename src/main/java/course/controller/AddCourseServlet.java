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
        fileSizeThreshold = 1024 * 1024,    // 1MB
        maxFileSize = 5 * 1024 * 1024,      // 5MB
        maxRequestSize = 10 * 1024 * 1024   // 10MB
)
public class AddCourseServlet extends HttpServlet {

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

        // Get form data
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String level = request.getParameter("level");
        String price = request.getParameter("price");
        String duration = request.getParameter("duration");

        // Handle image upload
        Part imagePart = request.getPart("image");
        String imageFileName = imagePart.getSubmittedFileName();
        String imageFolderPath = getServletContext().getRealPath("/images");

        File imageFolder = new File(imageFolderPath);
        if (!imageFolder.exists()) imageFolder.mkdirs();

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

        String courseId = CourseFileUtil.generateCourseId();
        String filePath = getServletContext().getRealPath("/WEB-INF/courses.txt");

        Course course = new Course(courseId, tutorId, tutorName, tutorSubject, name, description, level, imageFileName, price, duration);
        CourseFileUtil.saveCourse(course, filePath);

        response.sendRedirect("view_courses.jsp");
    }
}
