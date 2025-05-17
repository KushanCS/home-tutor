package course.model;

<<<<<<< Updated upstream
// This class represents an enrollment record for a student in a course
public class Enrollment {

    // Fields to store enrollment-related data
    private String studentUsername;  // Username of the student
    private String courseId;         // Unique course identifier
    private String courseName;       // Name of the enrolled course
    private String image;            // Image filename for display
    private String price;            // Price of the course
    private String duration;         // Duration of the course
    private String paidStatus;       // "Yes" or "No" indicating payment status

    // Constructor to initialize all enrollment fields
    public Enrollment(String studentUsername, String courseId, String courseName,
                      String image, String price, String duration, String paidStatus) {
=======
public class Enrollment {
    private String studentUsername;
    private String courseId;
    private String courseName;
    private String image;
    private String price;
    private String duration;
    private String paidStatus; // default: No

    public Enrollment(String studentUsername, String courseId, String courseName, String image, String price, String duration, String paidStatus) {
>>>>>>> Stashed changes
        this.studentUsername = studentUsername;
        this.courseId = courseId;
        this.courseName = courseName;
        this.image = image;
        this.price = price;
        this.duration = duration;
        this.paidStatus = paidStatus;
    }

<<<<<<< Updated upstream
    // Getter methods to access field values
=======
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
    // Setter to update payment status (e.g., after payment is made)
=======
>>>>>>> Stashed changes
    public void setPaidStatus(String paidStatus) {
        this.paidStatus = paidStatus;
    }

<<<<<<< Updated upstream
    // Placeholder method (not functional) – can be implemented if needed
    public void setCourseName(String name) {
        // No action taken – implement if required
    }

    // Convert the enrollment object to a pipe-separated string for file storage
    @Override
    public String toString() {
        return studentUsername + "|" + courseId + "|" + courseName + "|" +
                image + "|" + price + "|" + duration + "|" + paidStatus;
    }

    // Create an Enrollment object by parsing a line from a file
    public static Enrollment fromString(String line) {
        String[] parts = line.split("\\|");

        // Ensure the line contains all expected parts before parsing
        if (parts.length == 7) {
            return new Enrollment(parts[0], parts[1], parts[2],
                    parts[3], parts[4], parts[5], parts[6]);
        }

        // Return null if the data format is incorrect
=======
    public void setCourseName(String name) {}

    @Override
    public String toString() {
        return studentUsername + "|" + courseId + "|" + courseName + "|" + image + "|" + price + "|" + duration + "|" + paidStatus;
    }

    public static Enrollment fromString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length == 7) {
            return new Enrollment(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6]);
        }
>>>>>>> Stashed changes
        return null;
    }
}
