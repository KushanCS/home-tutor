package course.model;

public class Enrollment {
    private String studentUsername;
    private String courseId;
    private String courseName;
    private String image;
    private String price;
    private String duration;
    private String paidStatus; // default: No

    public Enrollment(String studentUsername, String courseId, String courseName, String image, String price, String duration, String paidStatus) {
        this.studentUsername = studentUsername;
        this.courseId = courseId;
        this.courseName = courseName;
        this.image = image;
        this.price = price;
        this.duration = duration;
        this.paidStatus = paidStatus;
    }

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

    public void setPaidStatus(String paidStatus) {
        this.paidStatus = paidStatus;
    }

    @Override
    public String toString() {
        return studentUsername + "|" + courseId + "|" + courseName + "|" + image + "|" + price + "|" + duration + "|" + paidStatus;
    }

    public static Enrollment fromString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length == 7) {
            return new Enrollment(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6]);
        }
        return null;
    }

    public void setCourseName(String name) {
    }
}
