package course.model;

import java.util.ArrayList;
import java.util.List;

public class CourseTree {
    private CourseNode root;

    public void insert(CourseNode newNode) {
        if (root == null) {
            root = newNode;
        } else {
            CourseNode current = root;
            CourseNode parent;

            while (true) {
                parent = current;
                if (newNode.name.compareToIgnoreCase(current.name) < 0) {
                    current = current.left;
                    if (current == null) {
                        parent.left = newNode;
                        return;
                    }
                } else {
                    current = current.right;
                    if (current == null) {
                        parent.right = newNode;
                        return;
                    }
                }
            }
        }
    }

    // In-order traversal to collect all courses
    public List<Course> getCourses() {
        List<Course> courses = new ArrayList<>();
        traverseInOrderForCourses(root, courses);
        return courses;
    }

    // Helper method to perform in-order traversal
    private void traverseInOrderForCourses(CourseNode node, List<Course> courses) {
        if (node != null) {
            traverseInOrderForCourses(node.left, courses);
            // Add the course to the list
            courses.add(new Course(node.name, node.tutor, node.price, node.duration, node.description));
            traverseInOrderForCourses(node.right, courses);
        }
    }

    public CourseNode getRoot() {
        return root;
    }

    public void clear() {
        root = null;
    }
}
