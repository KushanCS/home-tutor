package tutor.model;

public class Tutor {
    private String id;
    private String name;
    private String subject;
    private String email;
    private String contact;
    private String about;

    public Tutor(String id, String name, String subject, String email, String contact, String about) {
        this.id = id;
        this.name = name;
        this.subject = subject;
        this.email = email;
        this.contact = contact;
        this.about = about;
    }

    public String getId() { return id; }
    public String getName() { return name; }
    public String getSubject() { return subject; }
    public String getEmail() { return email; }
    public String getContact() { return contact; }
    public String getAbout() { return about; }

    public void setName(String name) { this.name = name; }
    public void setSubject(String subject) { this.subject = subject; }
    public void setEmail(String email) { this.email = email; }
    public void setContact(String contact) { this.contact = contact; }
    public void setAbout(String about) { this.about = about; }

    public String toString() {
        return id + "," + name + "," + subject + "," + email + "," + contact + "," + about;
    }

    public static Tutor fromString(String line) {
        String[] parts = line.split(",", 6);
        return new Tutor(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]);
    }
}
