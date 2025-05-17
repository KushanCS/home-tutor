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
<<<<<<< Updated upstream

    // Path to the tutors.txt file, set at runtime by a servlet
    private static String FILE_PATH;

    // In-memory BST cache for efficient lookup
    private static TutorBST tutorBST;

    /**
     * Sets the file path where tutor data will be saved and loaded.
     * This should be called at the beginning of each servlet.
     */
=======
    private static String FILE_PATH; // ✅ Set dynamically from JSP or servlet
    private static TutorBST tutorBST;

    // Call this at the start of each servlet/JSP
>>>>>>> Stashed changes
    public static void setFilePath(String path) {
        FILE_PATH = path;
    }

<<<<<<< Updated upstream
    /**
     * Ensures the file path is set before performing operations.
     */
=======
>>>>>>> Stashed changes
    private static void checkPath() {
        if (FILE_PATH == null) {
            throw new IllegalStateException("Tutor file path not set. Use setFilePath() first.");
        }
    }

<<<<<<< Updated upstream
    /**
     * Appends a new tutor to the file and inserts into the BST.
     */
=======
>>>>>>> Stashed changes
    public static void saveTutor(Tutor tutor) throws IOException {
        checkPath();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(tutor.toString());
            writer.newLine();
        }
        getTutorBST().insert(tutor); // Also update in-memory cache
    }

<<<<<<< Updated upstream
    /**
     * Reads and returns all tutors from the file.
     */
=======
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
    /**
     * Returns the BST containing all tutors.
     * Initializes it lazily from file if needed.
     */
=======
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
    /**
     * Rebuilds the BST from file data (used after updates).
     */
=======
>>>>>>> Stashed changes
    public static void reloadBST() throws IOException {
        checkPath();
        tutorBST = new TutorBST();
        for (Tutor t : getAllTutors()) {
            tutorBST.insert(t);
        }
    }

<<<<<<< Updated upstream
    /**
     * Checks if a username already exists.
     */
=======
>>>>>>> Stashed changes
    public static boolean usernameExists(String username) throws IOException {
        return getTutorBST().search(username) != null;
    }

<<<<<<< Updated upstream
    /**
     * Checks if an email is already registered.
     */
=======
>>>>>>> Stashed changes
    public static boolean emailExists(String email) throws IOException {
        for (Tutor tutor : getAllTutors()) {
            if (tutor.getEmail().equalsIgnoreCase(email)) {
                return true;
            }
        }
        return false;
    }

<<<<<<< Updated upstream
    /**
     * Generates a unique tutor ID not already used in the file.
     */
=======
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
    /**
     * Overwrites the entire file with the provided list of tutors.
     */
=======
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
    /**
     * Hashes a plain text password using SHA-256.
     */
=======
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
    /**
     * Searches for a tutor using email.
     */
=======
>>>>>>> Stashed changes
    public static Tutor searchTutorByEmail(String email) throws IOException {
        return getTutorBST().searchByEmail(email);
    }

<<<<<<< Updated upstream
    /**
     * Updates a tutor's profile image filename by tutor ID.
     */
=======
>>>>>>> Stashed changes
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
