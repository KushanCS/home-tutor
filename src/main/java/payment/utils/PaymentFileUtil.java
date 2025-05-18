package payment.utils;

import payment.model.Payment;

import java.io.*;
import java.util.*;

/**
 * Utility class for reading from and writing to the payment.txt file.
 * Handles storage and retrieval of Payment records.
 */
public class PaymentFileUtil {

    /**
     * Reads all payment records from the specified file.
     *
     * @param filePath The full path to the payment.txt file.
     * @return A list of Payment objects read from the file.
     */
    public static List<Payment> readPayments(String filePath) {
        List<Payment> payments = new ArrayList<>();
        File file = new File(filePath);

        // If file does not exist yet, return empty list
        if (!file.exists()) return payments;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;

            // Read each line and convert it into a Payment object
            while ((line = reader.readLine()) != null) {
                Payment payment = Payment.fromString(line);
                if (payment != null) {
                    payments.add(payment);
                }
            }
        } catch (IOException e) {
            // Print stack trace for any file reading errors
            e.printStackTrace();
        }

        return payments;
    }

    /**
     * Appends a new payment record to the end of the file.
     *
     * @param payment  The Payment object to save.
     * @param filePath The full path to the payment.txt file.
     */
    public static void savePayment(Payment payment, String filePath) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            // Write payment data in string format followed by a new line
            writer.write(payment.toString());
            writer.newLine();
        } catch (IOException e) {
            // Print stack trace for any file writing errors
            e.printStackTrace();
        }
    }

    public static void writeAllPayments(List<Payment> payments, String filePath) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (Payment p : payments) {
                writer.write(p.toString());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
