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
        <h2>💉 All Vaccines</h2>

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
                           onclick="return confirm('Delete this vaccine? This cannot be undone.');">Delete</a>
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
