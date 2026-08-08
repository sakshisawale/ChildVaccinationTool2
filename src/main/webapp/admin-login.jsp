<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Child Vaccination Tool</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="auth-wrapper">
        <div class="auth-card">
            <h2>🔐 Admin Login</h2>

            <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-error">Please log in to continue.</div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error"><%= request.getAttribute("error") %></div>
            <% } %>

            <form id="adminLoginForm" method="post" action="${pageContext.request.contextPath}/admin-login">
                <label>Username</label>
                <input type="text" name="username" data-validate="required" required>

                <label>Password</label>
                <input type="password" name="password" data-validate="required" required>

                <button type="submit" class="btn" style="width:100%;">Login</button>
            </form>

            <div class="switch-link">
                <a href="${pageContext.request.contextPath}/index.jsp">&larr; Back to Home</a>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/js/validate.js"></script>
    <script>attachValidation('adminLoginForm');</script>
</body>
</html>
