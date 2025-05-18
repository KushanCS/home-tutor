package payment.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ProcessPaymentServlet")
public class ProcessPaymentServlet extends HttpServlet {

    // Handles POST request from ChoosePaymentMethod.jsp (after student selects payment method)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve selected payment method from the form (e.g., "bank" or "card")
        String method = request.getParameter("paymentMethod");

        // Retrieve the courseId from session (set earlier in the enrollment/payment flow)
        String courseId = (String) request.getSession().getAttribute("paymentCourseId");

        // Validate inputs - if either value is missing, redirect to method selection page with error
        if (method == null || courseId == null) {
            response.sendRedirect("ChoosePaymentMethod.jsp?error=missing");
            return;
        }

        // Redirect to the appropriate payment form page based on selected method
        switch (method) {
            case "bank":
                // If bank transfer selected, go to the bankPayment.jsp page
                response.sendRedirect("bankPayment.jsp?courseId=" + courseId);
                break;
            case "card":
                // If card selected, go to the cardPayment.jsp page
                response.sendRedirect("cardPayment.jsp?courseId=" + courseId); // unified card payment page
                break;
            default:
                // If method is unrecognized, redirect back with an error
                response.sendRedirect("ChoosePaymentMethod.jsp?error=invalid");
        }
    }
}
