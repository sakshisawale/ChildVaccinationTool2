<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Vaccine Price</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="_navbar.jspf" %>
<div class="container">
    <div class="card">
        <h2><svg class="icon" viewBox="0 0 24 24"><line x1="12" y1="1" x2="12" y2="23"></line><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path></svg> Update Vaccine Price</h2>

        <% if (sessionScope.success != null) { %>
            <div class="alert alert-success"><%= sessionScope.success %></div>
            <% session.removeAttribute("success"); %>
        <% } %>
        <% if (sessionScope.error != null) { %>
            <div class="alert alert-error"><%= sessionScope.error %></div>
            <% session.removeAttribute("error"); %>
        <% } %>

        <table>
            <thead><tr><th>Vaccine</th><th>Current Price (₹)</th><th>New Price</th></tr></thead>
            <tbody>
            <c:forEach var="v" items="${vaccines}">
                <tr>
                    <form method="post" action="${pageContext.request.contextPath}/admin/update-price">
                        <td>${v.vaccineName}</td>
                        <td>₹${v.price}</td>
                        <td style="display:flex; gap:8px;">
                            <input type="hidden" name="vaccineId" value="${v.vaccineId}">
                            <input type="number" step="0.01" min="0" name="price" required style="max-width:140px;">
                            <button type="submit" class="btn btn-sm">Update</button>
                        </td>
                    </form>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
