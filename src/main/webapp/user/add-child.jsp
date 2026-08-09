<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Child</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="_navbar.jspf" %>
<div class="container">
    <div class="card" style="max-width:520px; margin:0 auto;">
        <h2><svg class="icon" viewBox="0 0 24 24"><circle cx="9" cy="8" r="4"></circle><path d="M2 21c0-4 3-6 7-6s7 2 7 6"></path><line x1="18" y1="6" x2="18" y2="12"></line><line x1="15" y1="9" x2="21" y2="9"></line></svg> Add Child Record</h2>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error"><%= request.getAttribute("error") %></div>
        <% } %>

        <form id="addChildForm" method="post" action="${pageContext.request.contextPath}/user/add-child">
            <label>Child's Name</label>
            <input type="text" name="childName" data-validate="required" required>

            <label>Date of Birth</label>
            <input type="date" name="dob" data-validate="date-not-future" required>

            <label>Gender</label>
            <select name="gender" required>
                <option value="">-- Select --</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
            </select>

            <button type="submit" class="btn">Save Child</button>
        </form>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/validate.js"></script>
<script>attachValidation('addChildForm');</script>
</body>
</html>
