package student.utils;

import student.model.Course;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class StudentFileUtil {

    // Read the students from the file
    public static List<Course> readStudents(String filePath) {
        List<Course> students = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(";");
<<<<<<< HEAD
                if (parts.length == 10) {
                    students.add(new Student(parts[0], parts[1], parts[2], parts[3], parts[4],
                            parts[5], parts[6], parts[7], parts[8], parts[9]));
=======
                if (parts.length == 9) {
                    students.add(new Course(parts[0], parts[1], parts[2], parts[3], parts[4],
                            parts[5], parts[6], parts[7], parts[8]));
>>>>>>> 6c48812fc751e9e73b7f6b4bae90494331be218a
                } else {
                    System.err.println("Invalid data format in line: " + line);
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading students: " + e.getMessage());
        }
        return students;
    }

    // Write the updated list of students back to the file
    public static void writeStudents(List<Course> students, String filePath) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (Course s : students) {
                writer.write(String.join(";",
                        s.getStdId(), s.getName(), s.getUserName(), s.getEmail(),
                        s.getPhone(), s.getAddress(), s.getPassword(),
                        s.getCourse(), s.getDob(), s.getProfilePicPath()));
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error writing students: " + e.getMessage());
        }
    }

    // Find a student by username
    public static Course getStudentByUsername(String username, String filePath) {
        List<Course> students = readStudents(filePath);
        return students.stream()
                .filter(s -> s.getUserName().equals(username))
                .findFirst()
                .orElse(null);
    }
}
