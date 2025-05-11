package course.model;

public class CourseNode {
    public String name;
    public String tutor;
    public double price;
    public String duration;
    public String description;

    public CourseNode left;
    public CourseNode right;

    public CourseNode(String name, String tutor, double price, String duration, String description) {
        this.name = name;
        this.tutor = tutor;
        this.price = price;
        this.duration = duration;
        this.description = description;
    }

    public void display() {
        System.out.println("Course: " + name + ", Tutor: " + tutor + ", Price: " + price +
                ", Duration: " + duration + ", Description: " + description);
    }
}
