package student.model;

import java.io.Serializable;

// This class represents a student and stores all relevant profile data
public class Student implements Serializable {

    // Fields to store student details
    private String stdId;           // Unique student ID
    private String name;            // Full name
    private String userName;        // Username used for login
    private String email;           // Email address
    private String phone;           // Contact number
    private String address;         // Home address
    private String password;        // Encrypted/hashed password
    private String course;          // Course enrolled
    private String dob;             // Date of birth
    private String profilePicPath;  // Relative path to profile picture

    // Default constructor (needed for serialization and frameworks)
    public Student() {}

    // Parameterized constructor to initialize all fields
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

    // Getter and setter methods for each field

    public String getStdId() {
        return stdId;
    }

    public void setStdId(String stdId) {
        this.stdId = stdId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getProfilePicPath() {
        return profilePicPath;
    }

    public void setProfilePicPath(String profilePicPath) {
        this.profilePicPath = profilePicPath;
    }
}
