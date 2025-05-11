<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Complete Your Purchase</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #6c63ff;
            --secondary-color: #4d44db;
            --light-bg: #f8f9fa;
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .payment-card {
            max-width: 600px;
            margin: 2rem auto;
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .payment-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 1.5rem;
            border-radius: 10px 10px 0 0;
        }

        .course-summary {
            background-color: #f9f9f9;
            border-radius: 8px;
            padding: 15px;
        }

        .btn-pay {
            background-color: var(--primary-color);
            border: none;
            padding: 10px 25px;
            width: 100%;
        }

        .btn-pay:hover {
            background-color: var(--secondary-color);
        }

        .payment-method {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .payment-method:hover {
            border-color: var(--primary-color);
        }

        .payment-method.selected {
            border-color: var(--primary-color);
            background-color: rgba(108, 99, 255, 0.05);
        }
    </style>
</head>
<body>
<div class="container py-4">
    <div class="card payment-card">
        <div class="payment-header text-center">
            <h2><i class="fas fa-lock me-2"></i>Secure Payment</h2>
        </div>

        <div class="card-body p-4">
            <!-- Course Summary -->
            <div class="course-summary mb-4">
                <h5><%= request.getParameter("name") %></h5>
                <div class="d-flex justify-content-between mt-2">
                    <span class="text-muted">Tutor:</span>
                    <span><%= request.getParameter("tutor") %></span>
                </div>
                <div class="d-flex justify-content-between">
                    <span class="text-muted">Duration:</span>
                    <span><%= request.getParameter("duration") %></span>
                </div>
                <hr>
                <div class="d-flex justify-content-between fw-bold">
                    <span>Total Amount:</span>
                    <span class="text-primary">$<%= request.getParameter("price") %></span>
                </div>
            </div>

            <!-- Payment Form -->
            <form action="process-payment" method="post">
                <h5 class="mb-3">Payment Method</h5>

                <div class="payment-method selected" onclick="selectPayment(this)">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="paymentMethod"
                               id="creditCard" value="creditCard" checked>
                        <label class="form-check-label fw-bold" for="creditCard">
                            <i class="far fa-credit-card me-2"></i>Credit/Debit Card
                        </label>
                    </div>
                    <div class="mt-3" id="cardDetails">
                        <div class="mb-3">
                            <label for="cardNumber" class="form-label">Card Number</label>
                            <input type="text" class="form-control" id="cardNumber"
                                   placeholder="1234 5678 9012 3456" required>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="expiryDate" class="form-label">Expiry Date</label>
                                <input type="text" class="form-control" id="expiryDate"
                                       placeholder="MM/YY" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="cvv" class="form-label">CVV</label>
                                <input type="text" class="form-control" id="cvv"
                                       placeholder="123" required>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="payment-method" onclick="selectPayment(this)">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="paymentMethod"
                               id="paypal" value="paypal">
                        <label class="form-check-label fw-bold" for="paypal">
                            <i class="fab fa-paypal me-2"></i>PayPal
                        </label>
                    </div>
                </div>

                <div class="payment-method" onclick="selectPayment(this)">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="paymentMethod"
                               id="bankTransfer" value="bankTransfer">
                        <label class="form-check-label fw-bold" for="bankTransfer">
                            <i class="fas fa-university me-2"></i>Bank Transfer
                        </label>
                    </div>
                </div>

                <div class="mt-4">
                    <button type="submit" class="btn btn-pay btn-primary text-white">
                        <i class="fas fa-lock me-2"></i>Pay $<%= request.getParameter("price") %>
                    </button>
                </div>

                <div class="text-center mt-3">
                    <small class="text-muted">
                        <i class="fas fa-lock me-1"></i>Your payment is securely encrypted
                    </small>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function selectPayment(element) {
        // Remove selected class from all payment methods
        document.querySelectorAll('.payment-method').forEach(el => {
            el.classList.remove('selected');
        });

        // Add selected class to clicked payment method
        element.classList.add('selected');

        // Check the corresponding radio button
        const radio = element.querySelector('input[type="radio"]');
        radio.checked = true;
    }
</script>

<script src="js/bootstrap.bundle.min.js"></script>
</body>
</html>