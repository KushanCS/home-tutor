package tutor.util;

import tutor.bst.TutorBST;
import tutor.model.Tutor;

import java.io.*;
import java.security.MessageDigest;
import java.util.*;

public class TutorFileUtil {
    private static final String FILE_PATH = "src/main/webapp/WEB-INF/tutors.txt";
    private static TutorBST tutorBST;

    // Save a new tutor and insert into BST
    public static void saveTutor(Tutor tutor) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(tutor.toString());
            writer.newLine();
        }
        getTutorBST().insert(tutor);
    }

    // Read all tutors from the file
    public static List<Tutor> getAllTutors() throws IOException {
        List<Tutor> tutors = new ArrayList<>();
        File file = new File(FILE_PATH);
        if (!file.exists()) return tutors;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Tutor tutor = Tutor.fromString(line);
                if (tutor != null) tutors.add(tutor);
            }
        }
        return tutors;
    }

    // Get the BST of tutors (lazy loaded)
    public static TutorBST getTutorBST() throws IOException {
        if (tutorBST == null) {
            tutorBST = new TutorBST();
            for (Tutor t : getAllTutors()) {
                tutorBST.insert(t);
            }
        }
        return tutorBST;
    }

    // Force reload of BST
    public static void reloadBST() throws IOException {
        tutorBST = new TutorBST();
        for (Tutor t : getAllTutors()) {
            tutorBST.insert(t);
        }
    }

    // Check if username exists
    public static boolean usernameExists(String username) throws IOException {
        return getTutorBST().search(username) != null;
    }

    // Generate unique tutor ID
    public static String generateUniqueTutorId() throws IOException {
        Set<String> ids = new HashSet<>();
        for (Tutor t : getAllTutors()) {
            ids.add(t.getTutorId());
        }

        String id;
        do {
            id = "TUT" + (int) (Math.random() * 100000);
        } while (ids.contains(id));

        return id;
    }

    // Save all tutors (used in update/reset flows)
    public static void saveAllTutors(List<Tutor> tutors) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, false))) {
            for (Tutor t : tutors) {
                writer.write(t.toString());
                writer.newLine();
            }
        }
    }

    public static boolean updatePasswordByEmail(String email, String newPassword) throws IOException {
        List<Tutor> tutors = getAllTutors();
        boolean updated = false;

        String hashedPassword = hashPassword(newPassword); // ADD THIS

        for (Tutor t : tutors) {
            if (t.getEmail().equalsIgnoreCase(email)) {
                t.setPassword(hashedPassword);  // USE HASHED
                updated = true;
                break;
            }
        }

        if (updated) {
            saveAllTutors(tutors);
            reloadBST();
        }

        return updated;
    }

    // Add this hashing method inside TutorFileUtil.java
    public static String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }


    // Used to fetch tutor by email using BST or list
    public static Tutor searchTutorByEmail(String email) throws IOException {
        return getTutorBST().searchByEmail(email);
    }

    public static Tutor getTutorByEmail(String email) throws IOException {
        for (Tutor tutor : getAllTutors()) {
            if (tutor.getEmail().equalsIgnoreCase(email)) {
                return tutor;
            }
        }
        return null;
    }

    // Optional: update profile image
    public static boolean updateTutorProfileImage(String tutorId, String fileName) throws IOException {
        List<Tutor> tutors = getAllTutors();
        boolean updated = false;

        for (Tutor t : tutors) {
            if (t.getTutorId().equalsIgnoreCase(tutorId)) {
                t.setProfileImage(fileName);
                updated = true;
                break;
            }
        }

        if (updated) {
            saveAllTutors(tutors);
            reloadBST();
        }

        return updated;
    }

    public static boolean emailExists(String email) throws IOException {
        for (Tutor tutor : getAllTutors()) {
            if (tutor.getEmail().equalsIgnoreCase(email)) {
                return true;
            }
        }
        return false;
    }

}
