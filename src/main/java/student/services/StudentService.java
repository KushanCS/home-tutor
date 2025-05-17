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

    public boolean addStudent(Student student) {
        try {
            List<Student> students = getAllStudents();
            students.add(student);
            return StudentFileUtil.writeStudents(students, filePath);
        } catch (Exception e) {
            throw new RuntimeException("Failed to add student", e);
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

    public boolean updateStudent(Student updatedStudent) {
        try {
            List<Student> students = getAllStudents();
            boolean found = false;

            for (int i = 0; i < students.size(); i++) {
                if (students.get(i).getStdId().equals(updatedStudent.getStdId())) {
                    students.set(i, updatedStudent);
                    found = true;
                    break;
                }
            }

            if (found) {
                return StudentFileUtil.writeStudents(students, filePath);
            }
            return false;
        } catch (Exception e) {
            throw new RuntimeException("Failed to update student", e);
        }
    }

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