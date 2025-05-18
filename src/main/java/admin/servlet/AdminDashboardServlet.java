package admin.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import admin.services.Admin;
import student.services.StudentService;
import java.util.List;
import student.model.Student;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    private static final String STUDENT_FILE = "/WEB-INF/students.txt";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check admin authentication - matches LoginServlet's session attributes
        if (session == null || !"admin".equals(session.getAttribute("userType"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // Initialize StudentService
            String studentFilePath = getServletContext().getRealPath(STUDENT_FILE);
            StudentService studentService = new StudentService(studentFilePath);

            // Get all students
            List<Student> students = studentService.getAllStudents();

            // Set attributes for JSP - matching what LoginServlet sets
            request.setAttribute("students", students);
            request.setAttribute("studentCount", students.size());

            // Use session attributes set by LoginServlet
            request.setAttribute("fullName", session.getAttribute("fullName"));
            request.setAttribute("username", session.getAttribute("username"));

            request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Error loading dashboard: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Consistent authentication check with doGet
        if (session == null || !"admin".equals(session.getAttribute("userType"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            String studentFilePath = getServletContext().getRealPath(STUDENT_FILE);
            StudentService studentService = new StudentService(studentFilePath);

            String action = request.getParameter("action");

            if ("deleteStudent".equals(action)) {
                String studentId = request.getParameter("studentId");
                if (studentService.deleteStudent(studentId)) {
                    session.setAttribute("message", "Student deleted successfully");
                } else {
                    session.setAttribute("error", "Failed to delete student");
                }
            }
            // Redirect to doGet to refresh the student list
            response.sendRedirect(request.getContextPath() + "/AdminDashboardServlet");

        } catch (Exception e) {
            session.setAttribute("error", "Operation failed: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/AdminDashboardServlet");
        }
    }
}