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
// This servlet displays all courses that the currently logged-in student has enrolled in
public class MyCoursesServlet extends HttpServlet {

    // Handles GET requests to display the student's enrolled courses
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the currently logged-in student's username from session
        String username = (String) request.getSession().getAttribute("username");

        // If the user is not logged in, redirect to the login page
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Resolve file paths for enrollments and course data
        String enrollPath = getServletContext().getRealPath("/WEB-INF/studentCourses.txt");
        String coursePath = getServletContext().getRealPath("/WEB-INF/courses.txt");

        // Read all enrollments and courses from their respective files
        List<Enrollment> allEnrollments = EnrollmentFileUtil.readEnrollments(enrollPath);
        List<Course> allCourses = CourseFileUtil.getAllCourses(coursePath);

        // List to store the logged-in student's enrolled courses with extra info
        List<CourseStatus> myCourses = new ArrayList<>();

        // Loop through enrollments to find courses enrolled by this student
        for (Enrollment e : allEnrollments) {
            if (e.getStudentUsername().equals(username)) {
                for (Course c : allCourses) {
                    if (c.getCourseId().equals(e.getCourseId())) {

                        // Create a CourseStatus object to send to the JSP
                        myCourses.add(new CourseStatus(
                                e.getStudentUsername(),  // student username
                                c.getCourseId(),         // course ID
                                c.getName(),             // course name
                                c.getTutorSubject(),     // tutor subject
                                c.getPrice(),            // course price
                                c.getDuration(),         // course duration
                                e.getPaidStatus()        // enrollment payment status (Yes/No)
                        ));
                        break; // Exit inner loop once matched course is found
                    }
                }
            }
        }

        // Set the list of enrolled courses as a request attribute
        request.setAttribute("courses", myCourses);

        // Forward the request to student-course.jsp to display the results
        request.getRequestDispatcher("student-course.jsp").forward(request, response);
    }
}
