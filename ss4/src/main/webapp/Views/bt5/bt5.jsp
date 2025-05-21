<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 21/5/2025
  Time: 3:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>  
<h1>Product Details</h1>
<form action="bt5" method="post">
    <input type="text" name="id">
    <button type="submit">search</button>
</form>
<hr>
<c:choose>
    <c:when test="${not empty product}">
        <div><strong>ID:</strong> ${product.id}</div>
        <div><strong>Tên sản phẩm:</strong> ${product.name}</div>
        <div><strong>Giá:</strong> ${product.price}</div>
    </c:when>
    <c:when test="${empty searchError && param.id != null}">
        <h3 class="not-found">Không tìm thấy sản phẩm nào</h3>
    </c:when>
</c:choose>

</body>
</html>
