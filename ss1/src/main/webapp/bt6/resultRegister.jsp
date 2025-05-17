<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 16/5/2025
  Time: 4:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h3>thong tin the xe</h3>
<div>
    Họ và tên: ${name} <br>
    Lớp: ${requestScope["class"]} <br>
    Loại xe: ${type} <br>
    Biển số xe: ${licensePlate}
</div>

</body>
</html>
