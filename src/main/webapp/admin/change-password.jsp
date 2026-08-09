<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="_navbar.jspf" %>
<div class="container">
    <div class="card" style="max-width:480px; margin:0 auto;">
        <h2><svg class="icon" viewBox="0 0 24 24"><circle cx="8" cy="15" r="4"></circle><line x1="10.5" y1="12.5" x2="20" y2="3"></line><line x1="16" y1="7" x2="19" y2="10"></line><line x1="13" y1="10" x2="16" y2="13"></line></svg> Change Password</h2>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error"><%= request.getAttribute("error") %></div>
        <% } %>
        <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success"><%= request.getAttribute("success") %></div>
        <% } %>

        <form id="changePwForm" method="post" action="${pageContext.request.contextPath}/admin/change-password">
            <label>Current Password</label>
            <input type="password" name="currentPassword" data-validate="required" required>

            <label>New Password</label>
            <input type="password" name="newPassword" data-validate="password" required>

            <label>Confirm New Password</label>
            <input type="password" name="confirmPassword" data-validate="required" required>

            <button type="submit" class="btn">Update Password</button>
        </form>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/validate.js"></script>
<script>attachValidation('changePwForm');</script>
</body>
</html>
