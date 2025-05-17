package tutor.servlet;

import tutor.model.Tutor;
import tutor.util.TutorFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Random;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String email = request.getParameter("email");

        Tutor tutor = TutorFileUtil.searchTutorByEmail(email); // BST-based lookup
        if (tutor != null) {
            int otp = new Random().nextInt(900000) + 100000;
            System.out.println("Generated OTP for " + email + ": " + otp); // Console print for dev use

            HttpSession session = request.getSession();
            session.setAttribute("otp", otp);
            session.setAttribute("otpEmail", email);

            response.sendRedirect("verify_otp.jsp");
        } else {
            response.sendRedirect("forgot_password.jsp?status=notfound");
        }
    }
}
