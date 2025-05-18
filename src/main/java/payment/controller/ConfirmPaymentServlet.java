package payment.controller;

import course.model.Enrollment;
import course.utils.EnrollmentFileUtil;
import payment.model.Payment;
import payment.utils.PaymentFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ConfirmPaymentServlet")
public class ConfirmPaymentServlet extends HttpServlet {

    // Handle POST requests (usually form submissions)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doProcess(request, response);
    }

    // Handle GET requests (e.g., direct link or redirect)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doProcess(request, response);
    }

    // Main method to handle both GET and POST logic
    private void doProcess(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession();

        // Get currently logged-in student's username from session
        String username = (String) session.getAttribute("username");

        // Get course ID and payment method from request (preferred)
        String courseId = request.getParameter("courseId");
        String method = request.getParameter("method");

        // Fallback: if values are not found in request, check session attributes
        if (courseId == null) courseId = (String) session.getAttribute("paymentCourseId");
        if (method == null) method = (String) session.getAttribute("paymentMethod");

        // If required data is missing, redirect to login
        if (courseId == null || username == null || method == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Read all current enrollments from file
        String enrollPath = getServletContext().getRealPath("/WEB-INF/studentCourses.txt");
        List<Enrollment> enrollments = EnrollmentFileUtil.readEnrollments(enrollPath);

        // Flags and variables to track changes
        boolean updated = false;
        String courseName = "", amount = "";

        // Find the matching enrollment entry and mark it as paid
        for (Enrollment e : enrollments) {
            if (e.getStudentUsername().equals(username) && e.getCourseId().equals(courseId)) {
                e.setPaidStatus("Yes");  // Mark payment status as "Yes"
                courseName = e.getCourseName();  // Get course name for receipt
                amount = e.getPrice();  // Get course price for payment record
                updated = true;
                break;
            }
        }

        if (updated) {
            // Save updated enrollments back to the file
            EnrollmentFileUtil.writeAllEnrollments(enrollments, enrollPath);

            // Create and save the payment record
            String paymentPath = getServletContext().getRealPath("/WEB-INF/payment.txt");
            String today = java.time.LocalDate.now().toString();  // Get today's date

            Payment payment = new Payment(username, courseId, courseName, method, amount, today, "Success");
            PaymentFileUtil.savePayment(payment, paymentPath);

            // Clear temporary session data used during OTP/payment flow
            session.removeAttribute("paymentOtp");
            session.removeAttribute("paymentCourseId");
            session.removeAttribute("paymentMethod");
            session.removeAttribute("maskedCard");

            // Redirect to course list with success message
            response.sendRedirect("MyCoursesServlet?payment=success");
        } else {
            // If enrollment not found, redirect with error message
            response.sendRedirect("MyCoursesServlet?payment=notfound");
        }
    }
}
