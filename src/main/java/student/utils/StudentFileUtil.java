package student.utils;

import student.model.Student;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Utility class for reading from and writing to the students.txt file.
 */
public class StudentFileUtil {

    /**
     * Reads the student records from the given file.
     *
     * @param filePath path to the students.txt file
     * @return a list of Student objects
     */
    public static List<Student> readStudents(String filePath) {
        List<Student> students = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;

            // Read each line and split by semicolon
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(";");
<<<<<<< Updated upstream

                // Expecting exactly 10 fields per line
                if (parts.length == 10) {
                    Student student = new Student(
                            parts[0], parts[1], parts[2], parts[3],
                            parts[4], parts[5], parts[6], parts[7],
                            parts[8], parts[9]
                    );
                    students.add(student);
=======
                if (parts.length == 10) {
                    students.add(new Student(parts[0], parts[1], parts[2], parts[3], parts[4],
                            parts[5], parts[6], parts[7], parts[8], parts[9]));
>>>>>>> Stashed changes
                } else {
                    // Log improperly formatted line (helpful during development)
                    System.err.println("Invalid data format in line: " + line);
                }
            }
        } catch (IOException e) {
            // Handle file read errors gracefully
            System.err.println("Error reading students: " + e.getMessage());
        }

        return students;
    }

<<<<<<< Updated upstream
    /**
     * Writes a list of students to the given file, overwriting existing content.
     *
     * @param students list of Student objects to write
     * @param filePath path to the students.txt file
     * @return true if the write was successful, false otherwise
     */
=======
    // Write the updated list of students back to the file
>>>>>>> Stashed changes
    public static boolean writeStudents(List<Student> students, String filePath) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {

            for (Student s : students) {
                // Join all fields using semicolon and write to file
                writer.write(String.join(";",
<<<<<<< Updated upstream
                        s.getStdId(),
                        s.getName(),
                        s.getUserName(),
                        s.getEmail(),
                        s.getPhone(),
                        s.getAddress(),
                        s.getPassword(),
                        s.getCourse(),
                        s.getDob(),
                        s.getProfilePicPath()
                ));
                writer.newLine(); // Add a newline after each student
=======
                        s.getStdId(), s.getName(), s.getUserName(), s.getEmail(),
                        s.getPhone(), s.getAddress(), s.getPassword(),
                        s.getCourse(), s.getDob(), s.getProfilePicPath()));
                writer.newLine();
>>>>>>> Stashed changes
            }

            return true; // Writing was successful

        } catch (IOException e) {
            // Handle file write errors
            System.err.println("Error writing students: " + e.getMessage());
            return false; // Writing failed
        }
        return false;
    }

    /**
     * Searches the file for a student by username.
     *
     * @param username the student's username
     * @param filePath path to the students.txt file
     * @return the Student object if found, or null if not found
     */
    public static Student getStudentByUsername(String username, String filePath) {
        List<Student> students = readStudents(filePath);

        return students.stream()
                .filter(s -> s.getUserName().equals(username))
                .findFirst()
                .orElse(null);
    }
}
