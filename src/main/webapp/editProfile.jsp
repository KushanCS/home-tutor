<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="student.model.Student" %>
<%@ page import="java.net.URLEncoder" %>
<%
  Student student = (Student) session.getAttribute("student");
  if (student == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  // Determine which picture to show
  String profilePic = student.getProfilePicPath();
  if (profilePic == null || profilePic.isEmpty()) {
    String nameEnc = URLEncoder.encode(student.getName(), "UTF-8");
    profilePic = "https://ui-avatars.com/api/?name="
            + nameEnc + "&background=random&size=150";
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title>Edit Profile</title>
  <link
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card shadow-sm">
        <div class="card-header">
          <h3>Edit Profile</h3>
        </div>
        <div class="card-body">
          <form method="post"
                action="editProfile"
                enctype="multipart/form-data">

            <!-- Profile picture preview + upload -->
            <div class="mb-4 text-center">
              <img id="preview"
                   src="<%= profilePic %>"
                   alt="Profile Picture"
                   class="img-thumbnail mb-2 rounded-circle"
                   style="max-height:150px;">
              <input type="file"
                     class="form-control"
                     name="profilePic"
                     accept="image/*"
                     onchange="previewImage(event)">
            </div>
            <script>
              function previewImage(e) {
                const img = document.getElementById('preview');
                const file = e.target.files[0];
                if (!file) return;
                const reader = new FileReader();
                reader.onload = ev => img.src = ev.target.result;
                reader.readAsDataURL(file);
              }
            </script>

            <!-- Full Name -->
            <div class="mb-3">
              <label class="form-label">Full Name</label>
              <input type="text"
                     class="form-control"
                     name="name"
                     value="<%= student.getName() %>"
                     required>
            </div>

            <!-- Username -->
            <div class="mb-3">
              <label class="form-label">Username</label>
              <input type="text"
                     class="form-control"
                     name="username"
                     value="<%= student.getUserName() %>"
                     required>
            </div>

            <!-- Email -->
            <div class="mb-3">
              <label class="form-label">Email</label>
              <input type="email"
                     class="form-control"
                     name="email"
                     value="<%= student.getEmail() %>"
                     required>
            </div>

            <!-- New Password (optional) -->
            <div class="mb-3">
              <label class="form-label">New Password</label>
              <input type="password"
                     class="form-control"
                     name="password"
                     placeholder="Leave blank to keep current">
            </div>

            <!-- Phone -->
            <div class="mb-3">
              <label class="form-label">Phone</label>
              <input type="text"
                     class="form-control"
                     name="phone"
                     value="<%= student.getPhone() %>">
            </div>

            <!-- Address -->
            <div class="mb-3">
              <label class="form-label">Address</label>
              <textarea class="form-control"
                        name="address"
                        rows="2"><%= student.getAddress() %></textarea>
            </div>

            <!-- Course -->
            <div class="mb-3">
              <label class="form-label">Course</label>
              <input type="text"
                     class="form-control"
                     name="course"
                     value="<%= student.getCourse() %>"
                     required>
            </div>

            <!-- Date of Birth -->
            <div class="mb-3">
              <label class="form-label">Date of Birth</label>
              <input type="date"
                     class="form-control"
                     name="dob"
                     value="<%= student.getDob() %>"
                     required>
            </div>

            <!-- Actions -->
            <div class="d-flex justify-content-between">
              <a href="profile.jsp" class="btn btn-secondary">Cancel</a>
              <button type="submit" class="btn btn-primary">
                Save Changes
              </button>
            </div>

          </form>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
