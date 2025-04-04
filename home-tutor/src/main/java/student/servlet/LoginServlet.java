package student.servlet;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the Add Student page (JSP)
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (isValidUser(username, password)) {
            request.getSession().setAttribute("userDetails", username);
            response.sendRedirect("dashboard.jsp");
        } else {
           response.sendRedirect("login.jsp?error=Invalid credetials");
        }
    }

    private boolean isValidUser(String username, String password){
        String filePath = getServletContext().getRealPath("/WEB-INF/users.txt");
        try(BufferedReader br = new BufferedReader(new FileReader(filePath))){
            String line;
            while ((line = br.readLine()) != null){
                String[] user = line.split(",");
                if (user.length == 2 && user[0].equals(username) && user[1].equals(password)){
                    return true;
                }
            }
        } catch (IOException e){
            e.printStackTrace();
        }
        return false;
    }
}
