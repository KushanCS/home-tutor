package payment.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ValidatePaymentOtpServlet")
public class ValidatePaymentOtpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String enteredOtp = request.getParameter("otp");

        Object otpObj = session.getAttribute("paymentOtp");

        if (otpObj == null || enteredOtp == null || !enteredOtp.equals(String.valueOf(otpObj))) {
            response.sendRedirect("verifyPaymentOtp.jsp?error=invalid");
            return;
        }

        // OTP matched – redirect to ConfirmPaymentServlet (will read from session)
        response.sendRedirect("ConfirmPaymentServlet");
    }
}
