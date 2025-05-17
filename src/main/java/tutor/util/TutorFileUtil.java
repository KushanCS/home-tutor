package tutor.util;

import tutor.bst.TutorBST;
import tutor.model.Tutor;

import java.io.*;
import java.security.MessageDigest;
import java.util.*;

/**
 * Utility class to manage Tutor data stored in a text file and backed by a Binary Search Tree (BST).
 * Handles reading, writing, updating, and searching tutor records.
 */
public class TutorFileUtil {

    // Path to the tutors.txt file, set at runtime by a servlet
    private static String FILE_PATH;

    // In-memory BST cache for efficient lookup
    private static TutorBST tutorBST;

    /**
     * Sets the file path where tutor data will be saved and loaded.
     * This should be called at the beginning of each servlet.
     */
    public static void setFilePath(String path) {
        FILE_PATH = path;
    }

    /**
     * Ensures the file path is set before performing operations.
     */
    private static void checkPath() {
        if (FILE_PATH == null) {
            throw new IllegalStateException("Tutor file path not set. Use setFilePath() first.");
        }
    }

    /**
     * Appends a new tutor to the file and inserts into the BST.
     */
    public static void saveTutor(Tutor tutor) throws IOException {
        checkPath();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(tutor.toString());
            writer.newLine();
        }
        getTutorBST().insert(tutor); // Also update in-memory cache
    }

    /**
     * Reads and returns all tutors from the file.
     */
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

    /**
     * Returns the BST containing all tutors.
     * Initializes it lazily from file if needed.
     */
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

    /**
     * Rebuilds the BST from file data (used after updates).
     */
    public static void reloadBST() throws IOException {
        checkPath();
        tutorBST = new TutorBST();
        for (Tutor t : getAllTutors()) {
            tutorBST.insert(t);
        }
    }

    /**
     * Checks if a username already exists.
     */
    public static boolean usernameExists(String username) throws IOException {
        return getTutorBST().search(username) != null;
    }

    /**
     * Checks if an email is already registered.
     */
    public static boolean emailExists(String email) throws IOException {
        for (Tutor tutor : getAllTutors()) {
            if (tutor.getEmail().equalsIgnoreCase(email)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Generates a unique tutor ID not already used in the file.
     */
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

    /**
     * Overwrites the entire file with the provided list of tutors.
     */
    public static void saveAllTutors(List<Tutor> tutors) throws IOException {
        checkPath();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, false))) {
            for (Tutor t : tutors) {
                writer.write(t.toString());
                writer.newLine();
            }
        }
    }

    /**
     * Updates a tutor's password by email (used in password reset).
     */
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

    /**
     * Hashes a plain text password using SHA-256.
     */
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

    /**
     * Searches for a tutor using email.
     */
    public static Tutor searchTutorByEmail(String email) throws IOException {
        return getTutorBST().searchByEmail(email);
    }

    /**
     * Updates a tutor's profile image filename by tutor ID.
     */
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
}
