<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h3>Danh sach SV</h3>
<c:set var="count" value="0"/>
<c:forEach var="user" items="${users}">
    <div>
         <p>name: ${user.name}</p>
        <p>name: ${user.age}</p>
        <p>name: ${user.avg}</p>
    </div>
    <hr>
    <c:if test="${user.avg >= 8}">
        <c:set var="count" value="${count+1}"/>
    </c:if>
</c:forEach>

<div>
    <h3>so luong sv co diem hon 8: ${count}  </h3>
</div>



</body>
</html>
