<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Children</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="_navbar.jspf" %>
<div class="container">
    <div class="card">
        <h2><svg class="icon" viewBox="0 0 24 24"><circle cx="12" cy="8" r="4"></circle><path d="M4 21c0-4 4-6 8-6s8 2 8 6"></path></svg> My Children</h2>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error"><%= request.getAttribute("error") %></div>
        <% } %>

        <a class="btn" href="${pageContext.request.contextPath}/user/add-child">+ Add Child</a>

        <table style="margin-top:18px;">
            <thead><tr><th>Name</th><th>Date of Birth</th><th>Gender</th></tr></thead>
            <tbody>
            <c:forEach var="child" items="${children}">
                <tr>
                    <td>${child.childName}</td>
                    <td>${child.dob}</td>
                    <td>${child.gender}</td>
                </tr>
            </c:forEach>
            <c:if test="${empty children}">
                <tr><td colspan="3">No children added yet.</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
