package course.model;

/**
 * Represents a Course object with all necessary details.
 */
public class Course {
    // ✅ Attributes (Fields)
    private String courseId;
    private String tutorId;
    private String tutorName;
    private String tutorSubject;
    private String name;         // Course title/name
    private String description;  // Course description
    private String level;        // Difficulty level (e.g., Beginner, Advanced)
    private String image;        // Filename of course image
    private String price;        // Course price
    private String duration;     // Course duration (e.g., 4 weeks)

    // ✅ Constructor to initialize all course fields
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

    // ✅ Getters to access course field values
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

    /**
     * ✅ Converts the course object to a string format suitable for file storage.
     *    Fields are separated by '|' character.
     */
    @Override
    public String toString() {
        return courseId + "|" + tutorId + "|" + tutorName + "|" + tutorSubject + "|" +
                name + "|" + description + "|" + level + "|" + image + "|" + price + "|" + duration;
    }

    /**
     * ✅ Creates a Course object by parsing a line from a file.
     *    Expects exactly 10 fields separated by '|'.
     */
    public static Course fromString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length == 10) {
            return new Course(
                    parts[0], parts[1], parts[2], parts[3], parts[4],
                    parts[5], parts[6], parts[7], parts[8], parts[9]
            );
        }
        return null; // Return null if the line is invalid
    }
}
