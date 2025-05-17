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
public class StudentServlet extends HttpServlet {

    // Handle GET requests – Load and display all students
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Define the path to the student data file
        String filePath = getServletContext().getRealPath("/WEB-INF/students.txt");

        // Initialize the service class with the file path
        StudentService studentService = new StudentService(filePath);

        // Load all student records using utility class (could also be moved to service)
        List<Student> students = StudentFileUtil.readStudents(filePath);

        // Set the list as a request attribute to be displayed in the JSP
        request.setAttribute("students", students);

        // Forward request to the JSP page (index.jsp) to display the data
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    // Handle POST requests – Add, Update, or Delete student based on 'action' parameter
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the action: add, delete, or update
        String action = request.getParameter("action");

        // Define file path and initialize service
        String filePath = getServletContext().getRealPath("/WEB-INF/students.txt");
        StudentService studentService = new StudentService(filePath);

        // ==== Handle Add Student ====
        if ("add".equals(action)) {
            // Create new student object from form parameters
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

            // Add the student using service class
            studentService.addStudent(student);

            // ==== Handle Delete Student ====
        } else if ("delete".equals(action)) {
            // Get student ID from request and delete
            String stdId = request.getParameter("stdId");
            studentService.deleteStudent(stdId);

            // ==== Handle Update Student ====
        } else if ("update".equals(action)) {
            // Create updated student object
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

            // Update the student using service class
            studentService.updateStudent(updated);
        }

        // Redirect to the GET method to reload updated student list and prevent resubmission
        response.sendRedirect(request.getContextPath() + "/student");
    }
}
