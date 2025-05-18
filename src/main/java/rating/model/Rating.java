package rating.model;

/**
 * This class represents a course rating given by a student.
 * A rating includes the student's username, course ID, and star rating (1 to 5).
 */
public class Rating {
    private String username;   // Username of the student who rated the course
    private String courseId;   // Unique ID of the course being rated
    private int stars;         // Star rating (1 to 5)

    // Constructor to initialize all fields
    public Rating(String username, String courseId, int stars) {
        this.username = username;
        this.courseId = courseId;
        this.stars = stars;
    }

    // Getter methods
    public String getUsername() { return username; }
    public String getCourseId() { return courseId; }
    public int getStars() { return stars; }

    /**
     * Converts the Rating object into a string format for saving to file.
     * Format: username|courseId|stars
     */
    @Override
    public String toString() {
        return username + "|" + courseId + "|" + stars;
    }

    /**
     * Reconstructs a Rating object from a line of text read from file.
     * Returns null if the format is invalid.
     */
    public static Rating fromString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length == 3) {
            try {
                return new Rating(parts[0], parts[1], Integer.parseInt(parts[2]));
            } catch (NumberFormatException e) {
                return null; // stars must be an integer
            }
        }
        return null;
    }

    /**
     * Checks whether the rating is valid:
     * - stars must be between 1 and 5
     * - username and courseId must not be null or empty
     */
    public boolean isValid() {
        return stars >= 1 && stars <= 5 &&
                username != null && !username.isEmpty() &&
                courseId != null && !courseId.isEmpty();
    }
}
