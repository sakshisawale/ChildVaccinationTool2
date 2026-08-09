<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Vaccines</title>
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
        <h2><svg class="icon" viewBox="0 0 24 24"><line x1="8" y1="6" x2="21" y2="6"></line><line x1="8" y1="12" x2="21" y2="12"></line><line x1="8" y1="18" x2="21" y2="18"></line><line x1="3" y1="6" x2="3.01" y2="6"></line><line x1="3" y1="12" x2="3.01" y2="12"></line><line x1="3" y1="18" x2="3.01" y2="18"></line></svg> All Vaccines</h2>

        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-error">${sessionScope.error}</div>
            <c:remove var="error" scope="session"/>
        </c:if>
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error"><%= request.getAttribute("error") %></div>
        <% } %>

        <a class="btn" href="${pageContext.request.contextPath}/admin/add-vaccine">+ Add New Vaccine</a>

        <table style="margin-top:18px;">
            <thead>
            <tr>
                <th>Name</th>
                <th>Description</th>
                <th>Due (days after birth)</th>
                <th>Dose #</th>
                <th>Price (₹)</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="v" items="${vaccines}">
                <tr>
                    <td>${v.vaccineName}</td>
                    <td>${v.description}</td>
                    <td>${v.recommendedAgeDays}</td>
                    <td>${v.doseNumber}</td>
                    <td>${v.price}</td>
                    <td>
                        <a class="btn btn-sm btn-danger"
                           href="${pageContext.request.contextPath}/admin/delete-vaccine?id=${v.vaccineId}"
                           onclick="return confirm('Delete this vaccine? This cannot be undone.');">
                            <svg class="icon" viewBox="0 0 24 24" style="width:14px;height:14px;"><polyline points="3 6 5 6 21 6"></polyline><path d="M8 6V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path><path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"></path></svg>
                            Delete
                        </a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty vaccines}">
                <tr><td colspan="6">No vaccines added yet.</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
