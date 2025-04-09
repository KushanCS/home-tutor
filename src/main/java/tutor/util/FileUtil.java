package tutor.util;

import tutor.model.Tutor;

import java.io.*;
import java.util.*;

public class FileUtil {
    private static final String FILE_PATH = "tutors.txt";

    public static List<Tutor> readTutors() throws IOException {
        List<Tutor> tutors = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                tutors.add(Tutor.fromString(line));
            }
        }
        return tutors;
    }

    public static void addTutor(Tutor tutor) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(tutor.toString());
            writer.newLine();
        }
    }

    public static void writeTutors(List<Tutor> tutors) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Tutor t : tutors) {
                writer.write(t.toString());
                writer.newLine();
            }
        }
    }

    public static void deleteTutor(String id) throws IOException {
        List<Tutor> tutors = readTutors();
        tutors.removeIf(t -> t.getId().equals(id));
        writeTutors(tutors);
    }

    public static Tutor getTutorById(String id) throws IOException {
        for (Tutor t : readTutors()) {
            if (t.getId().equals(id)) return t;
        }
        return null;
    }

    public static void updateTutor(Tutor updatedTutor) throws IOException {
        List<Tutor> tutors = readTutors();
        for (int i = 0; i < tutors.size(); i++) {
            if (tutors.get(i).getId().equals(updatedTutor.getId())) {
                tutors.set(i, updatedTutor);
                break;
            }
        }
        writeTutors(tutors);
    }
}
