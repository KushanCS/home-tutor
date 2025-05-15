package course.model;


import course.model.Course;

public class CourseStatus {
    private String username;
    private Course course;
    private boolean paid;

    public CourseStatus(String username, Course course, boolean paid) {
        this.username = username;
        this.course = course;
        this.paid = paid;
    }

    public String getUsername() { return username; }
    public Course getCourse() { return course; }
    public boolean isPaid() { return paid; }
    public void setPaid(boolean paid) { this.paid = paid; }

    @Override
    public String toString() {
        return username + "|" + course.toString() + "|" + paid;
    }

    public static CourseStatus fromString(String line) {
        String[] parts = line.split("\\|", -1);
        if (parts.length == 7) {
            String username = parts[0];
            Course course = new Course(parts[1], parts[2], Double.parseDouble(parts[3]), parts[4], parts[5]);
            boolean paid = Boolean.parseBoolean(parts[6]);
            return new CourseStatus(username, course, paid);
        }
        return null;
    }
}
