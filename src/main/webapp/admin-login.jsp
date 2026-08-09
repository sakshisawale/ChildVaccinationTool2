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
        <div class="auth-visual">
            <svg class="icon icon-xl" viewBox="0 0 24 24"><path d="M12 2l8 4v6c0 5-3.5 9-8 10-4.5-1-8-5-8-10V6l8-4z"></path><polyline points="9 12 11 14 15 10"></polyline></svg>
            <h2>Admin Control Panel</h2>
            <p>Manage vaccines, pricing, and monitor upcoming doses across every registered child.</p>
        </div>
        <div class="auth-form-side">
            <div class="auth-card">
                <h2>
                    <svg class="icon" viewBox="0 0 24 24"><rect x="4" y="10" width="16" height="10" rx="2"></rect><path d="M8 10V7a4 4 0 0 1 8 0v3"></path></svg>
                    Admin Login
                </h2>

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

                    <button type="submit" class="btn" style="width:100%; justify-content:center;">Login</button>
                </form>

                <div class="switch-link">
                    <a href="${pageContext.request.contextPath}/index.jsp">&larr; Back to Home</a>
                </div>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/js/validate.js"></script>
    <script>attachValidation('adminLoginForm');</script>
</body>
</html>
