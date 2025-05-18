package admin.servlet;

import student.services.StudentService;
import student.model.Student;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminServlet", urlPatterns = {"/AdminServlet"})
public class AdminServlet extends HttpServlet {
    private static final String STUDENT_FILE = "/WEB-INF/students.txt";
    private StudentService studentService;

    @Override
    public void init() throws ServletException {
        String filePath = getServletContext().getRealPath(STUDENT_FILE);
        this.studentService = new StudentService(filePath);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdminAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=unauthorized");
            return;
        }

        String action = request.getParameter("action");
        try {
            switch (action != null ? action : "viewStudents") {
                case "viewStudents": viewStudents(request, response); break;
                case "addStudent": addStudent(request, response); break;
                case "editStudentForm": showEditForm(request, response); break;
                case "updateStudent": updateStudent(request, response); break;
                case "deleteStudent": {
                    String studentId = request.getParameter("id");
                    if (studentService.deleteStudent(studentId)) {
                        request.setAttribute("students", studentService.getAllStudents());
                        request.setAttribute("message", "Student deleted successfully.");
                    } else {
                        request.setAttribute("error", "Student not found or could not be deleted");
                    }
                    request.getRequestDispatcher("StudentManagement.jsp").forward(request, response);
                    break;
                }
                case "searchStudents": searchStudents(request, response); break;
                default: viewStudents(request, response);
            }
        } catch (Exception e) {
            handleError(request, response, "Operation failed: " + e.getMessage(), "/error.jsp");
        }
    }

    private boolean isAdminAuthenticated(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && "admin".equals(session.getAttribute("userType"));
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response,
                             String message, String destination)
            throws ServletException, IOException {
        request.setAttribute("error", message);
        request.getRequestDispatcher(destination).forward(request, response);
    }

    private void viewStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Student> students = studentService.getAllStudents();
        request.setAttribute("students", students);
        request.setAttribute("studentCount", students.size());
        request.getRequestDispatcher("/StudentManagement.jsp").forward(request, response);
    }

    private void addStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");

            if (!password.equals(confirmPassword)) {
                throw new ServletException("Passwords do not match");
            }

            Student student = createStudentFromRequest(request);
            if (!studentService.addStudent(student)) {
                throw new ServletException("Failed to add student");
            }

            request.getSession().setAttribute("message", "Student added successfully");
            response.sendRedirect("AdminServlet?action=viewStudents");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/addStudent.jsp").forward(request, response);
        }
    }

    private Student createStudentFromRequest(HttpServletRequest request) {
        Student student = new Student();
        student.setStdId(generateStudentId());
        student.setName(request.getParameter("name"));
        student.setUserName(request.getParameter("username"));
        student.setEmail(request.getParameter("email"));
        student.setPhone(request.getParameter("phone"));
        student.setAddress(request.getParameter("address"));
        student.setPassword(hashPassword(request.getParameter("password")));
        student.setCourse(request.getParameter("course"));
        student.setDob(request.getParameter("dob"));
        return student;
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String studentId = request.getParameter("id");
        Student student = studentService.getStudentById(studentId);

        if (student == null) {
            throw new ServletException("Student not found");
        }

        request.setAttribute("student", student);
        request.getRequestDispatcher("/editStudent.jsp").forward(request, response);
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String studentId = request.getParameter("studentId");
            Student student = studentService.getStudentById(studentId);

            if (student == null) {
                throw new ServletException("Student not found");
            }

            updateStudentFromRequest(request, student);
            if (!studentService.updateStudent(student)) {
                throw new ServletException("Failed to update student");
            }

            request.getSession().setAttribute("message", "Student updated successfully");
            response.sendRedirect("AdminServlet?action=viewStudents");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/editStudent.jsp").forward(request, response);
        }
    }

    private void updateStudentFromRequest(HttpServletRequest request, Student student) {
        student.setName(request.getParameter("name"));
        student.setUserName(request.getParameter("username"));
        student.setEmail(request.getParameter("email"));
        student.setPhone(request.getParameter("phone"));
        student.setAddress(request.getParameter("address"));
        student.setCourse(request.getParameter("course"));
        student.setDob(request.getParameter("dob"));

        String newPassword = request.getParameter("newPassword");
        if (newPassword != null && !newPassword.isEmpty()) {
            student.setPassword(hashPassword(newPassword));
        }
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String studentId = request.getParameter("id");
        try {
            if (!studentService.deleteStudent(studentId)) {
                throw new ServletException("Student not found or could not be deleted");
            }
            request.getSession().setAttribute("message", "Student deleted successfully");
        } catch (Exception e) {
            request.getSession().setAttribute("error", e.getMessage());
        }
        response.sendRedirect("AdminServlet?action=viewStudents");
    }

    private void searchStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");
        List<Student> students = studentService.searchStudents(searchTerm);

        request.setAttribute("students", students);
        request.setAttribute("searchTerm", searchTerm);
        request.getRequestDispatcher("/StudentManagement.jsp").forward(request, response);
    }

    private String generateStudentId() {
        return "STU" + System.currentTimeMillis();
    }

    private String hashPassword(String password) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes("UTF-8"));
            StringBuilder hexString = new StringBuilder();

            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }

            return hexString.toString();
        } catch (Exception e) {
            throw new RuntimeException("Password hashing failed", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}