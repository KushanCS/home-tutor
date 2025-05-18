<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String courseId = request.getParameter("courseId");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Card Payment - MetaTutor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #5624d0;
            --secondary-color: #f7f9fa;
            --accent-color: #a435f0;
            --light-gray: #f5f5f5;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light-gray);
        }

        .payment-container {
            max-width: 500px;
            margin: 2rem auto;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        .payment-header {
            background-color: var(--primary-color);
            color: white;
            padding: 1.5rem;
            text-align: center;
        }

        .payment-body {
            padding: 2rem;
        }

        .form-label {
            font-weight: 600;
            color: #333;
        }

        .form-control {
            padding: 0.75rem;
            border-radius: 8px;
            border: 1px solid #ddd;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(86, 36, 208, 0.1);
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            padding: 0.75rem;
            font-weight: 600;
            border-radius: 8px;
        }

        .btn-primary:hover {
            background-color: #4a1fc0;
            border-color: #4a1fc0;
        }

        .back-link {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            display: inline-block;
            margin-bottom: 1rem;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .card-icons {
            display: flex;
            gap: 10px;
            margin-bottom: 1rem;
        }

        .card-icon {
            color: #999;
            font-size: 1.75rem;
        }

        /* New styles for input formatting */
        .formatted-input {
            letter-spacing: 1px;
        }

        .invalid-feedback {
            display: none;
            color: #dc3545;
            font-size: 0.875em;
        }

        .was-validated .form-control:invalid ~ .invalid-feedback,
        .form-control.is-invalid ~ .invalid-feedback {
            display: block;
        }
    </style>
</head>
<body>
<!-- [navbar remains unchanged] -->

<div class="container py-5">
    <div class="payment-container">
        <div class="payment-header">
            <h3 class="m-0"><i class="far fa-credit-card me-2"></i>Card Payment</h3>
        </div>

        <div class="payment-body">
            <a href="ChoosePaymentMethod.jsp?courseId=<%= courseId %>" class="back-link">
                <i class="fas fa-arrow-left me-1"></i>Change payment method
            </a>

            <div class="card-icons">
                <i class="fab fa-cc-visa card-icon"></i>
                <i class="fab fa-cc-mastercard card-icon"></i>
                <i class="fab fa-cc-amex card-icon"></i>
            </div>

            <form id="paymentForm" action="GeneratePaymentOtpServlet" method="post" novalidate>
                <input type="hidden" name="courseId" value="<%= courseId %>">
                <input type="hidden" name="method" value="card">

                <!-- Card Number Field -->
                <div class="mb-3">
                    <label for="cardNumber" class="form-label">Card Number</label>
                    <input type="text" class="form-control formatted-input" id="cardNumber" name="cardNumber"
                           placeholder="1234 5678 9012 3456" required
                           pattern="[\d ]{19}"
                           maxlength="19">
                    <div class="invalid-feedback">
                        Please enter a valid 16-digit card number
                    </div>
                </div>

                <!-- Card Holder Name Field -->
                <div class="mb-3">
                    <label for="cardName" class="form-label">Card Holder Name</label>
                    <input type="text" class="form-control" id="cardName" name="cardName"
                           placeholder="Name on card" required
                           pattern="[a-zA-Z ]+"
                           oninput="this.value = this.value.replace(/[^a-zA-Z ]/g, '')">
                    <div class="invalid-feedback">
                        Please enter a valid name (letters only)
                    </div>
                </div>

                <!-- Expiry Date and CVV -->
                <div class="row mb-3">
                    <div class="col">
                        <label for="expiry" class="form-label">Expiry Date</label>
                        <input type="text" class="form-control" id="expiry" name="expiry"
                               placeholder="MM/YY" required
                               pattern="\d{2}/\d{2}"
                               maxlength="5">
                        <div class="invalid-feedback">
                            Please enter expiry date in MM/YY format
                        </div>
                    </div>
                    <div class="col">
                        <label for="cvv" class="form-label">CVV</label>
                        <input type="password" class="form-control" id="cvv" name="cvv"
                               placeholder="•••" required
                               pattern="\d{3}"
                               maxlength="3">
                        <div class="form-text">3 digits on back of card</div>
                        <div class="invalid-feedback">
                            Please enter a 3-digit CVV
                        </div>
                    </div>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-lock me-2"></i>Verify with OTP
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Card Number Formatting
    document.getElementById('cardNumber').addEventListener('input', function(e) {
        // Remove all non-digit characters
        let value = this.value.replace(/\D/g, '');

        // Add space after every 4 digits
        value = value.replace(/(\d{4})(?=\d)/g, '$1 ');

        // Update the input value
        this.value = value;

        // Validate length (16 digits + 3 spaces)
        if (value.replace(/\s/g, '').length < 16) {
            this.setCustomValidity("Please enter a valid 16-digit card number");
        } else {
            this.setCustomValidity("");
        }
    });

    // Expiry Date Formatting
    document.getElementById('expiry').addEventListener('input', function(e) {
        // Remove all non-digit characters
        let value = this.value.replace(/\D/g, '');

        // Add slash after 2 digits
        if (value.length > 2) {
            value = value.substring(0, 2) + '/' + value.substring(2, 4);
        }

        // Update the input value
        this.value = value;
    });

    // CVV Validation
    document.getElementById('cvv').addEventListener('input', function(e) {
        // Remove all non-digit characters
        this.value = this.value.replace(/\D/g, '');
    });

    // Form Validation
    document.getElementById('paymentForm').addEventListener('submit', function(e) {
        if (!this.checkValidity()) {
            e.preventDefault();
            e.stopPropagation();
        }
        this.classList.add('was-validated');
    });
</script>
</body>
</html>