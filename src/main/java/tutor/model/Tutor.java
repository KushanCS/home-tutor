package tutor.model;

public class Tutor {
    private String username;
    private String fullName;
    private String course;
    private String email;
    private String contactNumber;
    private String campusName;
    private String degreeCourse;
    private String degreeLevel;
    private String address;
    private String password;
    private String about;

    public Tutor(String username, String fullName, String course, String email, String contactNumber,
                 String campusName, String degreeCourse, String degreeLevel, String address,
                 String password, String about) {
        this.username = username;
        this.fullName = fullName;
        this.course = course;
        this.email = email;
        this.contactNumber = contactNumber;
        this.campusName = campusName;
        this.degreeCourse = degreeCourse;
        this.degreeLevel = degreeLevel;
        this.address = address;
        this.password = password;
        this.about = about;
    }

    // Convert to CSV line format
    @Override
    public String toString() {
        return username + "," + fullName + "," + course + "," + email + "," + contactNumber + "," +
                campusName + "," + degreeCourse + "," + degreeLevel + "," + address + "," +
                password + "," + about;
    }

    // Convert from CSV line format
    public static Tutor fromString(String line) {
        String[] parts = line.split(",", -1); // include empty strings
        if (parts.length < 11) return null;

        return new Tutor(
                parts[0], parts[1], parts[2], parts[3], parts[4],
                parts[5], parts[6], parts[7], parts[8], parts[9], parts[10]
        );
    }

    // Getters
    public String getUsername() { return username; }
    public String getFullName() { return fullName; }
    public String getCourse() { return course; }
    public String getEmail() { return email; }
    public String getContactNumber() { return contactNumber; }
    public String getCampusName() { return campusName; }
    public String getDegreeCourse() { return degreeCourse; }
    public String getDegreeLevel() { return degreeLevel; }
    public String getAddress() { return address; }
    public String getPassword() { return password; }
    public String getAbout() { return about; }

    // Setters
    public void setUsername(String username) { this.username = username; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public void setCourse(String course) { this.course = course; }
    public void setEmail(String email) { this.email = email; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }
    public void setCampusName(String campusName) { this.campusName = campusName; }
    public void setDegreeCourse(String degreeCourse) { this.degreeCourse = degreeCourse; }
    public void setDegreeLevel(String degreeLevel) { this.degreeLevel = degreeLevel; }
    public void setAddress(String address) { this.address = address; }
    public void setPassword(String password) { this.password = password; }
    public void setAbout(String about) { this.about = about; }
}
