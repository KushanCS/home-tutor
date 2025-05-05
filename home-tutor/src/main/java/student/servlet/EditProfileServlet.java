package student.servlet;

import student.model.StudentFileUtil;
import student.services.Student;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/editProfile")
public class EditProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String currentUsername = (String) session.getAttribute("username");
        String filePath = getServletContext().getRealPath("/WEB-INF/students.txt");

        // Get form data
        String newUsername = request.getParameter("username");
        String newEmail = request.getParameter("email");
        String newPassword = request.getParameter("password");

        // Read current students
        List<Student> students = StudentFileUtil.readStudents(filePath);
        Student currentStudent = null;

        // Find and update student
        for (Student student : students) {
            if (student.getUserName().equals(currentUsername)) {
                student.setUserName(newUsername);
                student.setEmail(newEmail);
                if (newPassword != null && !newPassword.isEmpty()) {
                    student.setPassword(newPassword);
                }
                currentStudent = student;
                break;
            }
        }

        if (currentStudent != null) {
            // Save updated list
            StudentFileUtil.writeStudents(students, filePath);

            // Update session
            session.setAttribute("username", newUsername);
            session.setAttribute("email", newEmail);
            session.setAttribute("student", currentStudent);

            response.sendRedirect("profile.jsp");
        } else {
            request.setAttribute("error", "Student not found");
            request.getRequestDispatcher("edit-profile.jsp").forward(request, response);
        }
    }

}
