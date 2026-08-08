<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.StringWriter" %>
<%
    // These are set automatically by the servlet container on any
    // error/exception dispatch (see web.xml's <error-page> mappings).
    Throwable realException = (Throwable) request.getAttribute("javax.servlet.error.exception");
    if (realException == null) realException = exception; // fallback for isErrorPage dispatches
    Object statusCode = request.getAttribute("javax.servlet.error.status_code");
    Object requestUri = request.getAttribute("javax.servlet.error.request_uri");

    String stackTraceText = "";
    if (realException != null) {
        StringWriter sw = new StringWriter();
        realException.printStackTrace(new PrintWriter(sw));
        stackTraceText = sw.toString();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Something went wrong</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .debug-box {
            background: #111827;
            color: #e5e7eb;
            padding: 18px;
            border-radius: 8px;
            max-width: 900px;
            margin: 20px auto 0;
            text-align: left;
            font-family: 'Consolas', 'Courier New', monospace;
            font-size: 13px;
            overflow-x: auto;
            white-space: pre-wrap;
            word-break: break-word;
        }
        .debug-label { color: #93c5fd; font-weight: bold; }
    </style>
</head>
<body>
    <div class="landing" style="min-height: auto; padding: 50px 20px;">
        <h1>Oops!</h1>
        <p>Something went wrong on the server. The details below will tell us exactly what happened.</p>
        <div class="btn-group">
            <a class="btn" href="${pageContext.request.contextPath}/index.jsp">Go Home</a>
        </div>

        <% if (realException != null) { %>
            <div class="debug-box">
                <div><span class="debug-label">Status code:</span> <%= statusCode %></div>
                <div><span class="debug-label">Request URL:</span> <%= requestUri %></div>
                <div><span class="debug-label">Exception:</span> <%= realException.toString() %></div>
                <br>
                <div><span class="debug-label">Full stack trace:</span></div>
                <div><%= stackTraceText %></div>
            </div>
        <% } else { %>
            <div class="debug-box">
                <div><span class="debug-label">Status code:</span> <%= statusCode %></div>
                <div><span class="debug-label">Request URL:</span> <%= requestUri %></div>
                <div>No exception object was available - check the Render Logs tab around this timestamp for more detail.</div>
            </div>
        <% } %>

        <p style="margin-top:20px; font-size:13px; opacity:0.85;">
            Note: this detailed view is left on for now to help debug the deployment.
            Once everything is working, we should simplify this page back to a generic
            message so real visitors never see internal stack traces.
        </p>
    </div>
</body>
</html>
