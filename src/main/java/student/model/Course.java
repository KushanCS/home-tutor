package student.model;

import java.io.Serializable;

public class Course implements Serializable {
    private String stdId;
    private String name;
    private String userName;
    private String email;
    private String phone;
    private String address;
    private String password;
    private String course;
    private String dob;

    public Course() {}

    public Course(String stdId, String name, String userName, String email,
                  String phone, String address, String password,
                  String course, String dob) {
        this.stdId = stdId;
        this.name = name;
        this.userName = userName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.password = password;
        this.course = course;
        this.dob = dob;
    }

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
}
