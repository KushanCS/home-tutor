package admin.servlet;

import course.utils.EnrollmentFileUtil;
import payment.utils.PaymentFileUtil;
import payment.model.Payment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/RevertPaymentServlet")
public class RevertPaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String courseId = request.getParameter("courseId");

        String paymentPath = getServletContext().getRealPath("/WEB-INF/payment.txt");
        String paidCoursesPath = getServletContext().getRealPath("/WEB-INF/paid_courses.txt");

        List<Payment> payments = PaymentFileUtil.readPayments(paymentPath);
        boolean removed = payments.removeIf(p -> p.getUsername().equals(username) && p.getCourseId().equals(courseId));

        if (removed) {
            PaymentFileUtil.writeAllPayments(payments, paymentPath);
            String enrollPath = getServletContext().getRealPath("/WEB-INF/studentCourses.txt");
            EnrollmentFileUtil.markEnrollmentUnpaid(username, courseId, enrollPath);
            request.getSession().setAttribute("message", "Payment reverted and course marked unpaid.");
        } else {
            request.getSession().setAttribute("error", "Payment not found or could not be reverted.");
        }

        response.sendRedirect("adminPayments.jsp");
    }
}
