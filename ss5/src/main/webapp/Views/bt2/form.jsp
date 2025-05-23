<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 23/5/2025
  Time: 12:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h3>nhap cac thong tin tuong ung</h3>
<form action="confirm" method="post">
    <div>
        <label >Nhap ten</label>
        <input type="text" name="svName">
    </div>
    <div>
        <label >Nhap tuoi</label>
        <input type="number" name="svAge">
    </div>
    <div>
        <label >Nhap dia chi</label>
        <input type="text" name="svAddress">
    </div>
    <button type="submit">Gui</button>
</form>
</body>
</html>
