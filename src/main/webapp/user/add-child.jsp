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
<div class="navbar">
    <div class="brand">
        <svg class="icon" viewBox="0 0 24 24"><path d="M12 21s-7-4.5-9.5-9C1 8 2 4 6 4c2 0 3.5 1.2 4 2.5C10.5 5.2 12 4 14 4c4 0 5 4 3.5 8-2.5 4.5-9.5 9-9.5 9z"></path></svg>
        Parent Panel
    </div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/user/dashboard">
            <svg class="icon" viewBox="0 0 24 24"><rect x="3" y="3" width="7" height="7" rx="1"></rect><rect x="14" y="3" width="7" height="7" rx="1"></rect><rect x="3" y="14" width="7" height="7" rx="1"></rect><rect x="14" y="14" width="7" height="7" rx="1"></rect></svg>
            Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/user/view-children">
            <svg class="icon" viewBox="0 0 24 24"><circle cx="12" cy="8" r="4"></circle><path d="M4 21c0-4 4-6 8-6s8 2 8 6"></path></svg>
            My Children
        </a>
        <a href="${pageContext.request.contextPath}/user/upcoming-vaccines">
            <svg class="icon" viewBox="0 0 24 24"><rect x="3" y="5" width="18" height="16" rx="2"></rect><line x1="3" y1="10" x2="21" y2="10"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="16" y1="2" x2="16" y2="6"></line></svg>
            Upcoming
        </a>
        <a href="${pageContext.request.contextPath}/user/vaccine-log">
            <svg class="icon" viewBox="0 0 24 24"><rect x="6" y="3" width="12" height="18" rx="2"></rect><rect x="9" y="1.5" width="6" height="3" rx="1"></rect><line x1="9" y1="10" x2="15" y2="10"></line><line x1="9" y1="14" x2="15" y2="14"></line></svg>
            Vaccine Log
        </a>
        <a href="${pageContext.request.contextPath}/user/change-password">
            <svg class="icon" viewBox="0 0 24 24"><circle cx="8" cy="15" r="4"></circle><line x1="10.5" y1="12.5" x2="20" y2="3"></line><line x1="16" y1="7" x2="19" y2="10"></line><line x1="13" y1="10" x2="16" y2="13"></line></svg>
            Password
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="logout-link">
            <svg class="icon" viewBox="0 0 24 24"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path><polyline points="16 17 21 12 16 7"></polyline><line x1="21" y1="12" x2="9" y2="12"></line></svg>
            Logout
        </a>
    </div>
</div>
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
