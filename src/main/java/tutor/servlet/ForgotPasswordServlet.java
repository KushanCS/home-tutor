package tutor.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Random;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
    // Store OTP in session for temporary use (not persistent!)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");

        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("error", "Username is required.");
            request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
            return;
        }

        // Generate a 6-digit OTP
        String otp = String.format("%06d", new Random().nextInt(999999));

        // Simulate "sending" via printing to console (Tomcat)
        System.out.println("[MetaTutor] OTP for " + username + " is: " + otp);

        // Save to session for validation
        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);
        session.setAttribute("otpUser", username);

        // Forward to OTP verification page
        request.setAttribute("username", username);
        request.getRequestDispatcher("verify_otp.jsp").forward(request, response);
    }
}
