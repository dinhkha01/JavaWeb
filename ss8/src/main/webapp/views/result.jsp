<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Kết quả đăng ký</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      max-width: 500px;
      margin: 50px auto;
      padding: 20px;
      background-color: #f5f5f5;
    }
    .result-container {
      background: white;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      text-align: center;
    }
    .success-message {
      color: #28a745;
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 30px;
    }
    .success-icon {
      font-size: 60px;
      color: #28a745;
      margin-bottom: 20px;
    }
    .user-info {
      background: #f8f9fa;
      padding: 20px;
      border-radius: 5px;
      margin: 20px 0;
      text-align: left;
    }
    .user-info h3 {
      color: #333;
      margin-bottom: 15px;
      text-align: center;
    }
    .info-row {
      margin-bottom: 10px;
      padding: 8px 0;
      border-bottom: 1px solid #eee;
    }
    .info-row:last-child {
      border-bottom: none;
    }
    .info-label {
      font-weight: bold;
      color: #555;
      display: inline-block;
      width: 120px;
    }
    .info-value {
      color: #333;
    }
    .back-btn {
      background-color: #6c757d;
      color: white;
      padding: 10px 20px;
      text-decoration: none;
      border-radius: 4px;
      display: inline-block;
      margin-top: 20px;
    }
    .back-btn:hover {
      background-color: #5a6268;
      text-decoration: none;
      color: white;
    }
  </style>
</head>
<body>
<div class="result-container">
  <div class="success-icon">✅</div>
  <div class="success-message">${message}</div>

  <div class="user-info">
    <h3>Thông tin đã đăng ký</h3>
    <div class="info-row">
      <span class="info-label">Tên:</span>
      <span class="info-value">${user.name}</span>
    </div>
    <div class="info-row">
      <span class="info-label">Email:</span>
      <span class="info-value">${user.email}</span>
    </div>
    <div class="info-row">
      <span class="info-label">Số điện thoại:</span>
      <span class="info-value">${user.phone}</span>
    </div>
  </div>

  <a href="/registration" class="back-btn">Đăng ký người dùng khác</a>
</div>
</body>
</html>
