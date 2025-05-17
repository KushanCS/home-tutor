package course.utils;

import course.model.Enrollment;

import java.io.*;
import java.util.*;

public class EnrollmentFileUtil {

    /**
     * Reads all enrollment records from the given file.
     *
     * @param filePath Path to the enrollment file
     * @return List of Enrollment objects
     */
    public static List<Enrollment> readEnrollments(String filePath) {
        List<Enrollment> enrollments = new ArrayList<>();
        File file = new File(filePath);

        // If the file does not exist, return an empty list
        if (!file.exists()) return enrollments;

        // Read each line and convert it into an Enrollment object
        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                Enrollment enrollment = Enrollment.fromString(line);
                if (enrollment != null) {
                    enrollments.add(enrollment);
                }
            }
        } catch (IOException e) {
            e.printStackTrace(); // Print error if reading fails
        }

        return enrollments;
    }

    /**
     * Appends a new enrollment to the file.
     *
     * @param enrollment The enrollment to save
     * @param filePath Path to the enrollment file
     */
    public static void saveEnrollment(Enrollment enrollment, String filePath) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath, true))) {
            bw.write(enrollment.toString());  // Write the enrollment as a string
            bw.newLine();                     // Add new line after each record
        } catch (IOException e) {
            e.printStackTrace(); // Print error if writing fails
        }
    }

    /**
     * Overwrites the entire enrollment file with a new list of enrollments.
     * Typically used when updating or removing entries.
     *
     * @param enrollments List of Enrollment objects to write
     * @param filePath Path to the enrollment file
     */
    public static void writeAllEnrollments(List<Enrollment> enrollments, String filePath) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath))) {
            for (Enrollment e : enrollments) {
                bw.write(e.toString());  // Write each enrollment
                bw.newLine();            // Separate entries with a new line
            }
        } catch (IOException e) {
            e.printStackTrace(); // Print error if writing fails
        }
    }
}
