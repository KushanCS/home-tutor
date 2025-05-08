package tutor.servlet;

import tutor.model.Tutor;
import tutor.util.TutorFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/RegisterTutorServlet")
public class RegisterTutorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Retrieve form data
        String username = request.getParameter("username");
        String fullName = request.getParameter("fullName");
        String course = request.getParameter("course");
        String email = request.getParameter("email");
        String contactNumber = request.getParameter("contactNumber");
        String campusName = request.getParameter("campusName");
        String degreeCourse = request.getParameter("degreeCourse");
        String degreeLevel = request.getParameter("degreeLevel");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String about = request.getParameter("about");

        // Simple password check
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("add_tutor.jsp").forward(request, response);
            return;
        }

        // Save tutor to file
        Tutor tutor = new Tutor(username, fullName, course, email, contactNumber,
                campusName, degreeCourse, degreeLevel, address, password, about);

        String filePath = getServletContext().getRealPath("/WEB-INF/tutors.txt");
        TutorFileUtil.saveTutor(tutor, filePath);

        response.sendRedirect("login.jsp?registered=true");
    }
}
