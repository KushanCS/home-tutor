package tutor.util;

import tutor.bst.TutorBST;
import tutor.model.Tutor;

import java.io.*;
import java.util.*;

public class TutorFileUtil {
    private static final String FILE_PATH = "src/main/webapp/WEB-INF/tutors.txt";
    private static TutorBST tutorBST;

    public static void saveTutor(Tutor tutor) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(tutor.toString());
            writer.newLine();
        }
        getTutorBST().insert(tutor);
    }

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

    public static TutorBST getTutorBST() throws IOException {
        if (tutorBST == null) {
            tutorBST = new TutorBST();
            for (Tutor t : getAllTutors()) tutorBST.insert(t);
        }
        return tutorBST;
    }

    public static boolean usernameExists(String username) throws IOException {
        for (Tutor t : getAllTutors()) {
            if (t.getUsername().equalsIgnoreCase(username)) return true;
        }
        return false;
    }

    public static String generateUniqueTutorId() throws IOException {
        Set<String> ids = new HashSet<>();
        for (Tutor t : getAllTutors()) ids.add(t.getTutorId());

        String id;
        do {
            id = "TUT" + (int)(Math.random() * 100000);
        } while (ids.contains(id));

        return id;
    }
}
