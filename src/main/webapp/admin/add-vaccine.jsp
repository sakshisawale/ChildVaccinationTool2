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
<%@ include file="_navbar.jspf" %>
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
