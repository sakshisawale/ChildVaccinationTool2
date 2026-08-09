<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upcoming Vaccines</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="_navbar.jspf" %>
<div class="container">
    <div class="card">
        <h2><svg class="icon" viewBox="0 0 24 24"><rect x="3" y="5" width="18" height="16" rx="2"></rect><line x1="3" y1="10" x2="21" y2="10"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="16" y1="2" x2="16" y2="6"></line></svg> Upcoming Vaccines</h2>

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
                <tr><td colspan="4">No pending vaccines. All caught up! 🎉</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
