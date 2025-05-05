package student.servlet;

import student.model.StudentFileUtil;
import student.services.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/student")  // Maps to /student URL
public class StudentServlet extends HttpServlet {

    // Handles GET requests (viewing data)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Always read fresh list from file to stay in sync
        String filePath = getServletContext().getRealPath("/WEB-INF/students.txt");
        List<Student> students = StudentFileUtil.readStudents(filePath);

        // Set students list as request attribute for JSP
        request.setAttribute("students", students);

        // Forward to JSP page for display
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    // Handles POST requests (modifying data)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");  // Get requested action
        String filePath = getServletContext().getRealPath("/WEB-INF/students.txt");

        // Read latest data from file
        List<Student> students = StudentFileUtil.readStudents(filePath);

        if ("add".equals(action)) {
            // Create new student from request parameters
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

            students.add(student);  // Add to list
        }
        else if ("delete".equals(action)) {
            String stdId = request.getParameter("stdId");  // Get ID to delete
            students.removeIf(s -> s.getStdId().equals(stdId));  // Remove student
        }
        else if ("update".equals(action)) {
            String stdId = request.getParameter("stdId");  // Get ID to update
            for (Student student : students) {
                if (student.getStdId().equals(stdId)) {
                    student.setName(request.getParameter("name"));
                    student.setUserName(request.getParameter("userName"));
                    student.setEmail(request.getParameter("email"));
                    student.setPhone(request.getParameter("phone"));
                    student.setAddress(request.getParameter("address"));
                    student.setPassword(request.getParameter("password"));
                    student.setCourse(request.getParameter("course"));
                    student.setDob(request.getParameter("dob"));
                    break;
                }
            }
        }

        // Save changes to file
        StudentFileUtil.writeStudents(students, filePath);

        // Redirect back to student page
        response.sendRedirect("student");
    }
}
