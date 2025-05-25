<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Kết Quả</title>
</head>
<body>
<h1>Kết Quả Trò Chơi</h1>

<h2>Lựa chọn của bạn: ${userChoice}</h2>
<h2>Lựa chọn của máy tính: ${computerChoice}</h2>
<h2 style="color:
        ${result == 'Bạn thắng!' ? 'green' :
          result == 'Máy tính thắng!' ? 'red' : 'orange'}">
    ${result}
</h2>

<br>
<a href="index.jsp">Chơi lại</a>
</body>
</html>