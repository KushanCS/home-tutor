package admin.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import admin.services.Admin;
import admin.model.Adminfileutil;
import student.model.StudentFileUtil;
import student.services.Student;
import java.util.List;

@WebServlet(name = "AdminServlet", urlPatterns = {"/AdminServlet"})
public class AdminServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Authentication check
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        String filePath = getServletContext().getRealPath("/WEB-INF/admin.txt");
        String studentFilePath = getServletContext().getRealPath("/WEB-INF/student.txt");

        try {
            switch (action != null ? action : "") {
                case "viewDashboard":
                    viewDashboard(request, response, studentFilePath);
                    break;
                case "addStudent":
                    addStudent(request, response, studentFilePath);
                    break;
                case "editStudent":
                    editStudent(request, response, studentFilePath);
                    break;
                case "updateStudent":
                    updateStudent(request, response, studentFilePath);
                    break;
                case "deleteStudent":
                    deleteStudent(request, response, studentFilePath);
                    break;
                case "searchStudents":
                    searchStudents(request, response, studentFilePath);
                    break;
                case "updateAdminProfile":
                    updateAdminProfile(request, response, filePath);
                    break;
                case "changePassword":
                    changePassword(request, response, filePath);
                    break;
                default:
                    viewDashboard(request, response, studentFilePath);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Operation failed: " + e.getMessage());
            request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);
        }
    }

    private void viewDashboard(HttpServletRequest request, HttpServletResponse response, String studentFilePath)
            throws ServletException, IOException {

        List<Student> students = StudentFileUtil.getAllStudents(studentFilePath);
        request.setAttribute("students", students);
        request.setAttribute("studentCount", students.size());
        request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);
    }

    private void addStudent(HttpServletRequest request, HttpServletResponse response, String studentFilePath)
            throws ServletException, IOException {

        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/addStudent.jsp").forward(request, response);
            return;
        }

        Student student = new Student(
                generateStudentId(),
                request.getParameter("name"),
                request.getParameter("username"),
                request.getParameter("email"),
                request.getParameter("phone"),
                request.getParameter("address"),
                hashPassword(password),
                request.getParameter("course"),
                request.getParameter("dob")
        );

        StudentFileUtil.saveStudent(student, studentFilePath);
        request.setAttribute("message", "Student added successfully");
        response.sendRedirect(request.getContextPath() + "/AdminServlet?action=viewDashboard");
    }

    private void editStudent(HttpServletRequest request, HttpServletResponse response, String studentFilePath)
            throws ServletException, IOException {

        String studentId = request.getParameter("id");
        Student student = StudentFileUtil.getStudentById(studentId, studentFilePath);

        if (student == null) {
            request.setAttribute("error", "Student not found");
            response.sendRedirect(request.getContextPath() + "/AdminServlet?action=viewDashboard");
            return;
        }

        request.setAttribute("student", student);
        request.getRequestDispatcher("/editStudent.jsp").forward(request, response);
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response, String studentFilePath)
            throws ServletException, IOException {

        String studentId = request.getParameter("studentId");
        Student existingStudent = StudentFileUtil.getStudentById(studentId, studentFilePath);

        if (existingStudent == null) {
            request.setAttribute("error", "Student not found");
            response.sendRedirect(request.getContextPath() + "/AdminServlet?action=viewDashboard");
            return;
        }

        // Update student details
        existingStudent.setName(request.getParameter("name"));
        existingStudent.setUserName(request.getParameter("username"));
        existingStudent.setEmail(request.getParameter("email"));
        existingStudent.setPhone(request.getParameter("phone"));
        existingStudent.setAddress(request.getParameter("address"));
        existingStudent.setCourse(request.getParameter("course"));
        existingStudent.setDob(request.getParameter("dob"));

        // Handle password change if provided
        String newPassword = request.getParameter("newPassword");
        if (newPassword != null && !newPassword.isEmpty()) {
            existingStudent.setPassword(hashPassword(newPassword));
        }

        StudentFileUtil.updateStudent(existingStudent, studentFilePath);
        request.setAttribute("message", "Student updated successfully");
        response.sendRedirect(request.getContextPath() + "/AdminServlet?action=viewDashboard");
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response, String studentFilePath)
            throws ServletException, IOException {

        String studentId = request.getParameter("id");
        StudentFileUtil.deleteStudent(studentId, studentFilePath);
        request.setAttribute("message", "Student deleted successfully");
        response.sendRedirect(request.getContextPath() + "/AdminServlet?action=viewDashboard");
    }

    private void searchStudents(HttpServletRequest request, HttpServletResponse response, String studentFilePath)
            throws ServletException, IOException {

        String searchTerm = request.getParameter("searchTerm");
        List<Student> students = StudentFileUtil.searchStudents(searchTerm, studentFilePath);

        request.setAttribute("students", students);
        request.setAttribute("searchTerm", searchTerm);
        request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);
    }

    private void updateAdminProfile(HttpServletRequest request, HttpServletResponse response, String filePath)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");

        admin.setName(request.getParameter("name"));
        admin.setEmail(request.getParameter("email"));
        admin.setPhone(request.getParameter("phone"));
        admin.setAddress(request.getParameter("address"));

        Adminfileutil.updateAdmin(admin, filePath);
        session.setAttribute("admin", admin);

        request.setAttribute("message", "Profile updated successfully");
        request.getRequestDispatcher("/adminProfile.jsp").forward(request, response);
    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response, String filePath)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!admin.getPassword().equals(hashPassword(currentPassword))) {
            request.setAttribute("error", "Current password is incorrect");
            request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "New passwords do not match");
            request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
            return;
        }

        admin.setPassword(hashPassword(newPassword));
        Adminfileutil.updateAdmin(admin, filePath);
        session.setAttribute("admin", admin);

        request.setAttribute("message", "Password changed successfully");
        request.getRequestDispatcher("/adminProfile.jsp").forward(request, response);
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
            throw new RuntimeException(e);
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