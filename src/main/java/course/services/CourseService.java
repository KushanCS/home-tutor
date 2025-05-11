package course.services;

import course.model.Course;
import course.model.CourseNode;
import course.model.CourseTree;
import course.utils.CourseFileUtil;
import javax.servlet.ServletContext;
import java.util.List;

public class CourseService {
    private static final CourseTree courseTree = new CourseTree();


    public static void addCourse(Course course) {
        CourseNode newNode = new CourseNode(course.getName(), course.getTutor(), course.getPrice(),
                course.getDuration(), course.getDescription());
        courseTree.insert(newNode);
    }
    public static CourseTree getCourseTree(){
        return courseTree;
    }
}
