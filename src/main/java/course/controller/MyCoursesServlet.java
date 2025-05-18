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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Get the currently logged-in student's username from session
        String username = (String) request.getSession().getAttribute("username");

        // ✅ If user is not logged in, redirect to login page
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // ✅ Define file paths for enrollment and course data
        String enrollPath = getServletContext().getRealPath("/WEB-INF/studentCourses.txt");
        String coursePath = getServletContext().getRealPath("/WEB-INF/courses.txt");

        // ✅ Load all enrollments and courses from files
        List<Enrollment> allEnrollments = EnrollmentFileUtil.readEnrollments(enrollPath);
        List<Course> allCourses = CourseFileUtil.getAllCourses(coursePath);

        // ✅ This list will store the current student's enrolled course statuses
        List<CourseStatus> myCourses = new ArrayList<>();

        // ✅ Loop through enrollments and match with courses
        for (Enrollment e : allEnrollments) {
            if (e.getStudentUsername().equals(username)) {
                for (Course c : allCourses) {
                    if (c.getCourseId().equals(e.getCourseId())) {
                        // ✅ Create CourseStatus combining course info and enrollment status
                        myCourses.add(new CourseStatus(
                                e.getStudentUsername(),  // Student username
                                c.getCourseId(),         // Course ID
                                c.getName(),             // Course name
                                c.getTutorSubject(),     // Tutor subject
                                c.getPrice(),            // Course price
                                c.getDuration(),         // Duration
                                e.getPaidStatus()        // Paid status ("Yes"/"No")
                        ));
                        break;
                    }
                }
            }
        }

        // ✅ Set course list as request attribute and forward to JSP for display
        request.setAttribute("courses", myCourses);
        request.getRequestDispatcher("student-course.jsp").forward(request, response);
    }
}
