package student.model;

import student.services.Student;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class StudentFileUtil {
    private static final String FILE_NAME = "/WEB-INF/student.txt";

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


    private static String getFilePath() {
        return new File(FILE_NAME).getAbsolutePath();
    }
}