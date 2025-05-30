package tutor.servlet;

import tutor.model.Tutor;
import tutor.util.TutorFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Random;

/**
 * Servlet to handle tutor "Forgot Password" requests.
 * It verifies the tutor's email, generates a one-time OTP,
 * stores it in session, and redirects to the OTP verification page.
 */
@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        // Step 1: Retrieve the submitted email address
        String email = request.getParameter("email");

        // Step 2: Look up tutor by email (searches BST via file utility)
        Tutor tutor = TutorFileUtil.searchTutorByEmail(email);

        if (tutor != null) {
            // Step 3: Generate a 6-digit OTP
            int otp = new Random().nextInt(900000) + 100000;

            // Step 4: Print OTP to server console (for dev/testing only)
            System.out.println("Generated OTP for " + email + ": " + otp);

            // Step 5: Store OTP and associated email in session
            HttpSession session = request.getSession();
            session.setAttribute("otp", otp);
            session.setAttribute("otpEmail", email);

            // Step 6: Redirect user to OTP verification page
            response.sendRedirect("verify_otp.jsp");
        } else {
            // If tutor with the provided email is not found, redirect back with status flag
            response.sendRedirect("forgot_password.jsp?status=notfound");
        }
    }
}
