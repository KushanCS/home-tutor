package admin.services;

import tutor.model.Tutor;
import tutor.util.TutorFileUtil;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

public class TutorManagement {
    private String filePath;

    public TutorManagement(String filePath) {
        this.filePath = filePath;
        TutorFileUtil.setFilePath(filePath);
    }

    public boolean addTutor(Tutor tutor) throws IOException {
        TutorFileUtil.saveTutor(tutor);
        return false;
    }

    public List<Tutor> getAllTutors() throws IOException {
        return TutorFileUtil.getAllTutors();
    }

    public static Tutor getTutorById(String id) throws IOException {
        return TutorFileUtil.getTutorBST().searchByUsernameOrId(id);
    }

    public boolean updateTutor(Tutor tutor) throws IOException {
        List<Tutor> tutors = getAllTutors();
        for (int i = 0; i < tutors.size(); i++) {
            if (tutors.get(i).getTutorId().equals(tutor.getTutorId())) {
                tutors.set(i, tutor);
                TutorFileUtil.saveAllTutors(tutors);
                TutorFileUtil.reloadBST();
                return true;
            }
        }
        return false;
    }

    public boolean deleteTutor(String tutorId) throws IOException {
        List<Tutor> tutors = getAllTutors();
        boolean removed = tutors.removeIf(t -> t.getTutorId().equals(tutorId));
        if (removed) {
            TutorFileUtil.saveAllTutors(tutors);
            TutorFileUtil.reloadBST();
        }
        return removed;
    }

    public List<Tutor> searchTutors(String searchTerm) throws IOException {
        List<Tutor> allTutors = getAllTutors();
        if (searchTerm == null || searchTerm.trim().isEmpty()) {
            return allTutors;
        }

        String lowerSearchTerm = searchTerm.toLowerCase();
        return allTutors.stream()
                .filter(t ->
                        (t.getTutorId() != null && t.getTutorId().toLowerCase().contains(lowerSearchTerm)) ||
                                (t.getName() != null && t.getName().toLowerCase().contains(lowerSearchTerm)) ||
                                (t.getEmail() != null && t.getEmail().toLowerCase().contains(lowerSearchTerm)) ||
                                (t.getSubject() != null && t.getSubject().toLowerCase().contains(lowerSearchTerm)))
                .collect(Collectors.toList());
    }
}
