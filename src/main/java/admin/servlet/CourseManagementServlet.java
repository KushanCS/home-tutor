
package admin.servlet;

import course.model.Course;
import course.model.Enrollment;
import course.utils.CourseFileUtil;
import course.utils.EnrollmentFileUtil;
import payment.model.Payment;
import payment.utils.PaymentFileUtil;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/CourseManagementServlet")
public class CourseManagementServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdminAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        String courseFilePath = getServletContext().getRealPath("/WEB-INF/courses.txt");
        String enrollmentFilePath = getServletContext().getRealPath("/WEB-INF/studentCourses.txt");

        try {
            switch (action != null ? action : "viewCourses") {
                case "viewCourses":
                    viewCourses(request, response, courseFilePath);
                    break;
                case "editCourseForm":
                    showEditForm(request, response, courseFilePath);
                    break;
                case "addCourseForm":
                    request.getRequestDispatcher("/addCourse.jsp").forward(request, response);
                    break;
                case "viewEnrollments":
                    viewAllEnrollments(request, response, enrollmentFilePath, courseFilePath);
                    break;
                case "viewCourseEnrollments":
                    viewCourseEnrollments(request, response, enrollmentFilePath, courseFilePath);
                    break;
                case "searchCourses":
                    searchCourses(request, response, courseFilePath);
                    break;
                default:
                    viewCourses(request, response, courseFilePath);
            }
        } catch (Exception e) {
            handleError(request, response, "Error processing request: " + e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdminAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        String courseFilePath = getServletContext().getRealPath("/WEB-INF/courses.txt");
        String enrollmentFilePath = getServletContext().getRealPath("/WEB-INF/studentCourses.txt");

        try {
            switch (action) {
                case "deleteCourse":
                    deleteCourse(request, response, courseFilePath, enrollmentFilePath);
                    break;
                case "updateCourse":
                    updateCourse(request, response, courseFilePath);
                    break;
                case "addCourse":
                    addCourse(request, response, courseFilePath);
                    break;
                case "removeEnrollment":
                    removeEnrollment(request, response, enrollmentFilePath);
                    break;
                case "updateEnrollmentStatus":
                    updateEnrollmentStatus(request, response, enrollmentFilePath);
                    break;
                default:
                    if ("markPaid".equals(action)) {
                        String username = request.getParameter("username");
                        String courseId = request.getParameter("courseId");
                        String courseName = request.getParameter("courseName");
                        String method = request.getParameter("method");
                        String amount = request.getParameter("amount");
                        String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

                        Payment payment = new Payment(username, courseId, courseName, method, amount, date, "Paid");
                        String path = getServletContext().getRealPath("/WEB-INF/payments.txt");
                        PaymentFileUtil.savePayment(payment, path);

                        response.sendRedirect("enrollmentManagement.jsp?status=marked");
                    } else {
                        viewCourses(request, response, courseFilePath);
                    }
            }
        } catch (Exception e) {
            handleError(request, response, "Operation failed: " + e.getMessage());
        }
    }

    private void viewCourses(HttpServletRequest request, HttpServletResponse response, String filePath)
            throws ServletException, IOException {
        List<Course> courses = CourseFileUtil.getAllCourses(filePath);
        request.setAttribute("courses", courses);
        request.getRequestDispatcher("/courseManagement.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response, String filePath)
            throws ServletException, IOException {
        String courseId = request.getParameter("id");
        Course course = getCourseById(courseId, filePath);

        if (course != null) {
            request.setAttribute("course", course);
            request.getRequestDispatcher("/editCourse.jsp").forward(request, response);
        } else {
            request.getSession().setAttribute("error", "Course not found with ID: " + courseId);
            response.sendRedirect("CourseManagementServlet?action=viewCourses");
        }
    }

    private void viewAllEnrollments(HttpServletRequest request, HttpServletResponse response,
                                    String enrollPath, String coursePath) throws ServletException, IOException {
        List<Enrollment> enrollments = EnrollmentFileUtil.readEnrollments(enrollPath);
        List<Course> allCourses = CourseFileUtil.getAllCourses(coursePath);

        for (Enrollment e : enrollments) {
            for (Course c : allCourses) {
                if (e.getCourseId().equals(c.getCourseId())) {
                    e.setCourseName(c.getName());
                    break;
                }
            }
        }

        request.setAttribute("enrollments", enrollments);
        request.getRequestDispatcher("/enrollmentManagement.jsp").forward(request, response);
    }

    private void viewCourseEnrollments(HttpServletRequest request, HttpServletResponse response,
                                       String enrollPath, String coursePath) throws ServletException, IOException {
        String courseId = request.getParameter("id");
        Course course = getCourseById(courseId, coursePath);

        if (course != null) {
            List<Enrollment> allEnrollments = EnrollmentFileUtil.readEnrollments(enrollPath);
            List<Enrollment> courseEnrollments = new ArrayList<>();

            for (Enrollment e : allEnrollments) {
                if (e.getCourseId().equals(courseId)) {
                    courseEnrollments.add(e);
                }
            }

            request.setAttribute("course", course);
            request.setAttribute("enrollments", courseEnrollments);
            request.getRequestDispatcher("/courseEnrollments.jsp").forward(request, response);
        } else {
            request.getSession().setAttribute("error", "Course not found with ID: " + courseId);
            response.sendRedirect("CourseManagementServlet?action=viewCourses");
        }
    }

    private void searchCourses(HttpServletRequest request, HttpServletResponse response, String filePath)
            throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm").toLowerCase();
        List<Course> allCourses = CourseFileUtil.getAllCourses(filePath);
        List<Course> filteredCourses = new ArrayList<>();

        for (Course c : allCourses) {
            if (c.getName().toLowerCase().contains(searchTerm) ||
                    c.getDescription().toLowerCase().contains(searchTerm) ||
                    c.getCourseId().toLowerCase().contains(searchTerm)) {
                filteredCourses.add(c);
            }
        }

        request.setAttribute("courses", filteredCourses);
        request.setAttribute("searchTerm", searchTerm);
        request.getRequestDispatcher("/courseManagement.jsp").forward(request, response);
    }

    private void deleteCourse(HttpServletRequest request, HttpServletResponse response,
                              String coursePath, String enrollPath) throws IOException {
        String courseId = request.getParameter("id");

        List<Enrollment> enrollments = EnrollmentFileUtil.readEnrollments(enrollPath);
        List<Enrollment> updatedEnrollments = new ArrayList<>();

        for (Enrollment e : enrollments) {
            if (!e.getCourseId().equals(courseId)) {
                updatedEnrollments.add(e);
            }
        }

        EnrollmentFileUtil.writeAllEnrollments(updatedEnrollments, enrollPath);
        CourseFileUtil.deleteCourse(courseId, coursePath);

        request.getSession().setAttribute("message", "Course and its enrollments deleted successfully");
        response.sendRedirect("CourseManagementServlet?action=viewCourses");
    }

    private void updateCourse(HttpServletRequest request, HttpServletResponse response, String filePath)
            throws IOException {
        String courseId = request.getParameter("courseId");
        Course existingCourse = getCourseById(courseId, filePath);

        if (existingCourse != null) {
            String price = request.getParameter("price");
            String duration = request.getParameter("duration");

            Course updatedCourse = new Course(
                    courseId,
                    existingCourse.getTutorId(),
                    existingCourse.getTutorName(),
                    existingCourse.getTutorSubject(),
                    request.getParameter("name"),
                    request.getParameter("description"),
                    request.getParameter("level"),
                    existingCourse.getImage(),
                    price,
                    duration
            );

            CourseFileUtil.updateCourse(updatedCourse, filePath);
            request.getSession().setAttribute("message", "Course updated successfully");
        } else {
            request.getSession().setAttribute("error", "Course not found");
        }

        response.sendRedirect("CourseManagementServlet?action=viewCourses");
    }

    private void addCourse(HttpServletRequest request, HttpServletResponse response, String filePath)
            throws IOException {
        Course newCourse = new Course(
                CourseFileUtil.generateCourseId(),
                "admin",
                "Admin",
                "General",
                request.getParameter("name"),
                request.getParameter("description"),
                request.getParameter("level"),
                "default-course.jpg",
                request.getParameter("price"),
                request.getParameter("duration")
        );

        CourseFileUtil.saveCourse(newCourse, filePath);
        request.getSession().setAttribute("message", "Course added successfully");
        response.sendRedirect("CourseManagementServlet?action=viewCourses");
    }

    private void removeEnrollment(HttpServletRequest request, HttpServletResponse response, String filePath)
            throws IOException {
        String studentUsername = request.getParameter("studentUsername");
        String courseId = request.getParameter("courseId");

        List<Enrollment> enrollments = EnrollmentFileUtil.readEnrollments(filePath);
        List<Enrollment> updatedEnrollments = new ArrayList<>();

        for (Enrollment e : enrollments) {
            if (!(e.getStudentUsername().equals(studentUsername) && e.getCourseId().equals(courseId))) {
                updatedEnrollments.add(e);
            }
        }

        EnrollmentFileUtil.writeAllEnrollments(updatedEnrollments, filePath);
        request.getSession().setAttribute("message", "Enrollment removed successfully");

        String referer = request.getHeader("referer");
        response.sendRedirect(referer != null ? referer : "CourseManagementServlet?action=viewEnrollments");
    }

    private void updateEnrollmentStatus(HttpServletRequest request, HttpServletResponse response, String filePath)
            throws IOException {
        String studentUsername = request.getParameter("studentUsername");
        String courseId = request.getParameter("courseId");
        String newStatus = request.getParameter("status");

        List<Enrollment> enrollments = EnrollmentFileUtil.readEnrollments(filePath);
        List<Enrollment> updatedEnrollments = new ArrayList<>();
        Enrollment target = null;
        boolean found = false;

        for (Enrollment e : enrollments) {
            if (e.getStudentUsername().equals(studentUsername) && e.getCourseId().equals(courseId)) {
                e.setPaidStatus(newStatus);
                found = true;
                target = e; // capture the enrollment for payment saving
            }
            updatedEnrollments.add(e);
        }

        if (found) {
            EnrollmentFileUtil.writeAllEnrollments(updatedEnrollments, filePath);
            request.getSession().setAttribute("message", "Enrollment status updated successfully");

            // ✅ Save payment if marked as Paid
            if ("Yes".equalsIgnoreCase(newStatus) && target != null) {
                String courseName = target.getCourseName(); // ensure Enrollment has this
                String method = "Admin (Dropdown)";
                String amount = target.getPrice();          // ensure it's stored as String
                String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

                Payment payment = new Payment(studentUsername, courseId, courseName, method, amount, date, "Paid");
                String paymentPath = getServletContext().getRealPath("/WEB-INF/payments.txt");
                PaymentFileUtil.savePayment(payment, paymentPath);
            }
        } else {
            request.getSession().setAttribute("error", "Enrollment not found");
        }

        String referer = request.getHeader("referer");
        response.sendRedirect(referer != null ? referer : "CourseManagementServlet?action=viewEnrollments");
    }

    private Course getCourseById(String courseId, String filePath) throws IOException {
        List<Course> courses = CourseFileUtil.getAllCourses(filePath);
        for (Course c : courses) {
            if (c.getCourseId().equals(courseId)) {
                return c;
            }
        }
        return null;
    }

    private boolean isAdminAuthenticated(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && "admin".equals(session.getAttribute("userType"));
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        request.setAttribute("error", message);
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
}
