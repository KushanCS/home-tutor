package course.controller;

import course.model.CourseStatus;
import course.utils.StudentCourseUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class MyCoursesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = (String) request.getSession().getAttribute("username");
        String path = getServletContext().getRealPath("/WEB-INF/studentCourses.txt");

        List<CourseStatus> allCourses = StudentCourseUtil.readStudentCourses(path);
        List<CourseStatus> myCourses = new ArrayList<>();

        for (CourseStatus cs : allCourses) {
            if (cs.getUsername().equals(username)) {
                myCourses.add(cs);
            }
        }

        request.setAttribute("courses", myCourses);
        request.getRequestDispatcher("student-course.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = (String) request.getSession().getAttribute("username");
        String path = getServletContext().getRealPath("/WEB-INF/studentCourses.txt");

        List<CourseStatus> allCourses = StudentCourseUtil.readStudentCourses(path);
        List<CourseStatus> myCourses = new ArrayList<>();

        for (CourseStatus cs : allCourses) {
            if (cs.getUsername().equals(username)) {
                myCourses.add(cs);
            }
        }

        request.setAttribute("courses", myCourses);
        request.getRequestDispatcher("student-course.jsp").forward(request, response);
    }

}
