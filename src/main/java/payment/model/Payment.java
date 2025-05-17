package payment.model;

public class Payment {
    private String username;
    private String courseId;
    private String courseName;
    private String method;
    private String amount;
    private String date;
    private String status;

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

    public String getUsername() { return username; }
    public String getCourseId() { return courseId; }
    public String getCourseName() { return courseName; }
    public String getMethod() { return method; }
    public String getAmount() { return amount; }
    public String getDate() { return date; }
    public String getStatus() { return status; }

    @Override
    public String toString() {
        return username + "|" + courseId + "|" + courseName + "|" +
                method + "|" + amount + "|" + date + "|" + status;
    }

    public static Payment fromString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length == 7) {
            return new Payment(parts[0], parts[1], parts[2],
                    parts[3], parts[4], parts[5], parts[6]);
        }
        return null;
    }
}
