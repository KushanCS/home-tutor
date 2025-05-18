package course.utils;

import course.model.Enrollment;

import java.io.*;
import java.util.*;

/**
 * Utility class for handling file operations related to Enrollment records.
 * Supports reading, saving, and overwriting enrollment entries in a file.
 */
public class EnrollmentFileUtil {

    /**
     * ✅ Reads all enrollment records from the given file path.
     * Each line is converted into an Enrollment object using fromString().
     */
    public static List<Enrollment> readEnrollments(String filePath) {
        List<Enrollment> enrollments = new ArrayList<>();
        File file = new File(filePath);

        // If file doesn't exist, return empty list
        if (!file.exists()) return enrollments;

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                Enrollment enrollment = Enrollment.fromString(line);
                if (enrollment != null) {
                    enrollments.add(enrollment); // Add valid enrollment to list
                }
            }
        } catch (IOException e) {
            e.printStackTrace(); // Log error if file reading fails
        }

        return enrollments;
    }

    /**
     * ✅ Appends a new enrollment record to the file.
     */
    public static void saveEnrollment(Enrollment enrollment, String filePath) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath, true))) {
            bw.write(enrollment.toString());
            bw.newLine(); // Add line break after each entry
        } catch (IOException e) {
            e.printStackTrace(); // Log error if file writing fails
        }
    }

    /**
     * ✅ Overwrites the entire file with a list of enrollment records.
     * Used when deleting or updating enrollments.
     */
    public static void writeAllEnrollments(List<Enrollment> enrollments, String filePath) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath))) {
            for (Enrollment e : enrollments) {
                bw.write(e.toString());
                bw.newLine(); // Each enrollment on a new line
            }
        } catch (IOException e) {
            e.printStackTrace(); // Log error if overwriting fails
        }
    }
}
