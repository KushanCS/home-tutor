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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doProcess(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doProcess(request, response);
    }

    private void doProcess(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession();

        String username = (String) session.getAttribute("username");

        // 🔁 Primary source from request
        String courseId = request.getParameter("courseId");
        String method = request.getParameter("method");

        // 🔁 Fallback from session (used after OTP step)
        if (courseId == null) courseId = (String) session.getAttribute("paymentCourseId");
        if (method == null) method = (String) session.getAttribute("paymentMethod");

        if (courseId == null || username == null || method == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String enrollPath = getServletContext().getRealPath("/WEB-INF/studentCourses.txt");
        List<Enrollment> enrollments = EnrollmentFileUtil.readEnrollments(enrollPath);

        boolean updated = false;
        String courseName = "", amount = "";

        for (Enrollment e : enrollments) {
            if (e.getStudentUsername().equals(username) && e.getCourseId().equals(courseId)) {
                e.setPaidStatus("Yes"); // update paid status
                courseName = e.getCourseName();
                amount = e.getPrice();
                updated = true;
                break;
            }
        }

        if (updated) {
            EnrollmentFileUtil.writeAllEnrollments(enrollments, enrollPath);

            // ✅ Save payment log
            String paymentPath = getServletContext().getRealPath("/WEB-INF/payment.txt");
            String today = java.time.LocalDate.now().toString();

            Payment payment = new Payment(username, courseId, courseName, method, amount, today, "Success");
            PaymentFileUtil.savePayment(payment, paymentPath);

            // 🧹 Clear session OTP data
            session.removeAttribute("paymentOtp");
            session.removeAttribute("paymentCourseId");
            session.removeAttribute("paymentMethod");
            session.removeAttribute("maskedCard");

            response.sendRedirect("MyCoursesServlet?payment=success");
        } else {
            response.sendRedirect("MyCoursesServlet?payment=notfound");
        }
    }
}
