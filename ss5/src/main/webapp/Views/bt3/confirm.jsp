<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Xác Nhận Thông Tin</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      max-width: 600px;
      margin: 50px auto;
      padding: 20px;
      background-color: #f5f5f5;
    }
    .container {
      background-color: white;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    h3 {
      color: #28a745;
      text-align: center;
      margin-bottom: 30px;
    }
    .info-card {
      background-color: #f8f9fa;
      padding: 20px;
      border-radius: 8px;
      border-left: 4px solid #28a745;
      margin-bottom: 20px;
    }
    .info-item {
      display: flex;
      margin-bottom: 15px;
      padding: 10px 0;
      border-bottom: 1px solid #e9ecef;
    }
    .info-item:last-child {
      border-bottom: none;
      margin-bottom: 0;
    }
    .info-label {
      font-weight: bold;
      color: #495057;
      min-width: 100px;
      margin-right: 15px;
    }
    .info-value {
      color: #212529;
      flex: 1;
    }
    .btn-group {
      display: flex;
      gap: 10px;
      justify-content: center;
      margin-top: 20px;
    }
    .btn {
      padding: 10px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 14px;
      text-decoration: none;
      text-align: center;
      min-width: 120px;
    }
    .btn-primary {
      background-color: #007bff;
      color: white;
    }
    .btn-secondary {
      background-color: #6c757d;
      color: white;
    }
    .btn:hover {
      opacity: 0.9;
    }
    .success-icon {
      text-align: center;
      font-size: 48px;
      color: #28a745;
      margin-bottom: 20px;
    }
  </style>
</head>
<body>
<div class="container">
  <div class="success-icon">✓</div>
  <h3>Đã Xác Nhận Thông Tin Sinh Viên</h3>

  <div class="info-card">
    <div class="info-item">
      <span class="info-label">Họ và Tên:</span>
      <span class="info-value">${sv.name}</span>
    </div>

    <div class="info-item">
      <span class="info-label">Tuổi:</span>
      <span class="info-value">${sv.age} tuổi</span>
    </div>

    <div class="info-item">
      <span class="info-label">Địa Chỉ:</span>
      <span class="info-value">${sv.address}</span>
    </div>
  </div>

  <div class="btn-group">
    <a href="confirmbt3" class="btn btn-primary">Nhập Sinh Viên Mới</a>

  </div>
</div>
</body>
</html>