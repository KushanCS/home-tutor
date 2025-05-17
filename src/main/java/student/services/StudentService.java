package student.services;

import student.model.Student;
import student.utils.StudentFileUtil;

import java.util.List;
import java.util.stream.Collectors;

/**
 * Service class that provides business logic for managing Student data.
 * It acts as a layer between the controller (servlet) and the file utility.
 */
public class StudentService {

    private final String filePath; // Path to the file where student data is stored

    // Constructor to initialize the file path
    public StudentService(String filePath) {
        this.filePath = filePath;
    }

    /**
     * Adds a new student to the file.
     *
     * @param student the student object to add
     * @return true if added successfully, false otherwise
     */
    public boolean addStudent(Student student) {
        try {
            List<Student> students = getAllStudents();
            students.add(student);
            return StudentFileUtil.writeStudents(students, filePath);
        } catch (Exception e) {
            throw new RuntimeException("Failed to add student", e);
        }
    }

    /**
     * Retrieves a student by their username.
     *
     * @param username the student's username
     * @return Student object or null if not found
     */
    public Student getStudentByUsername(String username) {
        List<Student> students = StudentFileUtil.readStudents(filePath);
        return students.stream()
                .filter(s -> s.getUserName().equals(username))
                .findFirst()
                .orElse(null);
    }

    /**
     * Updates an existing student's details.
     *
     * @param updatedStudent the student object with updated fields
     * @return true if update was successful, false if student was not found
     */
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

    /**
     * Deletes a student by their student ID.
     *
     * @param stdId the ID of the student to delete
     * @return true if deletion was successful, false otherwise
     */
    public boolean deleteStudent(String stdId) {
        try {
            List<Student> students = getAllStudents();
            boolean removed = students.removeIf(s -> stdId.equals(s.getStdId()));
            if (removed) {
                return StudentFileUtil.writeStudents(students, filePath);
            }
            return false;
        } catch (Exception e) {
            throw new RuntimeException("Failed to delete student", e);
        }
    }

    /**
     * Retrieves all students from the file.
     *
     * @return list of all students
     */
    public List<Student> getAllStudents() {
        try {
            return StudentFileUtil.readStudents(filePath);
        } catch (Exception e) {
            throw new RuntimeException("Failed to load students", e);
        }
    }

    /**
     * Retrieves a student by their student ID.
     *
     * @param id the student ID
     * @return Student object or null if not found
     */
    public Student getStudentById(String id) {
        if (id == null || id.trim().isEmpty()) {
            return null;
        }
        return getAllStudents().stream()
                .filter(s -> id.equals(s.getStdId()))
                .findFirst()
                .orElse(null);
    }

    /**
     * Searches students based on the provided keyword.
     * It checks multiple fields (id, name, username, email, course).
     *
     * @param searchTerm the keyword to search for
     * @return list of matching students
     */
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
                                (s.getCourse() != null && s.getCourse().toLowerCase().contains(lowerSearchTerm))
                )
                .collect(Collectors.toList());
    }
}
