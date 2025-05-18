package admin.services;

import java.util.List;
import java.util.ArrayList;
import java.util.stream.Collectors;

import tutor.bst.TutorBST;
import tutor.model.Tutor;
import tutor.util.TutorFileUtil;

public class TutorManagement {
    private final String filePath;

    public TutorManagement(String filePath) {
        this.filePath = filePath;
        TutorFileUtil.setFilePath(filePath);
    }

    // ✅ Always reload fresh BST before returning list
    public List<Tutor> getAllTutors() {
        try {
            TutorFileUtil.reloadBST(); // ensures BST reflects latest file
            TutorBST bst = TutorFileUtil.getTutorBST(); // get the fresh BST
            return bst.getAllTutors();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public Tutor getTutorById(String id) {
        try {
            TutorFileUtil.reloadBST();
            TutorBST bst = TutorFileUtil.getTutorBST();
            return bst.searchByUsernameOrId(id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Tutor> searchTutors(String searchTerm) {
        return getAllTutors().stream()
                .filter(t -> t.getUsername().toLowerCase().contains(searchTerm.toLowerCase()) ||
                        t.getName().toLowerCase().contains(searchTerm.toLowerCase()) ||
                        t.getSubject().toLowerCase().contains(searchTerm.toLowerCase()))
                .collect(Collectors.toList());
    }

    public boolean deleteTutor(String id) {
        try {
            List<Tutor> tutors = TutorFileUtil.readTutors(filePath);
            boolean removed = tutors.removeIf(t -> t.getTutorId().equalsIgnoreCase(id));
            if (removed) {
                TutorFileUtil.saveAllTutors(tutors);
                TutorFileUtil.reloadBST();
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateTutor(Tutor updatedTutor) {
        try {
            List<Tutor> tutors = TutorFileUtil.readTutors(filePath);
            boolean found = false;

            for (int i = 0; i < tutors.size(); i++) {
                if (tutors.get(i).getTutorId().equalsIgnoreCase(updatedTutor.getTutorId())) {
                    tutors.set(i, updatedTutor);
                    found = true;
                    break;
                }
            }

            if (found) {
                TutorFileUtil.saveAllTutors(tutors);
                TutorFileUtil.reloadBST();
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean addTutor(Tutor tutor) {
        try {
            TutorFileUtil.saveTutor(tutor); // adds to file
            TutorFileUtil.reloadBST();      // rebuild BST from updated file
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
