package course.utils;

import course.model.CourseStatus;
import java.io.*;
import java.util.ArrayList;
import java.util.List;


public class StudentCourseUtil {

    public static List<CourseStatus> readStudentCourses(String path) {
        List<CourseStatus> courseList = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(path))) {
            String line;
            while ((line = reader.readLine()) != null) {
                CourseStatus status = CourseStatus.fromString(line);
                if (status != null) courseList.add(status);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return courseList;
    }

    public static void writeStudentCourses(String path, List<CourseStatus> list) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(path))) {
            for (CourseStatus cs : list) {
                writer.write(cs.toString());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void addCourse(String path, CourseStatus cs) {
        List<CourseStatus> list = readStudentCourses(path);
        for (CourseStatus existing : list) {
            if (existing.getUsername().equals(cs.getUsername()) &&
                    existing.getCourse().getName().equals(cs.getCourse().getName())) {
                return; // Duplicate
            }
        }
        list.add(cs);
        writeStudentCourses(path, list);
    }

    public static void removeCourse(String path, String username, String courseName) {
        List<CourseStatus> list = readStudentCourses(path);
        list.removeIf(cs ->
                cs.getUsername().equals(username) &&
                        cs.getCourse().getName().equals(courseName)
        );
        writeStudentCourses(path, list);
    }

    public static void markAsPaid(String path, String username, String courseName) {
        List<CourseStatus> list = readStudentCourses(path);
        for (CourseStatus cs : list) {
            if (cs.getUsername().equals(username) &&
                    cs.getCourse().getName().equals(courseName)) {
                cs.setPaid(true);
                break;
            }
        }
        writeStudentCourses(path, list);
    }
}
