package rating.controller;

import rating.model.Rating;
import rating.util.RatingFileUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/SubmitRatingServlet")
public class SubmitRatingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");
        String username = (String) request.getSession().getAttribute("username");
        String courseId = request.getParameter("courseId");

        if ("delete".equals(action)) {
            // Handle rating deletion
            String path = getServletContext().getRealPath("/WEB-INF/ratings.txt");
            List<Rating> existingRatings = RatingFileUtil.readRatings(path);

            existingRatings.removeIf(r -> r.getUsername().equals(username) && r.getCourseId().equals(courseId));
            RatingFileUtil.saveAllRatings(existingRatings, path);

            response.sendRedirect("CourseDetailsServlet?courseId=" + courseId + "&rated=deleted");
            return;
        }

        // ✅ Only process stars for non-delete actions
        int stars;
        try {
            stars = Integer.parseInt(request.getParameter("stars"));
        } catch (NumberFormatException e) {
            response.sendRedirect("CourseDetailsServlet?courseId=" + courseId + "&error=invalid_rating");
            return;
        }

        Rating newRating = new Rating(username, courseId, stars);
        if (!newRating.isValid()) {
            response.sendRedirect("CourseDetailsServlet?courseId=" + courseId + "&error=invalid_rating");
            return;
        }

        String path = getServletContext().getRealPath("/WEB-INF/ratings.txt");
        List<Rating> existingRatings = RatingFileUtil.readRatings(path);

        boolean alreadyRated = existingRatings.stream()
                .anyMatch(r -> r.getUsername().equals(username) && r.getCourseId().equals(courseId));

        if (alreadyRated) {
            existingRatings.removeIf(r -> r.getUsername().equals(username) && r.getCourseId().equals(courseId));
            existingRatings.add(newRating);
            RatingFileUtil.saveAllRatings(existingRatings, path);
            response.sendRedirect("CourseDetailsServlet?courseId=" + courseId + "&rated=updated");
        } else {
            RatingFileUtil.saveRating(newRating, path);
            response.sendRedirect("CourseDetailsServlet?courseId=" + courseId + "&rated=true");
        }
    }
}
