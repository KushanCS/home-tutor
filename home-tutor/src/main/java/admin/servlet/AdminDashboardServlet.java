package admin.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import admin.services.Admin;
import admin.model.Adminfileutil;
import student.model.StudentFileUtil;
import java.util.List;
import student.services.Student;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check admin authentication
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // Get all students for admin to manage
            String studentFilePath = getServletContext().getRealPath("/WEB-INF/student.txt");
            List<Student> students = StudentFileUtil.getAllStudents(studentFilePath);

            // Get admin details
            String adminFilePath = getServletContext().getRealPath("/WEB-INF/admin.txt");
            Admin admin = (Admin) session.getAttribute("admin");

            // Set attributes for JSP
            request.setAttribute("students", students);
            request.setAttribute("admin", admin);
            request.setAttribute("studentCount", students.size());

            request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);

        } catch (IOException e) {
            request.setAttribute("error", "Error loading dashboard: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            String studentFilePath = getServletContext().getRealPath("/WEB-INF/student.txt");

            if ("deleteStudent".equals(action)) {
                String studentId = request.getParameter("studentId");
                StudentFileUtil.deleteStudent(studentId, studentFilePath);
                request.setAttribute("message", "Student deleted successfully");

            } else if ("updateStudent".equals(action)) {
                // Handle student updates
                // Implementation depends on your requirements
            }

            // Refresh student list
            List<Student> students = StudentFileUtil.getAllStudents(studentFilePath);
            request.setAttribute("students", students);
            request.setAttribute("studentCount", students.size());

            request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);

        } catch (IOException e) {
            request.setAttribute("error", "Operation failed: " + e.getMessage());
            request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);
        }
    }
}