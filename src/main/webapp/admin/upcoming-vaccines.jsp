<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upcoming Vaccines (Next 30 Days)</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="_navbar.jspf" %>
<div class="container">
    <div class="card">
        <h2>📅 Upcoming Vaccines - Next 30 Days (All Children)</h2>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error"><%= request.getAttribute("error") %></div>
        <% } %>

        <table>
            <thead><tr><th>Child</th><th>Vaccine</th><th>Due Date</th><th>Status</th></tr></thead>
            <tbody>
            <c:forEach var="u" items="${upcoming}">
                <tr>
                    <td>${u.childName}</td>
                    <td>${u.vaccineName}</td>
                    <td>${u.dueDate}</td>
                    <td>
                        <c:choose>
                            <c:when test="${u.overdue}"><span class="badge badge-overdue">Overdue</span></c:when>
                            <c:otherwise><span class="badge badge-upcoming">Upcoming</span></c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty upcoming}">
                <tr><td colspan="4">No vaccines due in the next 30 days.</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
