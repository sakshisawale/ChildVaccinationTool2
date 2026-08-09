<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account - Child Vaccination Tool</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="auth-wrapper">
        <div class="auth-visual">
            <svg class="icon icon-xl" viewBox="0 0 24 24"><circle cx="9" cy="8" r="4"></circle><path d="M2 21c0-4 3-6 7-6s7 2 7 6"></path><line x1="18" y1="6" x2="18" y2="12"></line><line x1="15" y1="9" x2="21" y2="9"></line></svg>
            <h2>Join Us</h2>
            <p>Create a free account to start tracking every dose your child needs, right on time.</p>
        </div>
        <div class="auth-form-side">
            <div class="auth-card">
                <h2>
                    <svg class="icon" viewBox="0 0 24 24"><circle cx="9" cy="8" r="4"></circle><path d="M2 21c0-4 3-6 7-6s7 2 7 6"></path><line x1="18" y1="6" x2="18" y2="12"></line><line x1="15" y1="9" x2="21" y2="9"></line></svg>
                    Create Parent Account
                </h2>

                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-error"><%= request.getAttribute("error") %></div>
                <% } %>

                <form id="registerForm" method="post" action="${pageContext.request.contextPath}/user-register">
                    <label>Full Name</label>
                    <input type="text" name="fullName" data-validate="required"
                           value="<%= request.getAttribute("fullName") != null ? request.getAttribute("fullName") : "" %>" required>

                    <label>Email</label>
                    <input type="email" name="email" data-validate="email"
                           value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" required>

                    <label>Phone Number</label>
                    <input type="text" name="phone" data-validate="phone" placeholder="10-digit mobile number"
                           value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>" required>

                    <label>Password</label>
                    <input type="password" name="password" data-validate="password" required>

                    <label>Confirm Password</label>
                    <input type="password" name="confirmPassword" data-validate="required" required>

                    <button type="submit" class="btn btn-accent" style="width:100%; justify-content:center;">Create Account</button>
                </form>

                <div class="switch-link">
                    Already have an account? <a href="${pageContext.request.contextPath}/user-login.jsp">Login here</a>
                </div>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/js/validate.js"></script>
    <script>attachValidation('registerForm');</script>
</body>
</html>
