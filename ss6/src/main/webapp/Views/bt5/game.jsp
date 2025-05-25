<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trò Chơi Búa Kéo Lá</title>
</head>
<body>
<h1>Chơi Búa Kéo Lá</h1>
<form action="GameServlet" method="post">
    <p>Chọn lựa chọn của bạn:</p>
    <input type="radio" name="userChoice" value="rock" id="rock" required>
    <label for="rock">🪨 Búa</label><br>

    <input type="radio" name="userChoice" value="paper" id="paper" required>
    <label for="paper">📄 Lá</label><br>

    <input type="radio" name="userChoice" value="scissors" id="scissors" required>
    <label for="scissors">✂️ Kéo</label><br><br>

    <input type="submit" value="Chơi!">
</form>
</body>
</html>