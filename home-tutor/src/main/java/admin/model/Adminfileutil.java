package admin.model;

import admin.services.Admin;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class Adminfileutil {
    private static final String FILE_NAME = "/WEB-INF/admin.txt";

    // Existing methods
    public static void saveAdmin(Admin admin, String filePath) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(admin.toString());
            writer.newLine();
        }
    }

    public static List<Admin> getAllAdmin(String filePath) throws IOException {
        List<Admin> admins = new ArrayList<>();
        File file = new File(filePath);

        if (!file.exists()) {
            return admins;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Admin admin = Admin.fromString(line);
                if (admin != null) {
                    admins.add(admin);
                }
            }
        }
        return admins;
    }

    public static Admin getAdminByUsername(String username, String filePath) throws IOException {
        for (Admin admin : getAllAdmin(filePath)) {
            if (admin.getUserName().equals(username)) {
                return admin;
            }
        }
        return null;
    }

    // New updateAdmin method
    public static void updateAdmin(Admin updatedAdmin, String filePath) throws IOException {
        List<Admin> admins = getAllAdmin(filePath);
        boolean found = false;

        // Find and replace the admin record
        for (int i = 0; i < admins.size(); i++) {
            if (admins.get(i).getAdminId().equals(updatedAdmin.getAdminId())) {
                admins.set(i, updatedAdmin);
                found = true;
                break;
            }
        }

        if (!found) {
            throw new IOException("Admin not found for update");
        }

        // Save all admins back to file
        saveAllAdmins(admins, filePath);
    }

    // Helper method to save all admins
    private static void saveAllAdmins(List<Admin> admins, String filePath) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, false))) {
            for (Admin admin : admins) {
                writer.write(admin.toString());
                writer.newLine();
            }
        }
    }

    // Existing private method
    private static String getFilePath() {
        return new File(FILE_NAME).getAbsolutePath();
    }
}