package tutor.servlet;

import tutor.model.Tutor;
import tutor.util.TutorFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebServlet("/VerifyOTPServlet")
public class VerifyOTPServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String enteredOtp = request.getParameter("otp");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        HttpSession session = request.getSession();
        String storedOtp = (String) session.getAttribute("otp");
        String email = (String) session.getAttribute("email");

        if (storedOtp == null || email == null || !storedOtp.equals(enteredOtp)) {
            request.setAttribute("error", "Invalid OTP or session expired.");
            request.getRequestDispatcher("verify_otp.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("verify_otp.jsp").forward(request, response);
            return;
        }

        boolean updated = TutorFileUtil.updateTutorPasswordByEmail(email, hashPassword(newPassword));

        if (updated) {
            session.removeAttribute("otp");
            session.removeAttribute("email");
            response.sendRedirect("loginTutor.jsp?success=reset");
        } else {
            request.setAttribute("error", "Failed to update password.");
            request.getRequestDispatcher("verify_otp.jsp").forward(request, response);
        }
    }

    private String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = digest.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hashBytes) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
}
