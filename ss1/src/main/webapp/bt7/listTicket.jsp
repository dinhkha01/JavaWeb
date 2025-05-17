<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
<head>
    <title>Title</title>
</head>
<body>
<h2>Danh sách vé</h2>
<table>
    <thead>
    <tr>
        <th>Tên</th>
        <th>Lớp</th>
        <th>Loại xe</th>
        <th>Biển số xe</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="ticket" items="${tickets}">
        <tr>
            <td>${ticket.name}</td>
            <td>${ticket.classs}</td>
            <td>${ticket.type}</td>
            <td>${ticket.licensePlate}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<br>
<a href="bt7.jsp">Quay lại trang đăng ký</a>
</body>

</html>
