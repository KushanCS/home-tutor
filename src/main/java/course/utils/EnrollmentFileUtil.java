package course.utils;

import course.model.Enrollment;

import java.io.*;
import java.util.*;

public class EnrollmentFileUtil {

    public static List<Enrollment> readEnrollments(String filePath) {
        List<Enrollment> enrollments = new ArrayList<>();
        File file = new File(filePath);
        if (!file.exists()) return enrollments;

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                Enrollment enrollment = Enrollment.fromString(line);
                if (enrollment != null) {
                    enrollments.add(enrollment);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return enrollments;
    }

    public static void saveEnrollment(Enrollment enrollment, String filePath) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath, true))) {
            bw.write(enrollment.toString());
            bw.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void writeAllEnrollments(List<Enrollment> enrollments, String filePath) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath))) {
            for (Enrollment e : enrollments) {
                bw.write(e.toString());
                bw.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void removePaidCourse(String username, String courseId, String filePath) {
        List<String> updatedLines = new ArrayList<>();
        File file = new File(filePath);
        if (!file.exists()) return;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().equalsIgnoreCase(username + "," + courseId)) {
                    updatedLines.add(line);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (String line : updatedLines) {
                writer.write(line);
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // ✅ NEW METHOD: Mark a course as unpaid
    public static void markEnrollmentUnpaid(String username, String courseId, String filePath) {
        List<Enrollment> enrollments = readEnrollments(filePath);
        for (Enrollment e : enrollments) {
            if (e.getStudentUsername().equalsIgnoreCase(username) &&
                    e.getCourseId().equalsIgnoreCase(courseId)) {
                e.setPaidStatus("No");
                break;
            }
        }
        writeAllEnrollments(enrollments, filePath);
    }
}
