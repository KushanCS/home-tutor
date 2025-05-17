package student.services;

import student.model.Student;
import student.utils.StudentFileUtil;

import java.util.List;
import java.util.stream.Collectors;

// StudentService handles all student-related operations like add, update, delete, and search.
// It acts as a middle layer between controller and file utility.
public class StudentService {

    private final String filePath; // Path to the students.txt file

    // Constructor: initialize the service with file path
    public StudentService(String filePath) {
        this.filePath = filePath;
    }

    // Add a new student to the file
    public boolean addStudent(Student student) {
        try {
            List<Student> students = getAllStudents(); // Load current list
            students.add(student);                     // Add new student
            return StudentFileUtil.writeStudents(students, filePath); // Save back to file
        } catch (Exception e) {
            throw new RuntimeException("Failed to add student", e);
        }
    }

    // Get a student by their username (used during login and uniqueness check)
    public Student getStudentByUsername(String username) {
        List<Student> students = StudentFileUtil.readStudents(filePath);
        return students.stream()
                .filter(s -> s.getUserName().equals(username))
                .findFirst()
                .orElse(null);
    }

    // Update student details by matching stdId
    public boolean updateStudent(Student updatedStudent) {
        List<Student> students = StudentFileUtil.readStudents(filePath);
        for (Student student : students) {
            if (student.getStdId().equals(updatedStudent.getStdId())) {
                // Update all relevant fields
                student.setName(updatedStudent.getName());
                student.setUserName(updatedStudent.getUserName());
                student.setEmail(updatedStudent.getEmail());
                student.setPhone(updatedStudent.getPhone());
                student.setAddress(updatedStudent.getAddress());
                student.setPassword(updatedStudent.getPassword());
                student.setCourse(updatedStudent.getCourse());
                student.setDob(updatedStudent.getDob());
                // Save updated list to file
                StudentFileUtil.writeStudents(students, filePath);
                return true;
            }
        }
        return false; // Return false if student not found
    }

    // Delete a student by their unique stdId
    public boolean deleteStudent(String stdId) {
        try {
            List<Student> students = getAllStudents(); // Load current list
            boolean removed = students.removeIf(s -> stdId.equals(s.getStdId())); // Remove matching student
            if (removed) {
                return StudentFileUtil.writeStudents(students, filePath); // Save if changes were made
            }
            return false;
        } catch (Exception e) {
            throw new RuntimeException("Failed to delete student", e);
        }
    }

    // Return all students from the file
    public List<Student> getAllStudents() {
        try {
            return StudentFileUtil.readStudents(filePath);
        } catch (Exception e) {
            throw new RuntimeException("Failed to load students", e);
        }
    }

    // Find student by student ID
    public Student getStudentById(String id) {
        if (id == null || id.trim().isEmpty()) {
            return null;
        }
        return getAllStudents().stream()
                .filter(s -> id.equals(s.getStdId()))
                .findFirst()
                .orElse(null);
    }

    // Search for students by keyword (name, ID, username, email, or course)
    public List<Student> searchStudents(String searchTerm) {
        List<Student> students = getAllStudents();

        if (searchTerm == null || searchTerm.trim().isEmpty()) {
            return students; // Return all if search is empty
        }

        String lowerSearchTerm = searchTerm.toLowerCase();

        return students.stream()
                .filter(s ->
                        (s.getStdId() != null && s.getStdId().toLowerCase().contains(lowerSearchTerm)) ||
                                (s.getName() != null && s.getName().toLowerCase().contains(lowerSearchTerm)) ||
                                (s.getUserName() != null && s.getUserName().toLowerCase().contains(lowerSearchTerm)) ||
                                (s.getEmail() != null && s.getEmail().toLowerCase().contains(lowerSearchTerm)) ||
                                (s.getCourse() != null && s.getCourse().toLowerCase().contains(lowerSearchTerm))
                )
                .collect(Collectors.toList());
    }
}
