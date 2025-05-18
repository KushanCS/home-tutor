package payment.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ValidatePaymentOtpServlet")
public class ValidatePaymentOtpServlet extends HttpServlet {

    // Handles the POST request from the OTP verification form
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the current session and retrieve the OTP entered by the user
        HttpSession session = request.getSession();
        String enteredOtp = request.getParameter("otp");  // OTP entered in the form

        // Retrieve the original OTP that was stored in the session during generation
        Object otpObj = session.getAttribute("paymentOtp");

        // Check if OTP exists and matches the one entered
        if (otpObj == null || enteredOtp == null || !enteredOtp.equals(String.valueOf(otpObj))) {
            // If invalid or not matching, redirect back to the OTP page with error message
            response.sendRedirect("verifyPaymentOtp.jsp?error=invalid");
            return;
        }

        // OTP matched successfully
        // Redirect to ConfirmPaymentServlet to complete payment and update records
        response.sendRedirect("ConfirmPaymentServlet");
    }
}
