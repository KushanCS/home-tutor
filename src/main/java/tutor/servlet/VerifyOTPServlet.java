package tutor.servlet;

import tutor.util.TutorFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * This servlet handles OTP verification and password reset for tutors.
 * It validates the OTP, checks password match, and updates the password in the file.
 */
@WebServlet("/VerifyOTPServlet")
public class VerifyOTPServlet extends HttpServlet {

    /**
     * Processes the OTP verification and password update logic.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Step 1: Get OTP and email from session
        HttpSession session = request.getSession();
        Integer otp = (Integer) session.getAttribute("otp");
        String email = (String) session.getAttribute("otpEmail");

        // Step 2: Get input from form
        String inputOtp = request.getParameter("otp");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Step 3: Check if OTP or session has expired
        if (otp == null || email == null) {
            request.setAttribute("error", "Session expired. Start again.");
            request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
            return;
        }

        // Step 4: Validate the OTP
        if (!inputOtp.equals(String.valueOf(otp))) {
            request.setAttribute("error", "Invalid OTP.");
            request.getRequestDispatcher("verify_otp.jsp").forward(request, response);
            return;
        }

        // Step 5: Check if passwords match
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("verify_otp.jsp").forward(request, response);
            return;
        }

        // Step 6: Update password using file utility
        boolean updated = TutorFileUtil.updatePasswordByEmail(email, newPassword);

        if (updated) {
            // Step 7: Invalidate session and redirect to login
            session.invalidate();
            response.sendRedirect("loginTutor.jsp?success=reset");
        } else {
            // If update failed
            request.setAttribute("error", "Failed to reset password.");
            request.getRequestDispatcher("verify_otp.jsp").forward(request, response);
        }
    }
}
