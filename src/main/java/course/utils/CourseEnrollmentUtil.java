// CourseEnrollmentUtil.java
package course.utils;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class CourseEnrollmentUtil {
    public static void enrollStudent(String studentId, String courseId, String filePath) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(studentId + ";" + courseId);
            writer.newLine();
        }
    }

    public static List<String> getStudentCourses(String studentId, String filePath) throws IOException {
        List<String> courses = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(";");
                if (parts.length == 2 && parts[0].equals(studentId)) {
                    courses.add(parts[1]);
                }
            }
        }
        return courses;
    }
}