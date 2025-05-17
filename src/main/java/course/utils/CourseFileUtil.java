package course.utils;

import course.model.Course;

import java.io.*;
import java.util.*;

public class CourseFileUtil {

    public static void saveCourse(Course course, String filePath) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(course.toString());
            writer.newLine();
        }
    }

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

    public static void updateCourse(Course updatedCourse, String filePath) throws IOException {
        File file = new File(filePath);
        List<String> updatedLines = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Course course = Course.fromString(line);
                if (course != null && course.getCourseId().equals(updatedCourse.getCourseId())) {
                    updatedLines.add(updatedCourse.toString());
                } else {
                    updatedLines.add(line);
                }
            }
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (String line : updatedLines) {
                writer.write(line);
                writer.newLine();
            }
        }
    }

    public static void deleteCourse(String courseId, String filePath) throws IOException {
        File file = new File(filePath);
        List<String> linesToKeep = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Course course = Course.fromString(line);
                if (course != null && !course.getCourseId().equals(courseId)) {
                    linesToKeep.add(line);
                }
            }
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (String line : linesToKeep) {
                writer.write(line);
                writer.newLine();
            }
        }
    }

    public static String generateCourseId() {
        return "C" + UUID.randomUUID().toString().substring(0, 5).toUpperCase();
    }

    public static Course getCourseById(String courseId, String filePath) throws IOException {
        List<Course> courses = getAllCourses(filePath);
        for (Course course : courses) {
            if (course.getCourseId().equals(courseId)) {
                return course;
            }
        }
        return null;
    }

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
