package tutor.servlet;

import tutor.model.Tutor;
import tutor.util.TutorFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Random;

/**
 * This servlet handles the "Forgot Password" feature for tutors.
 * It checks if the email exists, generates a 6-digit OTP, and redirects to the OTP verification page.
 */
@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

    /**
     * Handles POST requests to initiate OTP generation for password reset.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        // Step 1: Retrieve the email submitted from the form
        String email = request.getParameter("email");

        // Step 2: Search for the tutor by email using a BST-backed utility method
        Tutor tutor = TutorFileUtil.searchTutorByEmail(email);

        if (tutor != null) {
            // Step 3: Generate a random 6-digit OTP
            int otp = new Random().nextInt(900000) + 100000;

            // Step 4: Log the OTP to console for development/testing purposes
            System.out.println("Generated OTP for " + email + ": " + otp);

            // Step 5: Store OTP and email in session for use during verification
            HttpSession session = request.getSession();
            session.setAttribute("otp", otp);
            session.setAttribute("otpEmail", email);

            // Step 6: Redirect to OTP verification page
            response.sendRedirect("verify_otp.jsp");
        } else {
            // If no tutor is found, redirect back with an error message
            response.sendRedirect("forgot_password.jsp?status=notfound");
        }
    }
}
