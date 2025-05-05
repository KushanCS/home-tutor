package tutor.util;

import tutor.model.Tutor;

import java.io.*;
import java.util.*;

public class FileUtil {
    public static void addTutor(Tutor tutor, String filePath) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(tutor.toString());
            writer.newLine();
        }
    }

    public static List<Tutor> getAllTutors(String filePath) throws IOException {
        List<Tutor> tutors = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                tutors.add(Tutor.fromString(line));
            }
        }
        return tutors;
    }

    public static Tutor getTutorByUsername(String username, String filePath) {
        try {
            List<Tutor> tutors = getAllTutors(filePath);
            for (Tutor tutor : tutors) {
                if (tutor.getUsername().equalsIgnoreCase(username)) {
                    return tutor;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
    public static void deleteTutor(String id, String filePath) throws IOException {
        List<Tutor> tutors = getAllTutors(filePath);
        List<Tutor> updatedTutors = new ArrayList<>();

        for (Tutor tutor : tutors) {
            if (!tutor.getId().equals(id)) {
                updatedTutors.add(tutor);
            }
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, false))) {
            for (Tutor t : updatedTutors) {
                writer.write(t.toString());
                writer.newLine();
            }
        }
    }

    public static void updateTutor(Tutor updatedTutor, String filePath) throws IOException {
        List<Tutor> tutors = getAllTutors(filePath);
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, false))) {
            for (Tutor tutor : tutors) {
                if (tutor.getId().equals(updatedTutor.getId())) {
                    writer.write(updatedTutor.toString());
                } else {
                    writer.write(tutor.toString());
                }
                writer.newLine();
            }
        }
    }
}
