package course.utils;

import course.model.Course;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import course.services.CourseService;

public class CourseFileUtil {

    public static List<Course> readCoursesFromFile(String filePath) {
        List<Course> courseList = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;

            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", -1);
                if (parts.length == 5) {
                    String name = parts[0];
                    String tutor = parts[1];
                    double price = Double.parseDouble(parts[2]);
                    String duration = parts[3];
                    String description = parts[4];

                    Course course = new Course(name, tutor, price, duration, description);
                    courseList.add(course);

                    CourseService.addCourse(course);
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

        return courseList;
    }
}
