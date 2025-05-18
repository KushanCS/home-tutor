package payment.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.Random;

@WebServlet("/GeneratePaymentOtpServlet")
public class GeneratePaymentOtpServlet extends HttpServlet {

    // Handles POST requests from the payment form
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get current session and logged-in user's username
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        // Get course ID and selected payment method from the request
        String courseId = request.getParameter("courseId");
        String method = request.getParameter("method");

        // Get entered card details (dummy usage; not stored permanently)
        String cardNumber = request.getParameter("cardNumber");
        String cardName = request.getParameter("cardName");
        String expiry = request.getParameter("expiry");
        String cvv = request.getParameter("cvv");

        // Read the student's phone number from student.txt
        // (needed to simulate where OTP would be sent)
        String studentPath = getServletContext().getRealPath("/WEB-INF/student.txt");
        String phoneNumber = "";

        try (BufferedReader reader = new BufferedReader(new FileReader(studentPath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                // Check if line belongs to the logged-in student
                if (parts.length >= 5 && parts[0].equals(username)) {
                    phoneNumber = parts[4];  // Index 4 = phone number (adjust if needed)
                    break;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Generate a random 4-digit OTP (between 1000 and 9999)
        int otp = new Random().nextInt(9000) + 1000;

        // Store required values in the session to use in the OTP verification step
        session.setAttribute("paymentOtp", otp);                  // Store the generated OTP
        session.setAttribute("paymentCourseId", courseId);        // Store the selected course ID
        session.setAttribute("paymentMethod", method);            // Store the selected payment method

        // Save a masked version of the card number to show on confirmation screen
        session.setAttribute("maskedCard", "**** **** **** " + cardNumber.substring(cardNumber.length() - 4));

        // Simulate sending the OTP by printing it to the server console
        System.out.println("[OTP for payment - " + username + "]: " + otp + " sent to phone " + phoneNumber);

        // Redirect to the OTP verification page
        response.sendRedirect("verifyPaymentOtp.jsp");
    }
}
