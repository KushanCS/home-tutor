package tutor.servlet;

import tutor.model.Tutor;
import tutor.util.FileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/updateTutor")
public class UpdateTutorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
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

        Tutor updatedTutor = new Tutor(id, username, name, subject, email, contact,
                campusName, degreeCourse, degreeLevel, address, password, about);

        FileUtil.updateTutor(updatedTutor, filePath);

        response.sendRedirect("listTutors");
    }

}
