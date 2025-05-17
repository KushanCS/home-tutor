package course.utils;

import course.model.Course;

import java.io.*;
import java.util.*;

public class CourseFileUtil {

<<<<<<< Updated upstream
    /**
     * Save a new course to the file (append mode).
     */
=======
>>>>>>> Stashed changes
    public static void saveCourse(Course course, String filePath) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(course.toString());
            writer.newLine();
        }
    }

<<<<<<< Updated upstream
    /**
     * Get all courses created by a specific tutor.
     */
=======
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
    /**
     * Get all courses from the file regardless of tutor.
     */
=======
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
    /**
     * Update a course in the file by replacing the line with the matching courseId.
     */
=======
>>>>>>> Stashed changes
    public static void updateCourse(Course updatedCourse, String filePath) throws IOException {
        File file = new File(filePath);
        List<String> updatedLines = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Course course = Course.fromString(line);
                if (course != null && course.getCourseId().equals(updatedCourse.getCourseId())) {
<<<<<<< Updated upstream
                    updatedLines.add(updatedCourse.toString()); // Replace with updated data
                } else {
                    updatedLines.add(line); // Keep existing line
=======
                    updatedLines.add(updatedCourse.toString());
                } else {
                    updatedLines.add(line);
>>>>>>> Stashed changes
                }
            }
        }

<<<<<<< Updated upstream
        // Write all updated lines back to the file
=======
>>>>>>> Stashed changes
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (String line : updatedLines) {
                writer.write(line);
                writer.newLine();
            }
        }
    }

<<<<<<< Updated upstream
    /**
     * Delete a course from the file by removing the line with the given courseId.
     */
=======
>>>>>>> Stashed changes
    public static void deleteCourse(String courseId, String filePath) throws IOException {
        File file = new File(filePath);
        List<String> linesToKeep = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Course course = Course.fromString(line);
                if (course != null && !course.getCourseId().equals(courseId)) {
<<<<<<< Updated upstream
                    linesToKeep.add(line); // Keep all lines except the one to delete
=======
                    linesToKeep.add(line);
>>>>>>> Stashed changes
                }
            }
        }

<<<<<<< Updated upstream
        // Overwrite the file with the remaining lines
=======
>>>>>>> Stashed changes
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (String line : linesToKeep) {
                writer.write(line);
                writer.newLine();
            }
        }
    }

<<<<<<< Updated upstream
    /**
     * Generate a random unique course ID.
     * Format: C + 5-character random uppercase string
     */
=======
>>>>>>> Stashed changes
    public static String generateCourseId() {
        return "C" + UUID.randomUUID().toString().substring(0, 5).toUpperCase();
    }

<<<<<<< Updated upstream
    /**
     * Find and return a specific course by its ID.
     */
=======
>>>>>>> Stashed changes
    public static Course getCourseById(String courseId, String filePath) throws IOException {
        List<Course> courses = getAllCourses(filePath);
        for (Course course : courses) {
            if (course.getCourseId().equals(courseId)) {
                return course;
            }
        }
<<<<<<< Updated upstream
        return null; // Not found
    }

    /**
     * Reads and returns all courses from file (same as getAllCourses).
     * Kept separately in case of specialized usage.
     */
=======
        return null;
    }

>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======


>>>>>>> Stashed changes
}
