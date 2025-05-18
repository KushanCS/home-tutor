package admin.servlet;

import admin.services.TutorManagement;
import tutor.model.Tutor;
import tutor.util.TutorFileUtil;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.Paths;
import java.util.List;

@MultipartConfig
@WebServlet("/TutorManagementServlet")
public class TutorManagementServlet extends HttpServlet {
    private TutorManagement tutorManagement;
    private static final String TUTOR_FILE = "/WEB-INF/tutors.txt";

    @Override
    public void init() throws ServletException {
        String filePath = getServletContext().getRealPath(TUTOR_FILE);
        this.tutorManagement = new TutorManagement(filePath);  // ✅ sets file path internally
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdminAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            switch (action != null ? action : "viewTutors") {
                case "viewTutors":
                    viewTutors(request, response);
                    break;
                case "editTutorForm":
                    showEditForm(request, response);
                    break;
                case "addTutorForm":
                    showAddForm(request, response);
                    break;
                case "searchTutors":
                    searchTutors(request, response);
                    break;
                default:
                    viewTutors(request, response);
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

        try {
            switch (action) {
                case "deleteTutor":
                    deleteTutor(request, response);
                    break;
                case "updateTutor":
                case "addTutor":
                    saveTutor(request, response);
                    break;
                default:
                    viewTutors(request, response);
            }
        } catch (Exception e) {
            handleError(request, response, "Operation failed: " + e.getMessage());
        }
    }

    private void viewTutors(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Tutor> tutors = tutorManagement.getAllTutors();
        request.setAttribute("tutors", tutors);
        request.getRequestDispatcher("/TutorManagement.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tutorId = request.getParameter("id");
        Tutor tutor = tutorManagement.getTutorById(tutorId);

        if (tutor == null) {
            request.getSession().setAttribute("error", "Tutor not found with ID: " + tutorId);
            response.sendRedirect("TutorManagementServlet?action=viewTutors");
            return;
        }

        request.setAttribute("tutor", tutor);
        request.getRequestDispatcher("/editTutor.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/addTutor.jsp").forward(request, response);
    }

    private void searchTutors(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");
        List<Tutor> tutors = tutorManagement.searchTutors(searchTerm);

        request.setAttribute("tutors", tutors);
        request.setAttribute("searchTerm", searchTerm);
        request.getRequestDispatcher("/TutorManagement.jsp").forward(request, response);
    }

    private void deleteTutor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tutorId = request.getParameter("id");

        System.out.println("Received delete request for tutor ID: " + tutorId);

        if (tutorManagement.deleteTutor(tutorId)) {
            System.out.println("Tutor deleted: " + tutorId);
            request.getSession().setAttribute("message", "Tutor deleted successfully");
        } else {
            System.out.println("Tutor deletion failed for ID: " + tutorId);
            request.getSession().setAttribute("error", "Failed to delete tutor");
        }

        response.sendRedirect("TutorManagementServlet?action=viewTutors");
    }

    private void saveTutor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Tutor tutor = createTutorFromRequest(request);
            boolean isUpdate = "updateTutor".equals(request.getParameter("action"));
            boolean success;

            if (isUpdate) {
                success = tutorManagement.updateTutor(tutor);
            } else {
                success = tutorManagement.addTutor(tutor);
            }

            if (success) {
                String message = isUpdate ? "Tutor updated successfully" : "Tutor added successfully";
                request.getSession().setAttribute("message", message);
            } else {
                String error = isUpdate ? "Failed to update tutor" : "Failed to add tutor";
                request.getSession().setAttribute("error", error);
            }
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Error saving tutor: " + e.getMessage());
        }

        response.sendRedirect("TutorManagementServlet?action=viewTutors");
    }

    private Tutor createTutorFromRequest(HttpServletRequest request) throws ServletException, IOException {
        Tutor tutor = new Tutor();

        String tutorId = request.getParameter("tutorId");
        if (tutorId != null && !tutorId.isEmpty()) {
            tutor = tutorManagement.getTutorById(tutorId);
            if (tutor == null) throw new ServletException("Tutor not found with ID: " + tutorId);
        } else {
            tutor.setTutorId(TutorFileUtil.generateUniqueTutorId());
        }

        // Text fields
        tutor.setUsername(request.getParameter("username"));
        tutor.setName(request.getParameter("name"));
        tutor.setEmail(request.getParameter("email"));
        tutor.setSubject(request.getParameter("subject"));
        tutor.setContact(request.getParameter("contact"));
        tutor.setCampusName(request.getParameter("campusName"));
        tutor.setDegreeCourse(request.getParameter("degreeCourse"));
        tutor.setDegreeLevel(request.getParameter("degreeLevel"));
        tutor.setAddress(request.getParameter("address"));
        tutor.setAbout(request.getParameter("about"));

        // Password
        String password = request.getParameter("password");
        if (password != null && !password.trim().isEmpty()) {
            tutor.setPassword(TutorFileUtil.hashPassword(password));
        }

        // Image upload
        Part imagePart = request.getPart("profileImage");
        if (imagePart != null && imagePart.getSize() > 0) {
            String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("/") + "image";

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            File savedFile = new File(uploadDir, fileName);
            imagePart.write(savedFile.getAbsolutePath());

            tutor.setProfileImage(fileName);
        } else {
            tutor.setProfileImage("default.png");
        }

        return tutor;
    }

    private boolean isAdminAuthenticated(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && "admin".equals(session.getAttribute("userType"));
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        request.setAttribute("error", message);
        request.getRequestDispatcher("/TutorManagement.jsp").forward(request, response);
    }
}
