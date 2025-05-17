<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Bank Payment System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }
        .payment-container {
            max-width: 500px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2c3e50;
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"], input[type="number"], select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .submit-btn {
            background-color: #3498db;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
        }
        .submit-btn:hover {
            background-color: #2980b9;
        }
        .error {
            color: red;
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="payment-container">
    <h1>Bank Payment</h1>

    <form name="paymentForm" action="processPayment.jsp" method="post" onsubmit="return validateForm()">
        <div class="form-group">
            <label for="accountNumber">Account Number:</label>
            <input type="text" id="accountNumber" name="accountNumber" required>
        </div>

        <div class="form-group">
            <label for="accountName">Account Name:</label>
            <input type="text" id="accountName" name="accountName" required>
        </div>

        <div class="form-group">
            <label for="bankName">Bank Name:</label>
            <select id="bankName" name="bankName" required>
                <option value="">Select Bank</option>
                <option value="Bank A">Bank A</option>
                <option value="Bank B">Bank B</option>
                <option value="Bank C">Bank C</option>
                <option value="Bank D">Bank D</option>
            </select>
        </div>

        <div class="form-group">
            <label for="amount">Amount (USD):</label>
            <input type="number" id="amount" name="amount" min="1" step="0.01" required>
        </div>

        <div class="form-group">
            <label for="paymentDate">Payment Date:</label>
            <input type="date" id="paymentDate" name="paymentDate" required>
        </div>

        <div class="form-group">
            <label for="description">Description:</label>
            <input type="text" id="description" name="description">
        </div>

        <div class="form-group">
            <input type="submit" value="Submit Payment" class="submit-btn">
        </div>
    </form>
</div>

<script>
    function validateForm() {
        const accountNumber = document.forms["paymentForm"]["accountNumber"].value;
        const amount = document.forms["paymentForm"]["amount"].value;

        // Simple validation for account number (must be numeric)
        if (!/^\d+$/.test(accountNumber)) {
            alert("Account number must contain only numbers");
            return false;
        }

        // Validate amount is positive
        if (parseFloat(amount) <= 0) {
            alert("Amount must be greater than 0");
            return false;
        }

        return true;
    }
</script>
</body>
</html>