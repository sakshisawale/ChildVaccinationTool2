<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vaccine Log</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="_navbar.jspf" %>
<div class="container">
    <div class="card">
        <h2><svg class="icon" viewBox="0 0 24 24"><rect x="6" y="3" width="12" height="18" rx="2"></rect><rect x="9" y="1.5" width="6" height="3" rx="1"></rect><line x1="9" y1="10" x2="15" y2="10"></line><line x1="9" y1="14" x2="15" y2="14"></line></svg> Vaccine Log (History)</h2>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error"><%= request.getAttribute("error") %></div>
        <% } %>

        <a class="btn" href="${pageContext.request.contextPath}/user/add-vaccine-log">+ Add Vaccine Log</a>

        <table style="margin-top:18px;">
            <thead><tr><th>Child</th><th>Vaccine</th><th>Date Given</th><th>Notes</th></tr></thead>
            <tbody>
            <c:forEach var="log" items="${logs}">
                <tr>
                    <td>${log.childName}</td>
                    <td>${log.vaccineName}</td>
                    <td>${log.dateGiven}</td>
                    <td>${log.notes}</td>
                </tr>
            </c:forEach>
            <c:if test="${empty logs}">
                <tr><td colspan="4">No vaccines logged yet.</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
