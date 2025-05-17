package student.utils;

import student.model.Student;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

// Utility class for reading and writing student data to a file.
// Handles file-based persistence (no database used).
public class StudentFileUtil {

    // ========================
    // READ students from file
    // ========================
    public static List<Student> readStudents(String filePath) {
        List<Student> students = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;

            // Read each line from the file
            while ((line = reader.readLine()) != null) {
                // Split line by semicolon (;) as delimiter
                String[] parts = line.split(";");
                if (parts.length == 10) {
                    // Create and add a new Student object
                    students.add(new Student(
                            parts[0], // stdId
                            parts[1], // name
                            parts[2], // username
                            parts[3], // email
                            parts[4], // phone
                            parts[5], // address
                            parts[6], // password
                            parts[7], // course
                            parts[8], // dob
                            parts[9]  // profilePicPath
                    ));
                } else {
                    System.err.println("Invalid data format in line: " + line);
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading students: " + e.getMessage());
        }
        return students;
    }

    // ===========================
    // WRITE students back to file
    // ===========================
    public static boolean writeStudents(List<Student> students, String filePath) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            // Write each student as a single line of semicolon-separated values
            for (Student s : students) {
                writer.write(String.join(";",
                        s.getStdId(),
                        s.getName(),
                        s.getUserName(),
                        s.getEmail(),
                        s.getPhone(),
                        s.getAddress(),
                        s.getPassword(),
                        s.getCourse(),
                        s.getDob(),
                        s.getProfilePicPath()));
                writer.newLine();
            }
            return true; // Return true if writing was successful
        } catch (IOException e) {
            System.err.println("Error writing students: " + e.getMessage());
            return false; // Return false on error
        }
    }

    // =====================================
    // SEARCH for a student by their username
    // =====================================
    public static Student getStudentByUsername(String username, String filePath) {
        List<Student> students = readStudents(filePath);
        return students.stream()
                .filter(s -> s.getUserName().equals(username))
                .findFirst()
                .orElse(null); // Return null if not found
    }
}
