<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Parent Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="_navbar.jspf" %>
<div class="container">
    <h2>Welcome, ${sessionScope.userName}</h2>

    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error"><%= request.getAttribute("error") %></div>
    <% } %>

    <div class="grid">
        <div class="stat-box">
            <div class="number">${childCount}</div>
            <div class="label">Children Added</div>
        </div>
        <div class="stat-box">
            <div class="number">${upcomingCount}</div>
            <div class="label">Vaccines Pending</div>
        </div>
    </div>

    <div class="card" style="margin-top:24px;">
        <h2>Quick Actions</h2>
        <div style="display:flex; gap:14px; flex-wrap:wrap;">
            <a class="btn" href="${pageContext.request.contextPath}/user/add-child">+ Add Child</a>
            <a class="btn" href="${pageContext.request.contextPath}/user/view-children">View My Children</a>
            <a class="btn" href="${pageContext.request.contextPath}/user/upcoming-vaccines">Upcoming Vaccines</a>
            <a class="btn" href="${pageContext.request.contextPath}/user/add-vaccine-log">+ Add Vaccine Log</a>
        </div>
    </div>
</div>
</body>
</html>
