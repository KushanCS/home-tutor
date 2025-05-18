package tutor.util;

import tutor.bst.TutorBST;
import tutor.model.Tutor;

import java.io.*;
import java.security.MessageDigest;
import java.util.*;

public class TutorFileUtil {
    private static String FILE_PATH; // ✅ Set dynamically from servlet
    private static TutorBST tutorBST;

    // ✅ Setter to ensure file path is initialized
    public static void setFilePath(String path) {
        FILE_PATH = path;
    }

    private static void checkPath() {
        if (FILE_PATH == null) {
            throw new IllegalStateException("Tutor file path not set. Use setFilePath() first.");
        }
    }

    public static void saveTutor(Tutor tutor) throws IOException {
        checkPath();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(tutor.toString());
            writer.newLine();
        }
        getTutorBST().insert(tutor);
    }

    public static List<Tutor> getAllTutors() throws IOException {
        checkPath();
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

    public static TutorBST getTutorBST() throws IOException {
        checkPath();
        if (tutorBST == null) {
            tutorBST = new TutorBST();
            for (Tutor t : getAllTutors()) {
                tutorBST.insert(t);
            }
        }
        return tutorBST;
    }

    public static void reloadBST() throws IOException {
        checkPath();
        tutorBST = new TutorBST();
        for (Tutor t : getAllTutors()) {
            tutorBST.insert(t);
        }
    }

    public static boolean usernameExists(String username) throws IOException {
        return getTutorBST().search(username) != null;
    }

    public static boolean emailExists(String email) throws IOException {
        for (Tutor tutor : getAllTutors()) {
            if (tutor.getEmail().equalsIgnoreCase(email)) {
                return true;
            }
        }
        return false;
    }

    public static String generateUniqueTutorId() throws IOException {
        checkPath();
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

    public static void saveAllTutors(List<Tutor> tutors) throws IOException {
        checkPath();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, false))) {
            for (Tutor t : tutors) {
                writer.write(t.toString());
                writer.newLine();
            }
        }
    }

    public static boolean updatePasswordByEmail(String email, String newPassword) throws IOException {
        checkPath();
        List<Tutor> tutors = getAllTutors();
        boolean updated = false;

        String hashedPassword = hashPassword(newPassword);
        for (Tutor t : tutors) {
            if (t.getEmail().equalsIgnoreCase(email)) {
                t.setPassword(hashedPassword);
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

    public static Tutor searchTutorByEmail(String email) throws IOException {
        return getTutorBST().searchByEmail(email);
    }

    public static boolean updateTutorProfileImage(String tutorId, String fileName) throws IOException {
        checkPath();
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

    public static List<Tutor> readTutors(String path) {
        List<Tutor> tutors = new ArrayList<>();
        File file = new File(path);
        if (!file.exists()) return tutors;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Tutor tutor = Tutor.fromString(line);
                if (tutor != null) {
                    tutors.add(tutor);
                } else {
                    System.out.println("Skipping invalid tutor line: " + line);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return tutors;
    }
}
