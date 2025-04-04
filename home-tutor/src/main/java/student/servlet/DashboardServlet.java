package student.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class DashboardServlet extends HttpServlet {

    String name = "Kushan";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("username", name);
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}
