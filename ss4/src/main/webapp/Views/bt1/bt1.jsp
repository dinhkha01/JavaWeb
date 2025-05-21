<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h3>Cac san pham</h3>
<table border="10" cellpadding="10" cellspacing="10" >
  <tr>
    <th>ID</th>
    <th>Product Name</th>
    <th>Price</th>
    <th>Description</th>
  </tr>
  <c:forEach var="p" items="${products}">
    <tr>
      <th>${p.id}</th>
      <th>${p.name}</th>
      <th>${p.price}</th>
      <th>${p.description}</th>
    </tr>
  </c:forEach>
</table>

</body>
</html>
