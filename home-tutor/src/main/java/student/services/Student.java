package student.services;

public class Student {
    private int stdId;
    private String name;
    private String userName;
    private String email;
    private int phone;
    private String address;
    private String password;

    public Student(int phone, String address, String password) {
        this.name = name;
        this.userName = userName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.password = password;
        this.stdId = stdId;
    }

    public int getStdId() {
        return stdId;
    }

    public String getName() {
        return name;
    }

    public String getUserName() {
        return userName;
    }

    public String getEmail() {
        return email;
    }

    public int getPhone() {
        return phone;
    }

    public String getAddress() {
        return address;
    }

    public String getPassword() {
        return password;
    }

    public String toString() {
        return stdId + "," + name + "," + email; // CSV format
    }

    public static Student fromString(String line) {
        String[] data = line.split(",");
        return new Student(Integer.parseInt(data[0]), data[1], data[2]);
    }

}

