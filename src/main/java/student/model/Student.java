package student.model;

import java.io.Serializable;

// Student class represents a student entity and holds all their related data.
// Implements Serializable for easy file-based storage (e.g., writing to or reading from files).
public class Student implements Serializable {

    // ==== Fields ====
    private String stdId;           // Unique student ID (e.g., STU1234)
    private String name;            // Full name of the student
    private String userName;        // Unique username used for login
    private String email;           // Email address
    private String phone;           // Contact number
    private String address;         // Physical address
    private String password;        // Encrypted password
    private String course;          // Enrolled course or field of study
    private String dob;             // Date of birth
    private String profilePicPath;  // Path to profile picture file

    // ==== Constructors ====

    // Default constructor (needed for frameworks or file reading)
    public Student() {}

    // Parameterized constructor for initializing a student object fully
    public Student(String stdId, String name, String userName, String email,
                   String phone, String address, String password,
                   String course, String dob, String profilePicPath) {
        this.stdId = stdId;
        this.name = name;
        this.userName = userName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.password = password;
        this.course = course;
        this.dob = dob;
        this.profilePicPath = profilePicPath;
    }

    // ==== Getter and Setter Methods ====

    public String getStdId() { return stdId; }
    public void setStdId(String stdId) { this.stdId = stdId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getCourse() { return course; }
    public void setCourse(String course) { this.course = course; }

    public String getDob() { return dob; }
    public void setDob(String dob) { this.dob = dob; }

    public String getProfilePicPath() { return profilePicPath; }
    public void setProfilePicPath(String profilePicPath) { this.profilePicPath = profilePicPath; }
}
