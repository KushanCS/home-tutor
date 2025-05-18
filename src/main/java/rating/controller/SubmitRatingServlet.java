package rating.controller;

import rating.model.Rating;
import rating.util.RatingFileUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/SubmitRatingServlet")
public class SubmitRatingServlet extends HttpServlet {

    // Handles the form submission for adding, updating, or deleting a course rating
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        // Get form action: can be "delete" or null (for add/update)
        String action = request.getParameter("action");

        // Get the currently logged-in user's username and the course being rated
        String username = (String) request.getSession().getAttribute("username");
        String courseId = request.getParameter("courseId");

        // Get the file path for ratings.txt where all ratings are stored
        String path = getServletContext().getRealPath("/WEB-INF/ratings.txt");

        // ✅ Case 1: Handle rating deletion
        if ("delete".equals(action)) {
            List<Rating> existingRatings = RatingFileUtil.readRatings(path);

            // Remove the rating for this user and course, if it exists
            existingRatings.removeIf(r -> r.getUsername().equals(username) && r.getCourseId().equals(courseId));

            // Save the updated list back to the file
            RatingFileUtil.saveAllRatings(existingRatings, path);

            // Redirect with a 'rated=deleted' flag
            response.sendRedirect("CourseDetailsServlet?courseId=" + courseId + "&rated=deleted");
            return;
        }

        // ✅ Case 2: Add or update a rating
        int stars;
        try {
            stars = Integer.parseInt(request.getParameter("stars")); // Get star rating (1–5)
        } catch (NumberFormatException e) {
            // Invalid input (e.g., text instead of number)
            response.sendRedirect("CourseDetailsServlet?courseId=" + courseId + "&error=invalid_rating");
            return;
        }

        // Create new Rating object
        Rating newRating = new Rating(username, courseId, stars);

        // Validate rating range
        if (!newRating.isValid()) {
            response.sendRedirect("CourseDetailsServlet?courseId=" + courseId + "&error=invalid_rating");
            return;
        }

        // Load existing ratings
        List<Rating> existingRatings = RatingFileUtil.readRatings(path);

        // Check if user already rated this course
        boolean alreadyRated = existingRatings.stream()
                .anyMatch(r -> r.getUsername().equals(username) && r.getCourseId().equals(courseId));

        if (alreadyRated) {
            // Update existing rating
            existingRatings.removeIf(r -> r.getUsername().equals(username) && r.getCourseId().equals(courseId));
            existingRatings.add(newRating);
            RatingFileUtil.saveAllRatings(existingRatings, path);

            // Redirect with 'rated=updated' flag
            response.sendRedirect("CourseDetailsServlet?courseId=" + courseId + "&rated=updated");
        } else {
            // New rating – append to file
            RatingFileUtil.saveRating(newRating, path);
            response.sendRedirect("CourseDetailsServlet?courseId=" + courseId + "&rated=true");
        }
    }
}
