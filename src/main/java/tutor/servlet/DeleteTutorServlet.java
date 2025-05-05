package tutor.servlet;

import tutor.util.FileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/deleteTutor")
public class DeleteTutorServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        String filePath = getServletContext().getRealPath("/WEB-INF/tutors.txt");

        FileUtil.deleteTutor(id, filePath);

        response.sendRedirect("listTutors");
    }
}
