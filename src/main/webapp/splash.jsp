<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Child Vaccination Tool</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <!-- Auto-redirect to the login/register page after 10 seconds, even
         if JavaScript is disabled (meta refresh is the reliable fallback). -->
    <meta http-equiv="refresh" content="10;url=${pageContext.request.contextPath}/index.jsp">
</head>
<body>
    <div class="splash-screen">
        <div class="splash-logo">
            <svg class="icon" viewBox="0 0 24 24"><path d="M12 21s-7-4.5-9.5-9C1 8 2 4 6 4c2 0 3.5 1.2 4 2.5C10.5 5.2 12 4 14 4c4 0 5 4 3.5 8-2.5 4.5-9.5 9-9.5 9z"></path></svg>
        </div>
        <h1>Child Vaccination Tool</h1>
        <p>Track, schedule, and never miss a vaccination for your child.</p>

        <div class="splash-progress-track">
            <div class="splash-progress-bar"></div>
        </div>

        <a class="splash-skip" href="${pageContext.request.contextPath}/index.jsp">Skip &rarr;</a>
    </div>

    <script>
        // Smooth JS-based redirect (meta refresh above is the no-JS fallback).
        setTimeout(function () {
            window.location.href = "${pageContext.request.contextPath}/index.jsp";
        }, 10000);
    </script>
</body>
</html>
