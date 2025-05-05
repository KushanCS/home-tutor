package tutor.model;

public class Tutor {
    private String id;
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

    public Tutor(String id, String username, String name, String subject, String email,
                 String contact, String campusName, String degreeCourse, String degreeLevel,
                 String address, String password, String about) {
        this.id = id;
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
    }

    public String getId() { return id; }
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

    public String toString() {
        return String.join(",", id, username, name, subject, email, contact, campusName,
                degreeCourse, degreeLevel, address, password, about.replace(",", " "));
    }

    public static Tutor fromString(String line) {
        String[] parts = line.split(",", 12); // Exactly 12 parts
        if (parts.length < 12) return null;   // Prevents IndexOutOfBounds

        return new Tutor(
                parts[0],  // id
                parts[1],  // username
                parts[2],  // name
                parts[3],  // subject
                parts[4],  // email
                parts[5],  // contact
                parts[6],  // campus
                parts[7],  // degree course
                parts[8],  // degree level
                parts[9],  // address
                parts[10], // hashed password
                parts[11]  // about
        );
    }
}
