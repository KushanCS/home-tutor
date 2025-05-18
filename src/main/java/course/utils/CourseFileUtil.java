package course.utils;

import course.model.Course;

import java.io.*;
import java.util.*;

/**
 * Utility class for handling file operations related to Course objects.
 * Includes saving, reading, updating, deleting, and generating course data.
 */
public class CourseFileUtil {

    /**
     * ✅ Appends a new course to the file.
     */
    public static void saveCourse(Course course, String filePath) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(course.toString());
            writer.newLine();
        }
    }

    /**
     * ✅ Returns all courses that belong to a specific tutor.
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
     * ✅ Returns all courses from the file.
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
     * ✅ Updates a specific course by replacing its line in the file.
     */
    public static void updateCourse(Course updatedCourse, String filePath) throws IOException {
        File file = new File(filePath);
        List<String> updatedLines = new ArrayList<>();

        // Read and replace the matching course line
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Course course = Course.fromString(line);
                if (course != null && course.getCourseId().equals(updatedCourse.getCourseId())) {
                    updatedLines.add(updatedCourse.toString()); // Replace
                } else {
                    updatedLines.add(line); // Keep original
                }
            }
        }

        // Write updated list back to file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (String line : updatedLines) {
                writer.write(line);
                writer.newLine();
            }
        }
    }

    /**
     * ✅ Deletes a course from the file based on its courseId.
     */
    public static void deleteCourse(String courseId, String filePath) throws IOException {
        File file = new File(filePath);
        List<String> linesToKeep = new ArrayList<>();

        // Filter out the course to be deleted
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Course course = Course.fromString(line);
                if (course != null && !course.getCourseId().equals(courseId)) {
                    linesToKeep.add(line);
                }
            }
        }

        // Overwrite the file with remaining courses
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (String line : linesToKeep) {
                writer.write(line);
                writer.newLine();
            }
        }
    }

    /**
     * ✅ Generates a random unique course ID in the format: CXXXXX
     */
    public static String generateCourseId() {
        return "C" + UUID.randomUUID().toString().substring(0, 5).toUpperCase();
    }

    /**
     * ✅ Retrieves a course by its ID.
     */
    public static Course getCourseById(String courseId, String filePath) throws IOException {
        List<Course> courses = getAllCourses(filePath);
        for (Course course : courses) {
            if (course.getCourseId().equals(courseId)) {
                return course;
            }
        }
        return null;
    }

    /**
     * ✅ Reads all courses from file — duplicate of getAllCourses.
     * Can be merged or used for semantic clarity.
     */
    public static List<Course> readCoursesFromFile(String filePath) throws IOException {
        return getAllCourses(filePath); // Delegated to avoid duplication
    }
}
