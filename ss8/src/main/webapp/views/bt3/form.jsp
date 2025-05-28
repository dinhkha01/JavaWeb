<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 28/5/2025
  Time: 12:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form:form action="/product/add" method="post" modelAttribute="product">
    <div>
        <label > nhap ten san pham</label>
        <form:input path="name"/>
    </div>
    <div>
        <label > nhap ten so luong</label>
        <form:input path="quantity"/>
    </div>
    <div>
        <label > nhap ten gia</label>
        <form:input path="price"  />
    </div>
    <input type="submit" value="Submit">
</form:form>
</body>
</html>
