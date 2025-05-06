package student.utils;

import student.model.Student;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class StudentFileUtil {

    // Read the students from the file
    public static List<Student> readStudents(String filePath) {
        List<Student> students = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(";");
                if (parts.length == 9) {
                    students.add(new Student(parts[0], parts[1], parts[2], parts[3], parts[4],
                            parts[5], parts[6], parts[7], parts[8]));
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
    public static void writeStudents(List<Student> students, String filePath) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (Student s : students) {
                writer.write(String.join(";",
                        s.getStdId(), s.getName(), s.getUserName(), s.getEmail(),
                        s.getPhone(), s.getAddress(), s.getPassword(),
                        s.getCourse(), s.getDob()));
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error writing students: " + e.getMessage());
        }
    }

    // Find a student by username
    public static Student getStudentByUsername(String username, String filePath) {
        List<Student> students = readStudents(filePath);
        return students.stream()
                .filter(s -> s.getUserName().equals(username))
                .findFirst()
                .orElse(null);
    }
}
