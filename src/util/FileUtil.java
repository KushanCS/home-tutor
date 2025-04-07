package com.tutorbooking.utils;

import com.tutorbooking.models.User;

import java.io.*;
import java.util.*;

public class FileUtil {
    private static final String FILE_PATH = "users.txt";

    public static void saveUser(User user) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            bw.write(user.toFileString());
            bw.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static List<User> readUsers() {
        List<User> users = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",", 7);
                if (parts.length == 7) {
                    users.add(new User(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6]));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return users;
    }
}
