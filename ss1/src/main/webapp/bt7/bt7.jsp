<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 16/5/2025
  Time: 4:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="bt7" method="post">
    <h2>Đăng ký vé</h2>

    <label for="name">Nhập tên</label>
    <input type="text" name="name" id="name" required>

    <label for="class">Nhập lớp</label>
    <input type="text" name="class" id="class" required>

    <label for="type">Loại xe</label>
    <select name="type" id="type" required>
        <option value="">--Trống--</option>
        <option value="Xe máy">Xe máy</option>
        <option value="Xe đạp">Xe đạp</option>
    </select>

    <label for="licensePlate">Nhập biển số xe</label>
    <input type="text" name="licensePlate" id="licensePlate" required>

    <input type="submit" value="Gửi">
</form>

</body>
</html>
