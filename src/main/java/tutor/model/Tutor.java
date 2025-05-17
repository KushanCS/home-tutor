package tutor.model;

/**
 * The Tutor class represents a tutor's profile information.
 * It includes personal, academic, and login-related data.
 */
public class Tutor {

    // Basic and academic details
    private String tutorId;
    private String username;
    private String name;
    private String subject;
    private String email;
    private String contact;
    private String campusName;
    private String degreeCourse;
    private String degreeLevel;
    private String address;
    private String password;
    private String about;
    private String profileImage;

    /**
     * Constructor with all fields including profile image.
     *
     * @param tutorId       unique tutor identifier
     * @param username      login username
     * @param name          full name
     * @param subject       subject expertise
     * @param email         email address
     * @param contact       contact number
     * @param campusName    university/college name
     * @param degreeCourse  course enrolled in (e.g. BSc IT)
     * @param degreeLevel   level of study (e.g. 1st year)
     * @param address       home address
     * @param password      hashed or raw password
     * @param about         description/about the tutor
     * @param profileImage  profile picture filename/path
     */
    public Tutor(String tutorId, String username, String name, String subject, String email,
                 String contact, String campusName, String degreeCourse, String degreeLevel,
                 String address, String password, String about, String profileImage) {
        this.tutorId = tutorId;
        this.username = username;
        this.name = name;
        this.subject = subject;
        this.email = email;
        this.contact = contact;
        this.campusName = campusName;
        this.degreeCourse = degreeCourse;
        this.degreeLevel = degreeLevel;
        this.address = address;
        this.password = password;
        this.about = about;
        this.profileImage = profileImage;
    }
    public Tutor() {

    }

    // Default constructor for flexibility (e.g., when using setters)
    public Tutor() {}

    // Getter methods
    public String getTutorId() { return tutorId; }
    public String getUsername() { return username; }
    public String getName() { return name; }
    public String getSubject() { return subject; }
    public String getEmail() { return email; }
    public String getContact() { return contact; }
    public String getCampusName() { return campusName; }
    public String getDegreeCourse() { return degreeCourse; }
    public String getDegreeLevel() { return degreeLevel; }
    public String getAddress() { return address; }
    public String getPassword() { return password; }
    public String getAbout() { return about; }
    public String getProfileImage() { return profileImage; }

    // Setter methods
    public void setTutorId(String tutorId) { this.tutorId = tutorId; }
    public void setUsername(String username) { this.username = username; }
    public void setName(String name) { this.name = name; }
    public void setSubject(String subject) { this.subject = subject; }
    public void setEmail(String email) { this.email = email; }
    public void setContact(String contact) { this.contact = contact; }
    public void setCampusName(String campusName) { this.campusName = campusName; }
    public void setDegreeCourse(String degreeCourse) { this.degreeCourse = degreeCourse; }
    public void setDegreeLevel(String degreeLevel) { this.degreeLevel = degreeLevel; }
    public void setAddress(String address) { this.address = address; }
    public void setPassword(String password) { this.password = password; }
    public void setAbout(String about) { this.about = about; }
    public void setProfileImage(String profileImage) { this.profileImage = profileImage; }

    /**
     * Deserialize a Tutor object from a CSV line (comma-separated string).
     *
     * @param line the line from file
     * @return a Tutor object or null if the line is invalid
     */
    public static Tutor fromString(String line) {
        String[] parts = line.split(",");
        if (parts.length != 13) return null;

        return new Tutor(
                parts[0], parts[1], parts[2], parts[3], parts[4],
                parts[5], parts[6], parts[7], parts[8], parts[9],
                parts[10], parts[11], parts[12]
        );
    }

    /**
     * Serialize the Tutor object to a CSV line.
     *
     * @return comma-separated string representing this tutor
     */
    @Override
    public String toString() {
        return String.join(",",
                tutorId,
                username,
                name,
                subject,
                email,
                contact,
                campusName,
                degreeCourse,
                degreeLevel,
                address,
                password,
                about,
                profileImage != null ? profileImage : ""
        );
    }
}
