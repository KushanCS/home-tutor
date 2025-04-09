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
        String name = request.getParameter("name");
        String subject = request.getParameter("subject");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String about = request.getParameter("about");

        Tutor tutor = new Tutor(id, name, subject, email, contact, about);
        FileUtil.addTutor(tutor);

        response.sendRedirect("list_tutors.jsp");
    }
}
