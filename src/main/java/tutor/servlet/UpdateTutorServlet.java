package tutor.servlet;

import tutor.model.Tutor;
import tutor.util.TutorFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/UpdateTutorServlet")
@MultipartConfig
public class UpdateTutorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Tutor loggedInTutor = (Tutor) session.getAttribute("tutor");

        if (loggedInTutor == null) {
            response.sendRedirect("loginTutor.jsp");
            return;
        }

        // Update form fields
        String name = request.getParameter("name");
        String subject = request.getParameter("subject");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String campusName = request.getParameter("campusName");
        String degreeCourse = request.getParameter("degreeCourse");
        String degreeLevel = request.getParameter("degreeLevel");
        String address = request.getParameter("address");
        String about = request.getParameter("about");

        loggedInTutor.setName(name);
        loggedInTutor.setSubject(subject);
        loggedInTutor.setEmail(email);
        loggedInTutor.setContact(contact);
        loggedInTutor.setCampusName(campusName);
        loggedInTutor.setDegreeCourse(degreeCourse);
        loggedInTutor.setDegreeLevel(degreeLevel);
        loggedInTutor.setAddress(address);
        loggedInTutor.setAbout(about);

        // ✅ Handle optional profile image upload
        Part filePart = request.getPart("profileImage");
        if (filePart != null && filePart.getSize() > 0) {
            String uploadPath = getServletContext().getRealPath("/") + "image";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            String fileName = loggedInTutor.getTutorId() + "_" + System.currentTimeMillis() + ".jpg";
            filePart.write(uploadPath + File.separator + fileName);

            // Replace previous file reference
            loggedInTutor.setProfileImage(fileName);
        }

        // ✅ Update file
        List<Tutor> allTutors = TutorFileUtil.getAllTutors();
        for (int i = 0; i < allTutors.size(); i++) {
            if (allTutors.get(i).getTutorId().equals(loggedInTutor.getTutorId())) {
                allTutors.set(i, loggedInTutor);  // replace
                break;
            }
        }
        TutorFileUtil.saveAllTutors(allTutors); // overwrite file

        // ✅ Update BST cache
        TutorFileUtil.reloadBST();

        session.setAttribute("tutor", loggedInTutor); // update session
        response.sendRedirect("tutor_dashboard.jsp?success=profile");
    }
}
