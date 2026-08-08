<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Something went wrong</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="landing">
        <h1>Oops!</h1>
        <p>Something went wrong. Please go back and try again.</p>
        <div class="btn-group">
            <a class="btn" href="${pageContext.request.contextPath}/index.jsp">Go Home</a>
        </div>
    </div>
</body>
</html>
