<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: dinhk
  Date: 6/5/2025
  Time: 8:33 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Title</title>
</head>
<body>
<h3>dang nhap</h3>
<form:form modelAttribute="user" method="post" action="/login">
    <div>
        <label for="username">Username:</label>
        <form:input path="username" id="username"  />
        <form:errors path="username" cssClass="text-danger" />
    </div>
    <div>
        <label for="password">Password:</label>
        <form:password path="password" id="password" />
        <form:errors path="password" cssClass="text-danger" />
    </div>
    <div>
        <button type="submit">Login</button>
    </div>
</form:form>

</body>
</html>
