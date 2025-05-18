package course.model;

/**
 * Represents an enrollment record of a student in a specific course.
 * Includes course details, image, and payment status.
 */
public class Enrollment {

    // ✅ Fields (Attributes)
    private String studentUsername;  // The username of the enrolled student
    private String courseId;         // ID of the course
    private String courseName;       // Name of the course
    private String image;            // Image filename for the course
    private String price;            // Price of the course
    private String duration;         // Duration of the course
    private String paidStatus;       // "Yes" or "No"

    // ✅ Constructor to initialize all fields
    public Enrollment(String studentUsername, String courseId, String courseName,
                      String image, String price, String duration, String paidStatus) {
        this.studentUsername = studentUsername;
        this.courseId = courseId;
        this.courseName = courseName;
        this.image = image;
        this.price = price;
        this.duration = duration;
        this.paidStatus = paidStatus;
    }

    // ✅ Getter methods
    public String getStudentUsername() {
        return studentUsername;
    }

    public String getCourseId() {
        return courseId;
    }

    public String getCourseName() {
        return courseName;
    }

    public String getImage() {
        return image;
    }

    public String getPrice() {
        return price;
    }

    public String getDuration() {
        return duration;
    }

    public String getPaidStatus() {
        return paidStatus;
    }

    // ✅ Setter method to update payment status
    public void setPaidStatus(String paidStatus) {
        this.paidStatus = paidStatus;
    }

    // ✅ Setter method to update CourseName
    public void setCourseName(String name) {
        // You can implement this if you want to update courseName dynamically
    }

    /**
     * ✅ Converts the Enrollment object into a line of text for file storage.
     */
    @Override
    public String toString() {
        return studentUsername + "|" + courseId + "|" + courseName + "|" +
                image + "|" + price + "|" + duration + "|" + paidStatus;
    }

    /**
     * ✅ Creates an Enrollment object from a line of text.
     * Expects exactly 7 fields separated by '|'.
     */
    public static Enrollment fromString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length == 7) {
            return new Enrollment(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6]);
        }
        return null; // Return null if input format is invalid
    }
}
