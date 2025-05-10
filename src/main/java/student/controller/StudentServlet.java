package student.controller;

import student.services.StudentService;
import student.model.Course;
import student.utils.StudentFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/student")
public class StudentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Determine file path and initialize service
        String filePath = getServletContext().getRealPath("/WEB-INF/students.txt");
        StudentService studentService = new StudentService(filePath);

        // Read all students
        List<Course> students = StudentFileUtil.readStudents(filePath);
        request.setAttribute("students", students);

        // Forward to JSP for display
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String filePath = getServletContext().getRealPath("/WEB-INF/students.txt");
        StudentService studentService = new StudentService(filePath);

        if ("add".equals(action)) {
            // Build new student object
            Course student = new Course();
            student.setStdId(request.getParameter("stdId"));
            student.setName(request.getParameter("name"));
            student.setUserName(request.getParameter("userName"));
            student.setEmail(request.getParameter("email"));
            student.setPhone(request.getParameter("phone"));
            student.setAddress(request.getParameter("address"));
            student.setPassword(request.getParameter("password"));
            student.setCourse(request.getParameter("course"));
            student.setDob(request.getParameter("dob"));

            // Delegate to service
            studentService.addStudent(student);

        } else if ("delete".equals(action)) {
            String stdId = request.getParameter("stdId");
            studentService.deleteStudent(stdId);

        } else if ("update".equals(action)) {
            // Build updated student object
            Course updated = new Course();
            updated.setStdId(request.getParameter("stdId"));
            updated.setName(request.getParameter("name"));
            updated.setUserName(request.getParameter("userName"));
            updated.setEmail(request.getParameter("email"));
            updated.setPhone(request.getParameter("phone"));
            updated.setAddress(request.getParameter("address"));
            updated.setPassword(request.getParameter("password"));
            updated.setCourse(request.getParameter("course"));
            updated.setDob(request.getParameter("dob"));

            // Delegate to service
            studentService.updateStudent(updated);
        }

        // Redirect back to avoid form resubmission
        response.sendRedirect(request.getContextPath() + "/student");
    }
}
