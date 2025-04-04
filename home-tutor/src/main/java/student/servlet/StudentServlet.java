package student.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

public class StudentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Collect from data
        String studentId = request.getParameter("studentId");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String course = request.getParameter("course");
        String address = request.getParameter("address");
        String dob = request.getParameter("dob");
        String contact = request.getParameter("contact");

        //data store path
        String filePath = getServletContext().getRealPath("/student.txt");

        //store data in text
        try(PrintWriter writer = new PrintWriter(new FileWriter(filePath,true))){
            writer.println(studentId + "," + fullName + "," + email + "," + course + ","
                    + contact + "," + dob + "," + address);
        }
    }
}
