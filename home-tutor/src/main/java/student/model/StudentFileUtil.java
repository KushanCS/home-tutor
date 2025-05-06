package student.model;

import student.services.Student;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class StudentFileUtil {
    private static final String FILE_NAME = "/WEB-INF/student.txt";

    // Existing methods
    public static void saveStudent(Student student, String filePath) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(student.toString());
            writer.newLine();
        }
    }

    public static List<Student> getAllStudents(String filePath) throws IOException {
        List<Student> students = new ArrayList<>();
        File file = new File(filePath);

        if (!file.exists()) {
            return students;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Student student = Student.fromString(line);
                if (student != null) {
                    students.add(student);
                }
            }
        }
        return students;
    }

    public static Student getStudentByUsername(String username, String filePath) throws IOException {
        for (Student student : getAllStudents(filePath)) {
            if (student.getUserName().equals(username)) {
                return student;
            }
        }
        return null;
    }

    // New methods for admin functionality
    public static void deleteStudent(String studentId, String filePath) throws IOException {
        List<Student> students = getAllStudents(filePath);
        List<Student> updatedStudents = new ArrayList<>();
        boolean found = false;

        for (Student student : students) {
            if (!student.getStdId().equals(studentId)) {
                updatedStudents.add(student);
            } else {
                found = true;
            }
        }

        if (!found) {
            throw new IOException("Student with ID " + studentId + " not found");
        }

        saveAllStudents(updatedStudents, filePath);
    }

    public static void updateStudent(Student updatedStudent, String filePath) throws IOException {
        List<Student> students = getAllStudents(filePath);
        boolean found = false;

        for (int i = 0; i < students.size(); i++) {
            if (students.get(i).getStdId().equals(updatedStudent.getStdId())) {
                students.set(i, updatedStudent);
                found = true;
                break;
            }
        }

        if (!found) {
            throw new IOException("Student not found for update");
        }

        saveAllStudents(students, filePath);
    }

    public static Student getStudentById(String studentId, String filePath) throws IOException {
        for (Student student : getAllStudents(filePath)) {
            if (student.getStdId().equals(studentId)) {
                return student;
            }
        }
        return null;
    }

    public static List<Student> searchStudents(String searchTerm, String filePath) throws IOException {
        List<Student> results = new ArrayList<>();
        String lowerTerm = searchTerm.toLowerCase();

        for (Student student : getAllStudents(filePath)) {
            if (student.getStdId().toLowerCase().contains(lowerTerm) ||
                    student.getName().toLowerCase().contains(lowerTerm) ||
                    student.getEmail().toLowerCase().contains(lowerTerm)) {
                results.add(student);
            }
        }

        return results;
    }

    private static void saveAllStudents(List<Student> students, String filePath) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, false))) {
            for (Student student : students) {
                writer.write(student.toString());
                writer.newLine();
            }
        }
    }

    // Kept your existing private method
    private static String getFilePath() {
        return new File(FILE_NAME).getAbsolutePath();
    }
}