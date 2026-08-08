<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="_navbar.jspf" %>
<div class="container">
    <h2>Welcome, ${sessionScope.adminUsername}</h2>

    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error"><%= request.getAttribute("error") %></div>
    <% } %>

    <div class="grid">
        <div class="stat-box">
            <div class="number">${totalVaccines}</div>
            <div class="label">Total Vaccines in System</div>
        </div>
        <div class="stat-box">
            <div class="number">${upcomingCount}</div>
            <div class="label">Doses Due in Next 30 Days</div>
        </div>
    </div>

    <div class="card" style="margin-top:24px;">
        <h2>Quick Actions</h2>
        <div style="display:flex; gap:14px; flex-wrap:wrap;">
            <a class="btn" href="${pageContext.request.contextPath}/admin/add-vaccine">+ Add Vaccine</a>
            <a class="btn" href="${pageContext.request.contextPath}/admin/view-vaccines">View / Delete Vaccines</a>
            <a class="btn" href="${pageContext.request.contextPath}/admin/update-price">Update Vaccine Price</a>
            <a class="btn" href="${pageContext.request.contextPath}/admin/upcoming-vaccines">View Upcoming Vaccines</a>
        </div>
    </div>
</div>
</body>
</html>
