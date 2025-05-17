package student.controller;

import student.services.StudentService;
import student.model.Student;
import student.utils.StudentFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/student")
// This servlet manages CRUD operations for students
public class StudentServlet extends HttpServlet {

    /**
     * Handles GET requests to list all students.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get file path for storing student data
        String filePath = getServletContext().getRealPath("/WEB-INF/students.txt");

        // Initialize student service (can include business logic if needed)
        StudentService studentService = new StudentService(filePath);

        // Load student list from file
        List<Student> students = StudentFileUtil.readStudents(filePath);

        // Set the list as request attribute to be displayed on JSP
        request.setAttribute("students", students);

        // Forward the request to index.jsp (student listing page)
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    /**
     * Handles POST requests for adding, updating, or deleting a student.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the action (add, delete, update) from request
        String action = request.getParameter("action");

        // Determine file path for student data and initialize service
        String filePath = getServletContext().getRealPath("/WEB-INF/students.txt");
        StudentService studentService = new StudentService(filePath);

        // ✅ Handle student addition
        if ("add".equals(action)) {
            Student student = new Student();
            student.setStdId(request.getParameter("stdId"));
            student.setName(request.getParameter("name"));
            student.setUserName(request.getParameter("userName"));
            student.setEmail(request.getParameter("email"));
            student.setPhone(request.getParameter("phone"));
            student.setAddress(request.getParameter("address"));
            student.setPassword(request.getParameter("password"));
            student.setCourse(request.getParameter("course"));
            student.setDob(request.getParameter("dob"));

            studentService.addStudent(student);

            // ✅ Handle student deletion
        } else if ("delete".equals(action)) {
            String stdId = request.getParameter("stdId");
            studentService.deleteStudent(stdId);

            // ✅ Handle student update
        } else if ("update".equals(action)) {
            Student updated = new Student();
            updated.setStdId(request.getParameter("stdId"));
            updated.setName(request.getParameter("name"));
            updated.setUserName(request.getParameter("userName"));
            updated.setEmail(request.getParameter("email"));
            updated.setPhone(request.getParameter("phone"));
            updated.setAddress(request.getParameter("address"));
            updated.setPassword(request.getParameter("password"));
            updated.setCourse(request.getParameter("course"));
            updated.setDob(request.getParameter("dob"));

            studentService.updateStudent(updated);
        }

        // Redirect back to the listing page to prevent duplicate form submission
        response.sendRedirect(request.getContextPath() + "/student");
    }
}
