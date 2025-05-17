package course.model;

// This class represents the status of a course for a specific student
// It is mainly used to track whether the student has enrolled and paid
public class CourseStatus {

    // Fields to represent enrollment and payment status for a course
    private String username;       // Student's username
    private String courseId;       // Unique course identifier
    private String courseName;     // Name of the course
    private String tutorSubject;   // Subject taught by the tutor
    private String price;          // Price of the course
    private String duration;       // Duration of the course (e.g., "6 weeks")
    private String paid;           // "Yes" or "No" - whether the course has been paid for

    // Constructor to initialize all fields
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

    // Getters to retrieve individual values
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

    // Helper method to return payment status as a boolean
    public boolean isPaid() {
        return "Yes".equalsIgnoreCase(paid);
    }

    // Converts this object to a string for saving in a file
    @Override
    public String toString() {
        return username + "|" + courseId + "|" + courseName + "|" + tutorSubject + "|" +
                price + "|" + duration + "|" + paid;
    }

    // Parses a string line and creates a CourseStatus object
    public static CourseStatus fromString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length == 7) {
            return new CourseStatus(
                    parts[0], parts[1], parts[2],
                    parts[3], parts[4], parts[5], parts[6]
            );
        }
        // Return null if the data format is incorrect
        return null;
    }
}
