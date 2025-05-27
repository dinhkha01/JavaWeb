<%--
  Created by IntelliJ IDEA.
  User: dinhk
  Date: 5/27/2025
  Time: 9:44 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lỗi 404 - Trang không tìm thấy</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .error-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 500px;
            width: 90%;
        }

        .error-code {
            font-size: 72px;
            font-weight: bold;
            color: #e74c3c;
            margin-bottom: 10px;
        }

        .error-message {
            font-size: 24px;
            color: #2c3e50;
            margin-bottom: 20px;
        }

        .error-description {
            font-size: 16px;
            color: #7f8c8d;
            margin-bottom: 30px;
            line-height: 1.5;
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin: 5px;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #2980b9;
        }

        .btn-secondary {
            background-color: #95a5a6;
        }

        .btn-secondary:hover {
            background-color: #7f8c8d;
        }
    </style>
</head>
<body>
<div class="error-container">
    <div class="error-code">404</div>
    <h1 class="error-message">Trang không tìm thấy</h1>
    <p class="error-description">
        Lỗi rồi! Đường dẫn bạn yêu cầu không tồn tại trên hệ thống.
        Vui lòng kiểm tra lại URL hoặc quay về trang chủ.
    </p>

    <div>
        <a href="/" class="btn">Về trang chủ</a>
        <a href="javascript:history.back()" class="btn btn-secondary">Quay lại</a>
    </div>
</div>
</body>
</html>