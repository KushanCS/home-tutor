package admin.services;

import student.model.Student;

import java.io.Serializable;

public class Admin implements Serializable {
    private  String adminId;
    private String name;
    private String userName;
    private String email;
    private String phone;
    private String address;
    private String password;

    public Admin(String adminId, String name, String userName, String email, String phone, String address, String password) {
        this.adminId = adminId;
        this.name = name;
        this.userName = userName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.password = password;
    }

    public String getAdminId() {return adminId;}
    public void setAdminId(String adminId) {this.adminId = adminId;}

    public String getName() {return name;}
    public void setName(String name) {this.name = name;}

    public String getUserName() {return userName;}
    public void setUserName(String userName) {this.userName = userName;}

    public String getEmail() {return email;}
    public void setEmail(String email) {this.email = email;}

    public String getPhone() {return phone;}
    public void setPhone(String phone) {this.phone = phone;}

    public String getAddress() {return address;}
    public void setAddress(String address) {this.address = address;}

    public String getPassword() {return password;}
    public void setPassword(String password) {this.password = password;}

    @Override
    public String toString() {
        return String.join(",",
                adminId, name, userName, email, phone, address, password);
    }

    public static Admin fromString(String line) {
        String[] data = line.split(",");
        if (data.length == 7) {
            return new Admin(
                    data[0], data[1], data[2], data[3],
                    data[4], data[5], data[6]);
        }
        return null;
    }

}
