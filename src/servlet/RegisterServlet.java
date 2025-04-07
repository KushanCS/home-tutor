package com.tutorbooking.servlets;

import com.tutorbooking.models.User;
import com.tutorbooking.utils.FileUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String subject = request.getParameter("subject");
        String about = request.getParameter("about");
        String contact = request.getParameter("contact");

        User user = new User(name, email, password, role, subject, about, contact);
        FileUtil.saveUser(user);

        response.sendRedirect("login.jsp");
    }
}
