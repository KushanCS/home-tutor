package student.controller;

import student.services.StudentService;
import student.model.Student;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/editProfile")
public class EditProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String currentUsername = (String) session.getAttribute("username");
        String filePath = getServletContext().getRealPath("/WEB-INF/students.txt");

        String newUsername = request.getParameter("username");
        String newEmail = request.getParameter("email");
        String newPassword = request.getParameter("password");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String course = request.getParameter("course");
        String dob = request.getParameter("dob");

        StudentService studentService = new StudentService(filePath);
        Student student = studentService.getStudentByUsername(currentUsername);

        if (student != null) {
            student.setUserName(newUsername);
            student.setEmail(newEmail);
            student.setName(name);
            student.setPhone(phone);
            student.setAddress(address);
            student.setCourse(course);
            student.setDob(dob);
            if (newPassword != null && !newPassword.isEmpty()) {
                student.setPassword(newPassword);
            }

            boolean success = studentService.updateStudent(student);

            if (success) {
                session.setAttribute("student", student);
                response.sendRedirect("profile.jsp");
            } else {
                request.setAttribute("error", "Profile update failed");
                request.getRequestDispatcher("editProfile.jsp").forward(request, response);
            }
        }
    }
}
