<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 16/5/2025
  Time: 4:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="bt6" method="post">
    <label for="name">Nhập tên</label>
    <input type="text" name="name" id="name">
    <label for="class">Nhập lớp</label>
    <input type="text" name="class" id="class">
    <select name="type" id="type">
        <option value="">--Trống--</option>
        <option value="Xe máy">Xe máy</option>
        <option value="Xe đạp">Xe đạp</option>
    </select>
    <label for="licensePlate">Nhập biển số xe</label>
    <input type="text" name="licensePlate" id="licensePlate">
    <input type="submit" value="gửi">
</form>
</body>
</html>
