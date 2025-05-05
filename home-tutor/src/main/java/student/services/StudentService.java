package student.services;

import student.model.StudentFileUtil;
import java.util.List;

public class StudentService {

    private String filePath;

    public StudentService(String filePath) {
        this.filePath = filePath;
    }

    // Add a student
    public void addStudent(Student student) {
        List<Student> students = StudentFileUtil.readStudents(filePath);
        students.add(student);
        StudentFileUtil.writeStudents(students, filePath);
    }

    // Get a student by username
    public Student getStudentByUsername(String username) {
        List<Student> students = StudentFileUtil.readStudents(filePath);
        return students.stream()
                .filter(s -> s.getUserName().equals(username))
                .findFirst()
                .orElse(null);
    }

    // Update a student's details
    public boolean updateStudent(Student updatedStudent) {
        List<Student> students = StudentFileUtil.readStudents(filePath);
        for (Student student : students) {
            if (student.getStdId().equals(updatedStudent.getStdId())) {
                student.setName(updatedStudent.getName());
                student.setUserName(updatedStudent.getUserName());
                student.setEmail(updatedStudent.getEmail());
                student.setPhone(updatedStudent.getPhone());
                student.setAddress(updatedStudent.getAddress());
                student.setPassword(updatedStudent.getPassword());
                student.setCourse(updatedStudent.getCourse());
                student.setDob(updatedStudent.getDob());
                StudentFileUtil.writeStudents(students, filePath);
                return true;  // Return true after successful update
            }
        }
        return false;  // Return false if student not found
    }

    // Delete a student by stdId
    public void deleteStudent(String stdId) {
        List<Student> students = StudentFileUtil.readStudents(filePath);
        boolean removed = students.removeIf(s -> s.getStdId().equals(stdId));
        if (!removed) {
            System.out.println("No student found with ID: " + stdId);
        }
        StudentFileUtil.writeStudents(students, filePath);
    }
}
