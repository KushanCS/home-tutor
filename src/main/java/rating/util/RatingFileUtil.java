package rating.util;

import rating.model.Rating;

import java.io.*;
import java.util.*;
import java.util.concurrent.locks.ReentrantLock;

public class RatingFileUtil {
    private static final ReentrantLock lock = new ReentrantLock();

    public static List<Rating> readRatings(String path) {
        lock.lock();
        try {
            List<Rating> ratings = new ArrayList<>();
            File file = new File(path);
            if (!file.exists()) return ratings;

            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    Rating r = Rating.fromString(line);
                    if (r != null) ratings.add(r);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            return ratings;
        } finally {
            lock.unlock();
        }
    }

    public static void saveRating(Rating rating, String path) {
        lock.lock();
        try {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(path, true))) {
                writer.write(rating.toString());
                writer.newLine();
            } catch (IOException e) {
                e.printStackTrace();
            }
        } finally {
            lock.unlock();
        }
    }

    public static double getAverageRating(String courseId, String path) {
        List<Rating> ratings = readRatings(path);
        return ratings.stream()
                .filter(r -> r.getCourseId().equals(courseId))
                .mapToInt(Rating::getStars)
                .average()
                .orElse(0.0);
    }

    public static int getUserRating(String username, String courseId, String path) {
        List<Rating> ratings = readRatings(path);
        return ratings.stream()
                .filter(r -> r.getUsername().equals(username) && r.getCourseId().equals(courseId))
                .mapToInt(Rating::getStars)
                .findFirst()
                .orElse(0);
    }
    public static void saveAllRatings(List<Rating> ratings, String path) {
        lock.lock();
        try {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(path))) {
                for (Rating rating : ratings) {
                    writer.write(rating.toString());
                    writer.newLine();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        } finally {
            lock.unlock();
        }
    }
}