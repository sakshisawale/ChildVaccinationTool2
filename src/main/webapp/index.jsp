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
    <div class="landing-hero">
        <svg class="icon icon-xl" viewBox="0 0 24 24"><path d="M12 21s-7-4.5-9.5-9C1 8 2 4 6 4c2 0 3.5 1.2 4 2.5C10.5 5.2 12 4 14 4c4 0 5 4 3.5 8-2.5 4.5-9.5 9-9.5 9z"></path></svg>
        <h1>Child Vaccination Tool</h1>
        <p class="tagline">Track, schedule, and manage your child's vaccinations - all in one place.</p>

        <div class="role-cards">
            <div class="role-card">
                <div class="icon-wrap">
                    <svg class="icon" viewBox="0 0 24 24"><circle cx="12" cy="8" r="4"></circle><path d="M4 21c0-4 4-6 8-6s8 2 8 6"></path></svg>
                </div>
                <h3>Parent Login</h3>
                <p>Already have an account? Sign in to manage your child's schedule.</p>
                <a class="btn" href="${pageContext.request.contextPath}/user-login.jsp" style="width:100%; justify-content:center;">
                    Login
                    <svg class="icon" viewBox="0 0 24 24"><polyline points="9 18 15 12 9 6"></polyline></svg>
                </a>
            </div>

            <div class="role-card">
                <div class="icon-wrap">
                    <svg class="icon" viewBox="0 0 24 24"><circle cx="9" cy="8" r="4"></circle><path d="M2 21c0-4 3-6 7-6s7 2 7 6"></path><line x1="18" y1="6" x2="18" y2="12"></line><line x1="15" y1="9" x2="21" y2="9"></line></svg>
                </div>
                <h3>Create Parent Account</h3>
                <p>New here? Register to start tracking your child's vaccines.</p>
                <a class="btn btn-accent" href="${pageContext.request.contextPath}/user-register.jsp" style="width:100%; justify-content:center;">
                    Get Started
                    <svg class="icon" viewBox="0 0 24 24"><polyline points="9 18 15 12 9 6"></polyline></svg>
                </a>
            </div>

            <div class="role-card">
                <div class="icon-wrap">
                    <svg class="icon" viewBox="0 0 24 24"><path d="M12 2l8 4v6c0 5-3.5 9-8 10-4.5-1-8-5-8-10V6l8-4z"></path><polyline points="9 12 11 14 15 10"></polyline></svg>
                </div>
                <h3>Admin Login</h3>
                <p>Manage vaccine records and monitor upcoming doses.</p>
                <a class="btn btn-outline" href="${pageContext.request.contextPath}/admin-login.jsp" style="width:100%; justify-content:center; background:#fff;">
                    Admin Access
                    <svg class="icon" viewBox="0 0 24 24"><polyline points="9 18 15 12 9 6"></polyline></svg>
                </a>
            </div>
        </div>
    </div>
</body>
</html>
