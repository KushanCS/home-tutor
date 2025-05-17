package payment.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ProcessPaymentServlet")
public class ProcessPaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String method = request.getParameter("paymentMethod");
        String courseId = (String) request.getSession().getAttribute("paymentCourseId");

        if (method == null || courseId == null) {
            response.sendRedirect("ChoosePaymentMethod.jsp?error=missing");
            return;
        }

        switch (method) {
            case "bank":
                response.sendRedirect("bankPayment.jsp?courseId=" + courseId);
                break;
            case "card":
                response.sendRedirect("cardPayment.jsp?courseId=" + courseId); // Unified card payment page
                break;
            default:
                response.sendRedirect("ChoosePaymentMethod.jsp?error=invalid");
        }
    }
}
