package tutor.util;

import tutor.model.Tutor;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class TutorFileUtil {
    public static void saveTutor(Tutor tutor, String filePath) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(tutor.toString());
            writer.newLine();
        }
    }

    public static List<Tutor> getAllTutors(String filePath) throws IOException {
        List<Tutor> tutors = new ArrayList<>();
        File file = new File(filePath);

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

    public static Tutor getTutorByUsername(String username, String filePath) throws IOException {
        for (Tutor tutor : getAllTutors(filePath)) {
            if (tutor.getUsername().equals(username)) {
                return tutor;
            }
        }
        return null;
    }
}
