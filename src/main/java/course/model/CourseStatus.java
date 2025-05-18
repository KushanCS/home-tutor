package course.model;

/**
 * Represents the enrollment status of a student in a course.
 * This class includes course details and whether the student has paid.
 */
public class CourseStatus {
    // ✅ Fields
    private String username;       // Student's username
    private String courseId;       // ID of the course
    private String courseName;     // Name of the course
    private String tutorSubject;   // Subject the tutor teaches
    private String price;          // Course price
    private String duration;       // Course duration (e.g., 4 weeks)
    private String paid;           // "Yes" if paid, "No" if not

    // ✅ Constructor to initialize all fields
    public CourseStatus(String username, String courseId, String courseName, String tutorSubject,
                        String price, String duration, String paid) {
        this.username = username;
        this.courseId = courseId;
        this.courseName = courseName;
        this.tutorSubject = tutorSubject;
        this.price = price;
        this.duration = duration;
        this.paid = paid;
    }

    // ✅ Getters
    public String getUsername() {
        return username;
    }

    public String getCourseId() {
        return courseId;
    }

    public String getCourseName() {
        return courseName;
    }

    public String getTutorSubject() {
        return tutorSubject;
    }

    public String getPrice() {
        return price;
    }

    public String getDuration() {
        return duration;
    }

    public String getPaid() {
        return paid;
    }

    // ✅ Returns true if payment status is "Yes" (case-insensitive)
    public boolean isPaid() {
        return "Yes".equalsIgnoreCase(paid);
    }

    /**
     * ✅ Convert the CourseStatus object to a single line string for file storage.
     */
    @Override
    public String toString() {
        return username + "|" + courseId + "|" + courseName + "|" + tutorSubject + "|" +
                price + "|" + duration + "|" + paid;
    }

    /**
     * ✅ Convert a line of text from file into a CourseStatus object.
     * Expects exactly 7 parts separated by '|'.
     */
    public static CourseStatus fromString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length == 7) {
            return new CourseStatus(
                    parts[0], parts[1], parts[2],
                    parts[3], parts[4], parts[5], parts[6]
            );
        }
        return null; // Return null if the line format is invalid
    }
}
