package student.services;

import student.model.Student;
import student.utils.StudentFileUtil;

import java.util.List;
import java.util.stream.Collectors;

public class StudentService {

    private final String filePath;

    public StudentService(String filePath) {
        this.filePath = filePath;
    }

    // Add a student
    public boolean addStudent(Student student) {
        try {
            List<Student> students = getAllStudents();
            students.add(student);
            return StudentFileUtil.writeStudents(students, filePath);
        } catch (Exception e) {
            throw new RuntimeException("Failed to add student", e);
        }
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
                return true;
            }
        }
        return false;
    }

    // ✅ Debug-enhanced deletion
    public boolean deleteStudent(String stdId) {
        if (stdId == null || stdId.trim().isEmpty()) {
            System.out.println("ID is null or empty");
            return false;
        }

        List<Student> students = getAllStudents();
        System.out.println("Trying to delete student ID: " + stdId);
        for (Student s : students) {
            System.out.println("Available student ID: " + s.getStdId());
        }

        boolean removed = students.removeIf(s -> stdId.trim().equals(s.getStdId().trim()));

        if (removed) {
            System.out.println("Deleted student with ID: " + stdId);
            return StudentFileUtil.writeStudents(students, filePath);
        } else {
            System.out.println("No match found for student ID: " + stdId);
            return false;
        }
    }

    public List<Student> getAllStudents() {
        try {
            return StudentFileUtil.readStudents(filePath);
        } catch (Exception e) {
            throw new RuntimeException("Failed to load students", e);
        }
    }

    public Student getStudentById(String id) {
        if (id == null || id.trim().isEmpty()) {
            return null;
        }
        return getAllStudents().stream()
                .filter(s -> id.equals(s.getStdId()))
                .findFirst()
                .orElse(null);
    }

    public List<Student> searchStudents(String searchTerm) {
        List<Student> students = getAllStudents();

        if (searchTerm == null || searchTerm.trim().isEmpty()) {
            return students;
        }

        String lowerSearchTerm = searchTerm.toLowerCase();
        return students.stream()
                .filter(s ->
                        (s.getStdId() != null && s.getStdId().toLowerCase().contains(lowerSearchTerm)) ||
                                (s.getName() != null && s.getName().toLowerCase().contains(lowerSearchTerm)) ||
                                (s.getUserName() != null && s.getUserName().toLowerCase().contains(lowerSearchTerm)) ||
                                (s.getEmail() != null && s.getEmail().toLowerCase().contains(lowerSearchTerm)) ||
                                (s.getCourse() != null && s.getCourse().toLowerCase().contains(lowerSearchTerm)))
                .collect(Collectors.toList());
    }
}
