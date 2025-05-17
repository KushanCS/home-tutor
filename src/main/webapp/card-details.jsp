<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Card Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }
        .card-container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
        }
        .card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            background-color: #f9f9f9;
            position: relative;
        }
        .card-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .card-type {
            font-weight: bold;
            color: #3498db;
        }
        .card-number {
            font-family: monospace;
            letter-spacing: 1px;
        }
        .card-details {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }
        .card-actions {
            margin-top: 15px;
            text-align: right;
        }
        .btn {
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-left: 5px;
        }
        .btn-edit {
            background-color: #f39c12;
            color: white;
        }
        .btn-delete {
            background-color: #e74c3c;
            color: white;
        }
        .btn-add {
            background-color: #2ecc71;
            color: white;
            padding: 8px 15px;
            margin-bottom: 20px;
        }
        .btn:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>
<div class="card-container">
    <h1>Manage Your Cards</h1>

    <button class="btn btn-add">+ Add New Card</button>

    <!-- Fake Card 1 -->
    <div class="card">
        <div class="card-header">
            <span class="card-type">VISA</span>
            <span class="card-number">•••• •••• •••• 4242</span>
        </div>
        <div class="card-details">
            <div>
                <div>Card Holder: JOHN DOE</div>
                <div>Expires: 12/25</div>
            </div>
            <div>
                <div>Bank: Chase</div>
                <div>CVV: •••</div>
            </div>
        </div>
        <div class="card-actions">
            <button class="btn btn-edit">Edit</button>
            <button class="btn btn-delete">Delete</button>
        </div>
    </div>

    <!-- Fake Card 2 -->
    <div class="card">
        <div class="card-header">
            <span class="card-type">MASTERCARD</span>
            <span class="card-number">•••• •••• •••• 5555</span>
        </div>
        <div class="card-details">
            <div>
                <div>Card Holder: JANE SMITH</div>
                <div>Expires: 05/24</div>
            </div>
            <div>
                <div>Bank: Bank of America</div>
                <div>CVV: •••</div>
            </div>
        </div>
        <div class="card-actions">
            <button class="btn btn-edit">Edit</button>
            <button class="btn btn-delete">Delete</button>
        </div>
    </div>

    <!-- Fake Card 3 -->
    <div class="card">
        <div class="card-header">
            <span class="card-type">AMERICAN EXPRESS</span>
            <span class="card-number">•••• •••••• 10005</span>
        </div>
        <div class="card-details">
            <div>
                <div>Card Holder: ROBERT JOHNSON</div>
                <div>Expires: 08/26</div>
            </div>
            <div>
                <div>Bank: Citibank</div>
                <div>CVV: ••••</div>
            </div>
        </div>
        <div class="card-actions">
            <button class="btn btn-edit">Edit</button>
            <button class="btn btn-delete">Delete</button>
        </div>
    </div>
</div>

<script>
    // Simple confirmation for delete action
    document.querySelectorAll('.btn-delete').forEach(button => {
        button.addEventListener('click', function() {
            if (confirm('Are you sure you want to delete this card?')) {
                // In a real application, this would make an AJAX call or form submission
                this.closest('.card').style.display = 'none';
                alert('Card deleted successfully!');
            }
        });
    });

    // Edit button action
    document.querySelectorAll('.btn-edit').forEach(button => {
        button.addEventListener('click', function() {
            // In a real application, this would open an edit form or modal
            alert('Edit functionality would open here');
        });
    });

    // Add new card button
    document.querySelector('.btn-add').addEventListener('click', function() {
        alert('Add new card form would open here');
    });
</script>
</body>
</html>