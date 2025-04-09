package tutor.servlet;

import tutor.model.Tutor;
import tutor.util.FileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/listTutors")
public class ListTutorsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Tutor> tutors = FileUtil.readTutors();
        request.setAttribute("tutors", tutors);
        request.getRequestDispatcher("list_tutors.jsp").forward(request, response);
    }
}
