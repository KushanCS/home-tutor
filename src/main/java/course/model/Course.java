package course.model;

import java.io.Serializable;

public class Course implements Serializable {
    private String name;
    private String tutor;
    private double price;
    private String duration;
    private String description;

    public Course() {}

    public Course(String name, String tutor, double price, String duration, String description) {
        this.name        = name;
        this.tutor       = tutor;
        this.price       = price;
        this.duration    = duration;
        this.description = description;
    }

    // getters & setters omitted for brevity

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTutor() {
        return tutor;
    }

    public void setTutor(String tutor) {
        this.tutor = tutor;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        // this is what your CourseService splits on
        return name + "|" + tutor + "|" + price + "|" + duration + "|" + description;
    }
}
