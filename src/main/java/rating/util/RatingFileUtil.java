package rating.util;

import rating.model.Rating;

import java.io.*;
import java.util.*;
import java.util.concurrent.locks.ReentrantLock;

/**
 * Utility class for managing Rating data storage and retrieval from ratings.txt.
 * Provides thread-safe read/write operations using a ReentrantLock.
 */
public class RatingFileUtil {

    // Lock to ensure thread safety for file access
    private static final ReentrantLock lock = new ReentrantLock();

    /**
     * Reads all ratings from the specified file.
     *
     * @param path Path to ratings.txt file.
     * @return List of Rating objects.
     */
    public static List<Rating> readRatings(String path) {
        lock.lock(); // Ensure thread-safe read
        try {
            List<Rating> ratings = new ArrayList<>();
            File file = new File(path);

            // If file doesn't exist yet, return an empty list
            if (!file.exists()) return ratings;

            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;

                // Read each line and convert to Rating object
                while ((line = reader.readLine()) != null) {
                    Rating r = Rating.fromString(line);
                    if (r != null) ratings.add(r);
                }
            } catch (IOException e) {
                e.printStackTrace(); // Handle read exceptions
            }

            return ratings;
        } finally {
            lock.unlock(); // Always release the lock
        }
    }

    /**
     * Appends a new rating to the ratings file.
     *
     * @param rating Rating object to save.
     * @param path   Path to ratings.txt file.
     */
    public static void saveRating(Rating rating, String path) {
        lock.lock(); // Ensure thread-safe write
        try {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(path, true))) {
                writer.write(rating.toString()); // Convert rating to string format
                writer.newLine();
            } catch (IOException e) {
                e.printStackTrace(); // Handle write exceptions
            }
        } finally {
            lock.unlock();
        }
    }

    /**
     * Calculates the average rating for a specific course.
     *
     * @param courseId The course ID.
     * @param path     Path to ratings.txt.
     * @return Average rating value (0.0 if none found).
     */
    public static double getAverageRating(String courseId, String path) {
        List<Rating> ratings = readRatings(path);

        return ratings.stream()
                .filter(r -> r.getCourseId().equals(courseId))
                .mapToInt(Rating::getStars)
                .average()
                .orElse(0.0); // Return 0.0 if no ratings found
    }

    /**
     * Retrieves the star rating a specific user gave to a specific course.
     *
     * @param username Username of the student.
     * @param courseId Course ID.
     * @param path     Path to ratings.txt.
     * @return Star rating (0 if no rating found).
     */
    public static int getUserRating(String username, String courseId, String path) {
        List<Rating> ratings = readRatings(path);

        return ratings.stream()
                .filter(r -> r.getUsername().equals(username) && r.getCourseId().equals(courseId))
                .mapToInt(Rating::getStars)
                .findFirst()
                .orElse(0); // Return 0 if no match found
    }

    /**
     * Overwrites the ratings file with a new list of ratings.
     *
     * @param ratings List of updated Rating objects.
     * @param path    Path to ratings.txt.
     */
    public static void saveAllRatings(List<Rating> ratings, String path) {
        lock.lock(); // Ensure thread-safe write
        try {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(path))) {
                for (Rating rating : ratings) {
                    writer.write(rating.toString());
                    writer.newLine();
                }
            } catch (IOException e) {
                e.printStackTrace(); // Handle write exceptions
            }
        } finally {
            lock.unlock();
        }
    }
}
