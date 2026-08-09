<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Vaccine</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="navbar">
    <div class="brand">
        <svg class="icon" viewBox="0 0 24 24"><path d="M12 21s-7-4.5-9.5-9C1 8 2 4 6 4c2 0 3.5 1.2 4 2.5C10.5 5.2 12 4 14 4c4 0 5 4 3.5 8-2.5 4.5-9.5 9-9.5 9z"></path></svg>
        Admin Panel
    </div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/admin/dashboard">
            <svg class="icon" viewBox="0 0 24 24"><rect x="3" y="3" width="7" height="7" rx="1"></rect><rect x="14" y="3" width="7" height="7" rx="1"></rect><rect x="3" y="14" width="7" height="7" rx="1"></rect><rect x="14" y="14" width="7" height="7" rx="1"></rect></svg>
            Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/admin/view-vaccines">
            <svg class="icon" viewBox="0 0 24 24"><line x1="8" y1="6" x2="21" y2="6"></line><line x1="8" y1="12" x2="21" y2="12"></line><line x1="8" y1="18" x2="21" y2="18"></line><line x1="3" y1="6" x2="3.01" y2="6"></line><line x1="3" y1="12" x2="3.01" y2="12"></line><line x1="3" y1="18" x2="3.01" y2="18"></line></svg>
            Vaccines
        </a>
        <a href="${pageContext.request.contextPath}/admin/upcoming-vaccines">
            <svg class="icon" viewBox="0 0 24 24"><rect x="3" y="5" width="18" height="16" rx="2"></rect><line x1="3" y1="10" x2="21" y2="10"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="16" y1="2" x2="16" y2="6"></line></svg>
            Upcoming (30d)
        </a>
        <a href="${pageContext.request.contextPath}/admin/change-password">
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
    <div class="card">
        <h2><svg class="icon" viewBox="0 0 24 24"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg> Add Vaccine</h2>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error"><%= request.getAttribute("error") %></div>
        <% } %>

        <form id="addVaccineForm" method="post" action="${pageContext.request.contextPath}/admin/add-vaccine">
            <label>Vaccine Name</label>
            <input type="text" name="vaccineName" data-validate="required" required>

            <label>Description</label>
            <textarea name="description" rows="3"></textarea>

            <label>Recommended Age (in days from birth)</label>
            <input type="number" name="recommendedAgeDays" min="0" data-validate="required" required>

            <label>Dose Number</label>
            <input type="number" name="doseNumber" min="1" value="1" data-validate="required" required>

            <label>Price (₹)</label>
            <input type="number" step="0.01" name="price" min="0" data-validate="required" required>

            <button type="submit" class="btn">Save Vaccine</button>
        </form>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/validate.js"></script>
<script>attachValidation('addVaccineForm');</script>
</body>
</html>
