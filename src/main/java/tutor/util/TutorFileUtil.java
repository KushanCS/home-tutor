package tutor.util;

import tutor.bst.TutorBST;
import tutor.model.Tutor;

import java.io.*;
import java.security.MessageDigest;
import java.util.*;

/**
 * ✅ Utility class for managing tutor data stored in a text file.
 * Provides methods to read, write, update, and search tutor records.
 * Also manages an in-memory TutorBST for efficient search.
 */
public class TutorFileUtil {
    private static String FILE_PATH;        // ✅ Path to tutors.txt (set at runtime by servlet)
    private static TutorBST tutorBST;       // ✅ In-memory BST for quick lookup

    /**
     * ✅ Sets the path to the tutor data file.
     * Must be set before performing any file operations.
     */
    public static void setFilePath(String path) {
        FILE_PATH = path;
    }

    /**
     * ✅ Internal check to ensure file path is initialized before use.
     */
    private static void checkPath() {
        if (FILE_PATH == null) {
            throw new IllegalStateException("Tutor file path not set. Use setFilePath() first.");
        }
    }

    /**
     * ✅ Appends a new tutor to the file and updates the BST in memory.
     */
    public static void saveTutor(Tutor tutor) throws IOException {
        checkPath();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(tutor.toString());
            writer.newLine();
        }
        getTutorBST().insert(tutor); // Keep BST updated
    }

    /**
     * ✅ Loads all tutors from the file and sorts them by subject using Merge Sort.
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

        // ✅ Sort tutors by subject expertise using Merge Sort
        sortTutorsBySubject(tutors);
        return tutors;
    }

    /**
     * ✅ Returns or builds the in-memory BST of all tutors.
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
     * ✅ Rebuilds the BST by reading all tutors from file.
     */
    public static void reloadBST() throws IOException {
        checkPath();
        tutorBST = new TutorBST();
        for (Tutor t : getAllTutors()) {
            tutorBST.insert(t);
        }
    }

    /**
     * ✅ Checks whether a username already exists in BST.
     */
    public static boolean usernameExists(String username) throws IOException {
        return getTutorBST().search(username) != null;
    }

    /**
     * ✅ Checks whether an email already exists among all tutors.
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
     * ✅ Generates a new unique tutor ID in the format TUT#####.
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
     * ✅ Saves a new list of tutors to file (used after editing or deleting).
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
     * ✅ Updates a tutor's password based on their email and saves the change.
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
            reloadBST(); // Refresh BST from updated list
        }

        return updated;
    }

    /**
     * ✅ Hashes a plain password using SHA-256 for secure storage.
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
     * ✅ Finds a tutor by email using the BST.
     */
    public static Tutor searchTutorByEmail(String email) throws IOException {
        return getTutorBST().searchByEmail(email);
    }

    /**
     * ✅ Updates the profile image filename for a tutor based on ID.
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

    /**
     * ✅ Reads tutor data from a custom file path and returns sorted list.
     * This version doesn't rely on the static FILE_PATH.
     */
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
            // ✅ Always sort before returning
            sortTutorsBySubject(tutors);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return tutors;
    }

    /**
<<<<<<< Updated upstream
     * ✅ Uses Merge Sort algorithm to sort tutors alphabetically by subject.
     * Called after reading tutor list from file to ensure sorted output.
     */
    private static void sortTutorsBySubject(List<Tutor> tutors) {
        if (tutors.size() <= 1) return;

        int mid = tutors.size() / 2;
        List<Tutor> left = new ArrayList<>(tutors.subList(0, mid));
        List<Tutor> right = new ArrayList<>(tutors.subList(mid, tutors.size()));

        sortTutorsBySubject(left);   // 🔁 Recursively sort left half
        sortTutorsBySubject(right);  // 🔁 Recursively sort right half
        merge(tutors, left, right);  // 🔁 Merge both halves together
    }

    /**
     * ✅ Merge step of Merge Sort.
     * Combines two sorted lists into one based on subject comparison.
     */
    private static void merge(List<Tutor> result, List<Tutor> left, List<Tutor> right) {
        int i = 0, j = 0, k = 0;
        while (i < left.size() && j < right.size()) {
            if (left.get(i).getSubject().compareToIgnoreCase(right.get(j).getSubject()) <= 0) {
                result.set(k++, left.get(i++));
            } else {
                result.set(k++, right.get(j++));
            }
        }
        while (i < left.size()) result.set(k++, left.get(i++));
        while (j < right.size()) result.set(k++, right.get(j++));
    }
=======
     * ✅ Merge step of Merge Sort
     * Uses temporary lists L and R with a sentinel tutor (subject = "ZZZZZZZ") to simulate ∞.
     * Compares tutors by subject to merge sorted halves into the result list.
     */
    private static void merge(List<Tutor> result, List<Tutor> left, List<Tutor> right) {
        int n1 = left.size();
        int n2 = right.size();

        // Create temporary lists
        List<Tutor> L = new ArrayList<>(left);
        List<Tutor> R = new ArrayList<>(right);

        // Sentinel tutor simulates ∞ subject
        Tutor sentinel = new Tutor();
        sentinel.setSubject("ZZZZZZZ");
        L.add(sentinel);
        R.add(sentinel);

        int i = 0, j = 0;

        // Merge L and R back into result by comparing subject alphabetically
        for (int k = 0; k < result.size(); k++) {
            if (L.get(i).getSubject().compareToIgnoreCase(R.get(j).getSubject()) <= 0) {
                result.set(k, L.get(i));
                i++;
            } else {
                result.set(k, R.get(j));
                j++;
            }
        }
    }

>>>>>>> Stashed changes
}
