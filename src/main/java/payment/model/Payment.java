package payment.model;

/**
 * Represents a Payment record made by a student for a course.
 */
public class Payment {
    private String username;    // Username of the student who made the payment
    private String courseId;    // Unique ID of the course
    private String courseName;  // Name of the course
    private String method;      // Payment method (e.g., bank, card)
    private String amount;      // Payment amount
    private String date;        // Date of payment
    private String status;      // Status of payment (e.g., Success, Failed)

    // Constructor to initialize all fields
    public Payment(String username, String courseId, String courseName,
                   String method, String amount, String date, String status) {
        this.username = username;
        this.courseId = courseId;
        this.courseName = courseName;
        this.method = method;
        this.amount = amount;
        this.date = date;
        this.status = status;
    }

    // Getters for each field
    public String getUsername() { return username; }
    public String getCourseId() { return courseId; }
    public String getCourseName() { return courseName; }
    public String getMethod() { return method; }
    public String getAmount() { return amount; }
    public String getDate() { return date; }
    public String getStatus() { return status; }

    /**
     * Converts the Payment object into a single line string suitable for saving in a file.
     * Fields are separated by "|".
     */
    @Override
    public String toString() {
        return username + "|" + courseId + "|" + courseName + "|" +
                method + "|" + amount + "|" + date + "|" + status;
    }

    /**
     * Reconstructs a Payment object from a line of text (read from file).
     * Expects exactly 7 parts separated by "|".
     */
    public static Payment fromString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length == 7) {
            return new Payment(parts[0], parts[1], parts[2],
                    parts[3], parts[4], parts[5], parts[6]);
        }
        return null; // Return null if the line format is invalid
    }
}
