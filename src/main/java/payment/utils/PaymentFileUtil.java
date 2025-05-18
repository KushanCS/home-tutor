package payment.utils;

import payment.model.Payment;

import java.io.*;
import java.util.*;

public class PaymentFileUtil {

    public static List<Payment> readPayments(String filePath) {
        List<Payment> payments = new ArrayList<>();
        File file = new File(filePath);
        if (!file.exists()) return payments;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Payment payment = Payment.fromString(line);
                if (payment != null) {
                    payments.add(payment);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return payments;
    }

    public static void savePayment(Payment payment, String filePath) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(payment.toString());
            writer.newLine();
        } catch (IOException e) {
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
