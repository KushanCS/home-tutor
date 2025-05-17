package course.model;

public class CourseStatus {
    private String username;
    private String courseId;
    private String courseName;
    private String tutorSubject;
    private String price;
    private String duration;
    private String paid; // "Yes" or "No"

    public CourseStatus(String username, String courseId, String courseName, String tutorSubject, String price, String duration, String paid) {
        this.username = username;
        this.courseId = courseId;
        this.courseName = courseName;
        this.tutorSubject = tutorSubject;
        this.price = price;
        this.duration = duration;
        this.paid = paid;
    }

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

    public boolean isPaid() {
        return "Yes".equalsIgnoreCase(paid);
    }

    @Override
    public String toString() {
        return username + "|" + courseId + "|" + courseName + "|" + tutorSubject + "|" + price + "|" + duration + "|" + paid;
    }

    public static CourseStatus fromString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length == 7) {
            return new CourseStatus(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6]);
        }
        return null;
    }
}
