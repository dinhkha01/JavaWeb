<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Title</title>
</head>
<body>
<h3>Nhap thong tin san pham</h3>
<form action="bt6" method="post">
    <div>
        <label>ID</label>
        <input type="text" name="id">
    </div>
    <div>
        <label>Ten</label>
        <input type="text" name="name">
    </div>
    <div>
        <label>Gia</label>
        <input type="number" name="price">
    </div>
    <div>
        <label>So luong</label>
        <input type="number" name="quantity">
    </div>
    <div>
        <label>Mo ta</label>
        <input type="text" name="description">
    </div>
    <button type="submit">Them</button>
</form>
<table>
    <tr>
        <th>ID</th>
        <th>Ten</th>
        <th>Gia</th>
        <th>So luong</th>
        <th>Mo ta</th>
    </tr>
    <c:forEach var="p" items="${products}">
        <tr>
            <td>${p.id}</td>
            <td>${p.name}</td>
            <td>${p.price}</td>
            <td>${p.quantity}</td>
            <td>${p.description}</td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
