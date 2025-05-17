package course.utils;

import course.model.Course;

import java.io.*;
import java.util.*;

public class CourseFileUtil {

    /**
     * Save a new course to the file (append mode).
     */
    public static void saveCourse(Course course, String filePath) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(course.toString());
            writer.newLine();
        }
    }

    /**
     * Get all courses created by a specific tutor.
     */
    public static List<Course> getCoursesByTutor(String tutorId, String filePath) throws IOException {
        List<Course> courses = new ArrayList<>();
        File file = new File(filePath);
        if (!file.exists()) return courses;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Course course = Course.fromString(line);
                if (course != null && course.getTutorId().equals(tutorId)) {
                    courses.add(course);
                }
            }
        }
        return courses;
    }

    /**
     * Get all courses from the file regardless of tutor.
     */
    public static List<Course> getAllCourses(String filePath) throws IOException {
        List<Course> courses = new ArrayList<>();
        File file = new File(filePath);
        if (!file.exists()) return courses;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Course course = Course.fromString(line);
                if (course != null) {
                    courses.add(course);
                }
            }
        }
        return courses;
    }

    /**
     * Update a course in the file by replacing the line with the matching courseId.
     */
    public static void updateCourse(Course updatedCourse, String filePath) throws IOException {
        File file = new File(filePath);
        List<String> updatedLines = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Course course = Course.fromString(line);
                if (course != null && course.getCourseId().equals(updatedCourse.getCourseId())) {
                    updatedLines.add(updatedCourse.toString()); // Replace with updated data
                } else {
                    updatedLines.add(line); // Keep existing line
                }
            }
        }

        // Write all updated lines back to the file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (String line : updatedLines) {
                writer.write(line);
                writer.newLine();
            }
        }
    }

    /**
     * Delete a course from the file by removing the line with the given courseId.
     */
    public static void deleteCourse(String courseId, String filePath) throws IOException {
        File file = new File(filePath);
        List<String> linesToKeep = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Course course = Course.fromString(line);
                if (course != null && !course.getCourseId().equals(courseId)) {
                    linesToKeep.add(line); // Keep all lines except the one to delete
                }
            }
        }

        // Overwrite the file with the remaining lines
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (String line : linesToKeep) {
                writer.write(line);
                writer.newLine();
            }
        }
    }

    /**
     * Generate a random unique course ID.
     * Format: C + 5-character random uppercase string
     */
    public static String generateCourseId() {
        return "C" + UUID.randomUUID().toString().substring(0, 5).toUpperCase();
    }

    /**
     * Find and return a specific course by its ID.
     */
    public static Course getCourseById(String courseId, String filePath) throws IOException {
        List<Course> courses = getAllCourses(filePath);
        for (Course course : courses) {
            if (course.getCourseId().equals(courseId)) {
                return course;
            }
        }
        return null; // Not found
    }

    /**
     * Reads and returns all courses from file (same as getAllCourses).
     * Kept separately in case of specialized usage.
     */
    public static List<Course> readCoursesFromFile(String filePath) throws IOException {
        List<Course> courses = new ArrayList<>();
        File file = new File(filePath);
        if (!file.exists()) return courses;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Course course = Course.fromString(line);
                if (course != null) {
                    courses.add(course);
                }
            }
        }
        return courses;
    }
}
