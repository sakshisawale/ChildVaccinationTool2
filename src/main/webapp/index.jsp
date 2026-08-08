<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Child Vaccination Tool</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="landing">
        <h1>👶 Child Vaccination Tool</h1>
        <p>Track, schedule, and manage your child's vaccinations - all in one place.</p>
        <div class="btn-group">
            <a class="btn" href="${pageContext.request.contextPath}/user-login.jsp">Parent Login</a>
            <a class="btn" href="${pageContext.request.contextPath}/user-register.jsp">Create Parent Account</a>
            <a class="btn" href="${pageContext.request.contextPath}/admin-login.jsp">Admin Login</a>
        </div>
    </div>
</body>
</html>
