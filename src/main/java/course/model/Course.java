package course.model;

public class Course {
    private String courseId;
    private String tutorId;
    private String tutorName;
    private String tutorSubject;
    private String name;
    private String description;
    private String level;
    private String image;
    private String price;
    private String duration;

    public Course(String courseId, String tutorId, String tutorName, String tutorSubject,
                  String name, String description, String level,
                  String image, String price, String duration) {
        this.courseId = courseId;
        this.tutorId = tutorId;
        this.tutorName = tutorName;
        this.tutorSubject = tutorSubject;
        this.name = name;
        this.description = description;
        this.level = level;
        this.image = image;
        this.price = price;
        this.duration = duration;
    }

    public String getCourseId() { return courseId; }
    public String getTutorId() { return tutorId; }
    public String getTutorName() { return tutorName; }
    public String getTutorSubject() { return tutorSubject; }
    public String getName() { return name; }
    public String getDescription() { return description; }
    public String getLevel() { return level; }
    public String getImage() { return image; }
    public String getPrice() { return price; }
    public String getDuration() { return duration; }

    @Override
    public String toString() {
        return courseId + "|" + tutorId + "|" + tutorName + "|" + tutorSubject + "|" +
                name + "|" + description + "|" + level + "|" + image + "|" + price + "|" + duration;
    }

    public static Course fromString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length == 10) {
            return new Course(
                    parts[0], parts[1], parts[2], parts[3], parts[4],
                    parts[5], parts[6], parts[7], parts[8], parts[9]
            );
        }
        return null;
    }
}
