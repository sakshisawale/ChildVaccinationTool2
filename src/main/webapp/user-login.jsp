<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Parent Login - Child Vaccination Tool</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="auth-wrapper">
        <div class="auth-visual">
            <svg class="icon icon-xl" viewBox="0 0 24 24"><circle cx="12" cy="8" r="4"></circle><path d="M4 21c0-4 4-6 8-6s8 2 8 6"></path></svg>
            <h2>Welcome Back</h2>
            <p>Sign in to view your children's vaccination schedule and history.</p>
        </div>
        <div class="auth-form-side">
            <div class="auth-card">
                <h2>
                    <svg class="icon" viewBox="0 0 24 24"><circle cx="12" cy="8" r="4"></circle><path d="M4 21c0-4 4-6 8-6s8 2 8 6"></path></svg>
                    Parent Login
                </h2>

                <% if (request.getParameter("error") != null) { %>
                    <div class="alert alert-error">Please log in to continue.</div>
                <% } %>
                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-error"><%= request.getAttribute("error") %></div>
                <% } %>
                <% if (request.getAttribute("success") != null) { %>
                    <div class="alert alert-success"><%= request.getAttribute("success") %></div>
                <% } %>

                <form id="userLoginForm" method="post" action="${pageContext.request.contextPath}/user-login">
                    <label>Email</label>
                    <input type="email" name="email" data-validate="email" required>

                    <label>Password</label>
                    <input type="password" name="password" data-validate="required" required>

                    <button type="submit" class="btn" style="width:100%; justify-content:center;">Login</button>
                </form>

                <div class="switch-link">
                    Don't have an account? <a href="${pageContext.request.contextPath}/user-register.jsp">Register here</a><br>
                    <a href="${pageContext.request.contextPath}/index.jsp">&larr; Back to Home</a>
                </div>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/js/validate.js"></script>
    <script>attachValidation('userLoginForm');</script>
</body>
</html>
