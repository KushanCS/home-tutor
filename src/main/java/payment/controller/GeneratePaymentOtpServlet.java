package payment.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.Random;

@WebServlet("/GeneratePaymentOtpServlet")
public class GeneratePaymentOtpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String courseId = request.getParameter("courseId");
        String method = request.getParameter("method");

        // Extract dummy card data (optional - you can store if needed later)
        String cardNumber = request.getParameter("cardNumber");
        String cardName = request.getParameter("cardName");
        String expiry = request.getParameter("expiry");
        String cvv = request.getParameter("cvv");

        // Read phone number from student.txt
        String studentPath = getServletContext().getRealPath("/WEB-INF/student.txt");
        String phoneNumber = "";

        try (BufferedReader reader = new BufferedReader(new FileReader(studentPath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length >= 5 && parts[0].equals(username)) {
                    phoneNumber = parts[4];  // adjust index based on actual student.txt structure
                    break;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Generate 4-digit OTP
        int otp = new Random().nextInt(9000) + 1000;

        // Store values in session
        session.setAttribute("paymentOtp", otp);
        session.setAttribute("paymentCourseId", courseId);
        session.setAttribute("paymentMethod", method);

        // Optional: store card details if you want to display them
        session.setAttribute("maskedCard", "**** **** **** " + cardNumber.substring(cardNumber.length() - 4));

        // Simulate sending OTP by printing to console
        System.out.println("[OTP for payment - " + username + "]: " + otp + " sent to phone " + phoneNumber);

        // Redirect to OTP verification page
        response.sendRedirect("verifyPaymentOtp.jsp");
    }
}
