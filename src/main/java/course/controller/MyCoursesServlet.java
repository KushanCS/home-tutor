package course.controller;

import course.model.Course;
import course.model.CourseStatus;
import course.model.Enrollment;
import course.utils.CourseFileUtil;
import course.utils.EnrollmentFileUtil;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/MyCoursesServlet")
public class MyCoursesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = (String) request.getSession().getAttribute("username");
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String enrollPath = getServletContext().getRealPath("/WEB-INF/studentCourses.txt");
        String coursePath = getServletContext().getRealPath("/WEB-INF/courses.txt");

        List<Enrollment> allEnrollments = EnrollmentFileUtil.readEnrollments(enrollPath);
        List<Course> allCourses = CourseFileUtil.getAllCourses(coursePath);
        List<CourseStatus> myCourses = new ArrayList<>();

        for (Enrollment e : allEnrollments) {
            if (e.getStudentUsername().equals(username)) {
                for (Course c : allCourses) {
                    if (c.getCourseId().equals(e.getCourseId())) {
                        // Create a CourseStatus using all fields.
                        // Here, "N/A" is used as a placeholder for tutor subject.
                        myCourses.add(new CourseStatus(
                                e.getStudentUsername(),
                                c.getCourseId(),
                                c.getName(),
                                c.getTutorSubject(),
                                c.getPrice(),
                                c.getDuration(),
                                e.getPaidStatus()  // typically "No"
                        ));
                        break;
                    }
                }
            }
        }

        request.setAttribute("courses", myCourses);
        request.getRequestDispatcher("student-course.jsp").forward(request, response);
    }
}
