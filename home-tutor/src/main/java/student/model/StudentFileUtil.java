package student.model;

import student.services.Student;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class StudentFileUtil {

    private static final String FILE_NAME = "students.txt";

    //Write Student Data to File
    public static void saveStudent(Student student) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_NAME, true))) {
            writer.write(student.toString());
            writer.newLine();
            System.out.println("Student added successfully!");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //Read All Student from File
    public static List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_NAME))) {
            String line;
            while ((line = reader.readLine()) != null) {
                students.add( Student.fromString(line));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return students;
    }

    //Search for a Student by ID
    public static Student findStudentById(int StdId){
        List<Student> students = getAllStudents();
        for (Student s: students){
            if (s.getStdId() == StdId){
                return s;
            }
        }
        return null; //Student not found
    }

}
