package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class StudentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentId = request.getParameter("studentId");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String course = request.getParameter("course");
        String dob = request.getParameter("dob");

        // Here you can add database connectivity to store student details
        request.setAttribute("message", "Student added successfully!");
        request.getRequestDispatcher("add-student.jsp").forward(request, response);

    }
}
