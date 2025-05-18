package rating.model;

public class Rating {
    private String username;
    private String courseId;
    private int stars;

    public Rating(String username, String courseId, int stars) {
        this.username = username;
        this.courseId = courseId;
        this.stars = stars;
    }

    public String getUsername() { return username; }
    public String getCourseId() { return courseId; }
    public int getStars() { return stars; }

    @Override
    public String toString() {
        return username + "|" + courseId + "|" + stars;
    }

    public static Rating fromString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length == 3) {
            return new Rating(parts[0], parts[1], Integer.parseInt(parts[2]));
        }
        return null;
    }
    public boolean isValid() {
        return stars >= 1 && stars <= 5 &&
                username != null && !username.isEmpty() &&
                courseId != null && !courseId.isEmpty();
    }
}
