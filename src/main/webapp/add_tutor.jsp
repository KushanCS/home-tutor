<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Become a Tutor</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Main page styling */
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', sans-serif;
        }

        /* Navbar styling */
        .navbar {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        /* Custom purple close button */
        .btn-close-purple {
            filter: brightness(0) saturate(100%) invert(17%) sepia(94%) saturate(3124%) hue-rotate(246deg) brightness(95%) contrast(105%);
            width: 1.5rem;
            height: 1.5rem;
            font-size: 1.25rem;
        }

        /* Form container styling */
        .form-container {
            background: white;
            padding: 2rem 3rem;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            max-width: 750px;
            margin: 2rem auto;
        }

        /* Form input styling */
        .form-control, select.form-select {
            border-radius: 10px;
            padding: 0.75rem;
        }

        /* Primary button styling */
        .btn-primary {
            padding: 0.75rem;
            font-weight: 500;
            background-color: #5624d0;
            border-color: #5624d0;
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light sticky-top">
    <div class="container">
        <!-- Brand logo with icon -->
        <a class="navbar-brand" href="home-page.jsp">
            <i class="fas fa-graduation-cap me-2"></i>MetaTutor
        </a>
        <!-- Close button to return to home -->
        <div class="ms-auto">
            <a href="home-page.jsp" class="btn-close btn-close-purple" aria-label="Close"></a>
        </div>
    </div>
</nav>

<!-- Main Form Container -->
<div class="container">
    <div class="form-container">
        <h3 class="text-center mb-4">Become a Tutor</h3>

        <!-- Tutor Registration Form -->
        <form action="RegisterTutorServlet" method="post" enctype="multipart/form-data">
            <div class="row g-3">
                <!-- Personal Information -->
                <div class="col-md-6">
                    <input type="text" name="username" class="form-control" placeholder="Username" required>
                </div>
                <div class="col-md-6">
                    <input type="text" name="name" class="form-control" placeholder="Full Name" required>
                </div>

                <!-- Contact Information -->
                <div class="col-md-6">
                    <input type="text" name="subject" class="form-control" placeholder="Subject" required>
                </div>
                <div class="col-md-6">
                    <input type="email" name="email" class="form-control" placeholder="Email" required>
                </div>

                <!-- Academic Information -->
                <div class="col-md-6">
                    <input type="text" name="contact" class="form-control" placeholder="Contact Number" required>
                </div>
                <div class="col-md-6">
                    <input type="text" name="campusName" class="form-control" placeholder="University Name" required>
                </div>
                <div class="col-md-6">
                    <input type="text" name="degreeCourse" class="form-control" placeholder="Degree Course" required>
                </div>
                <div class="col-md-6">
                    <select name="degreeLevel" class="form-select" required>
                        <option value="" disabled selected>Select Degree Level</option>
                        <option value="Undergraduate">Undergraduate</option>
                        <option value="BSc">BSc</option>
                        <option value="MSc">MSc</option>
                        <option value="PhD">PhD</option>
                    </select>
                </div>

                <!-- Address Field -->
                <div class="col-12">
                    <input type="text" name="address" class="form-control" placeholder="Address" required>
                </div>

                <!-- Profile Image Upload -->
                <div class="col-12">
                    <label for="profileImage" class="form-label">Upload Profile Image</label>
                    <input type="file" name="profileImage" id="profileImage" class="form-control" accept="image/*">
                </div>

                <!-- Password Fields with Validation -->
                <div class="col-md-6">
                    <input type="password" id="password" name="password" class="form-control" placeholder="Password" required>
                    <div class="progress mt-1">
                        <div id="password-strength" class="progress-bar bg-danger" role="progressbar" style="width: 0%"></div>
                    </div>
                </div>
                <div class="col-md-6">
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Confirm Password" required>
                    <span id="match-message" class="form-text"></span>
                </div>

                <!-- About/Bio Section -->
                <div class="col-12">
                    <textarea name="about" class="form-control" rows="3" placeholder="Short Bio/About You..."></textarea>
                </div>

                <!-- Terms and Conditions Agreement -->
                <div class="col-12 form-check ms-2">
                    <input type="checkbox" class="form-check-input" id="agree" required>
                    <label class="form-check-label" for="agree">I agree to the <a href="#">Terms and Conditions</a></label>
                </div>

                <!-- Submit Button -->
                <div class="col-12">
                    <button type="submit" class="btn btn-primary w-100">Register as Tutor</button>
                </div>
            </div>
        </form>

        <!-- Login Link for Existing Tutors -->
        <div class="text-center mt-3">Already have an account? <a href="loginTutor.jsp">Sign in</a></div>
    </div>
</div>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Password Validation Script -->
<script>
    // DOM elements for password validation
    const password = document.getElementById("password");
    const confirmPassword = document.getElementById("confirmPassword");
    const matchMessage = document.getElementById("match-message");
    const strengthBar = document.getElementById("password-strength");

    // Function to update password strength indicator
    function updateStrengthBar() {
        const val = password.value;
        let strength = 0;

        // Check password criteria
        if (val.length >= 8) strength++;
        if (/[A-Z]/.test(val)) strength++;  // Has uppercase
        if (/[0-9]/.test(val)) strength++;  // Has number
        if (/[^A-Za-z0-9]/.test(val)) strength++;  // Has special character

        // Update strength bar appearance
        const widths = ["0%", "25%", "50%", "75%", "100%"];
        const colors = ["bg-danger", "bg-warning", "bg-info", "bg-primary", "bg-success"];
        strengthBar.style.width = widths[strength];
        strengthBar.className = "progress-bar " + colors[strength];
    }

    // Function to check if passwords match
    function checkMatch() {
        if (password.value && confirmPassword.value) {
            if (password.value === confirmPassword.value) {
                matchMessage.textContent = "Passwords match";
                matchMessage.className = "form-text text-success";
            } else {
                matchMessage.textContent = "Passwords do not match";
                matchMessage.className = "form-text text-danger";
            }
        } else {
            matchMessage.textContent = "";
        }
    }

    // Event listeners for real-time validation
    password.addEventListener("input", () => {
        updateStrengthBar();
        checkMatch();
    });
    confirmPassword.addEventListener("input", checkMatch);
</script>
</body>
</html>