package tutor.servlet;

import tutor.model.Tutor;
import tutor.util.FileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/addTutor")
public class AddTutorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = UUID.randomUUID().toString();
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String subject = request.getParameter("subject");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String campusName = request.getParameter("campusName");
        String degreeCourse = request.getParameter("degreeCourse");
        String degreeLevel = request.getParameter("degreeLevel");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String about = request.getParameter("about");

        String filePath = getServletContext().getRealPath("/WEB-INF/tutors.txt");

        // 🔁 Check if username already exists
        if (FileUtil.getTutorByUsername(username, filePath) != null) {
            request.setAttribute("error", "Username already exists!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // ✅ Save new tutor
        Tutor tutor = new Tutor(id, username, name, subject, email, contact, campusName, degreeCourse, degreeLevel, address, password, about);
        FileUtil.addTutor(tutor, filePath);

        // 🎯 Success message and redirect to login.jsp
        response.sendRedirect("login.jsp?message=success");

    }
}
