package tutor.servlet;

import tutor.util.TutorFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/VerifyOTPServlet")
public class VerifyOTPServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer otp = (Integer) session.getAttribute("otp");
        String email = (String) session.getAttribute("otpEmail");

        String inputOtp = request.getParameter("otp");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (otp == null || email == null) {
            request.setAttribute("error", "Session expired. Start again.");
            request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
            return;
        }

        if (!inputOtp.equals(String.valueOf(otp))) {
            request.setAttribute("error", "Invalid OTP.");
            request.getRequestDispatcher("verify_otp.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("verify_otp.jsp").forward(request, response);
            return;
        }

        boolean updated = TutorFileUtil.updatePasswordByEmail(email, newPassword);
        if (updated) {
            session.invalidate(); // Clear OTP and email
            response.sendRedirect("loginTutor.jsp?success=reset");
        } else {
            request.setAttribute("error", "Failed to reset password.");
            request.getRequestDispatcher("verify_otp.jsp").forward(request, response);
        }
    }
}
