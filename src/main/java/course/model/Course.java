package course.model;

// This class represents a Course object with all relevant details
public class Course {

    // Fields to store course and tutor information
    private String courseId;
    private String tutorId;
    private String tutorName;
    private String tutorSubject;
    private String name;         // Course name
    private String description;  // Course description
    private String level;        // Beginner / Intermediate / Advanced
    private String image;        // Image filename
    private String price;        // Price as a string (can be converted to number if needed)
    private String duration;     // Duration (e.g., "6 weeks")

    // Constructor to initialize all fields
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

    // Getter methods to access each field
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

    // Converts this Course object into a string for saving to a file
    @Override
    public String toString() {
        return courseId + "|" + tutorId + "|" + tutorName + "|" + tutorSubject + "|" +
                name + "|" + description + "|" + level + "|" + image + "|" + price + "|" + duration;
    }

    // Parses a line from file and returns a Course object
    public static Course fromString(String line) {
        String[] parts = line.split("\\|");

        // Validate correct number of parts before creating Course object
        if (parts.length == 10) {
            return new Course(
                    parts[0], parts[1], parts[2], parts[3], parts[4],
                    parts[5], parts[6], parts[7], parts[8], parts[9]
            );
        }

        // Return null if the line is malformed
        return null;
    }
}
