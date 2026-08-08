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
        <div class="auth-card">
            <h2>📝 Create Parent Account</h2>

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

                <button type="submit" class="btn" style="width:100%;">Create Account</button>
            </form>

            <div class="switch-link">
                Already have an account? <a href="${pageContext.request.contextPath}/user-login.jsp">Login here</a>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/js/validate.js"></script>
    <script>attachValidation('registerForm');</script>
</body>
</html>
