<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Vaccine Log</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="_navbar.jspf" %>
<div class="container">
    <div class="card" style="max-width:560px; margin:0 auto;">
        <h2><svg class="icon" viewBox="0 0 24 24"><rect x="6" y="3" width="12" height="18" rx="2"></rect><rect x="9" y="1.5" width="6" height="3" rx="1"></rect><line x1="9" y1="10" x2="15" y2="10"></line><line x1="9" y1="14" x2="15" y2="14"></line></svg> Add Vaccine Log</h2>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error"><%= request.getAttribute("error") %></div>
        <% } %>

        <c:if test="${empty children}">
            <div class="alert alert-error">
                Please <a href="${pageContext.request.contextPath}/user/add-child">add a child</a> first before logging a vaccine.
            </div>
        </c:if>

        <c:if test="${not empty children}">
        <form id="addLogForm" method="post" action="${pageContext.request.contextPath}/user/add-vaccine-log">
            <label>Child</label>
            <select name="childId" required>
                <option value="">-- Select Child --</option>
                <c:forEach var="child" items="${children}">
                    <option value="${child.childId}">${child.childName}</option>
                </c:forEach>
            </select>

            <label>Vaccine</label>
            <select name="vaccineId" required>
                <option value="">-- Select Vaccine --</option>
                <c:forEach var="v" items="${vaccines}">
                    <option value="${v.vaccineId}">${v.vaccineName} (Dose ${v.doseNumber})</option>
                </c:forEach>
            </select>

            <label>Date Given</label>
            <input type="date" name="dateGiven" data-validate="date-not-future" required>

            <label>Notes (optional)</label>
            <textarea name="notes" rows="3" placeholder="e.g. mild fever after dose, given at City Hospital..."></textarea>

            <button type="submit" class="btn">Save Log</button>
        </form>
        </c:if>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/validate.js"></script>
<script>attachValidation('addLogForm');</script>
</body>
</html>
