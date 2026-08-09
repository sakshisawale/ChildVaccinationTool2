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
<%@ include file="_navbar.jspf" %>
<div class="container">
    <div class="card">
        <h2><svg class="icon" viewBox="0 0 24 24"><line x1="8" y1="6" x2="21" y2="6"></line><line x1="8" y1="12" x2="21" y2="12"></line><line x1="8" y1="18" x2="21" y2="18"></line><line x1="3" y1="6" x2="3.01" y2="6"></line><line x1="3" y1="12" x2="3.01" y2="12"></line><line x1="3" y1="18" x2="3.01" y2="18"></line></svg> All Vaccines</h2>

        <% if (sessionScope.error != null) { %>
            <div class="alert alert-error"><%= sessionScope.error %></div>
            <% session.removeAttribute("error"); %>
        <% } %>
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
