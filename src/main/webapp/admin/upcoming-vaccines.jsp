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
        <h2><svg class="icon" viewBox="0 0 24 24"><rect x="3" y="5" width="18" height="16" rx="2"></rect><line x1="3" y1="10" x2="21" y2="10"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="16" y1="2" x2="16" y2="6"></line></svg> Upcoming Vaccines - Next 30 Days (All Children)</h2>

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
