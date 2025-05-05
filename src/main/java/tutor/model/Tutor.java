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
        String[] parts = line.split(",", 13);
        return new Tutor(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5],
                parts[6], parts[7], parts[8], parts[9], parts[10], parts[11]);
    }
}
