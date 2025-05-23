<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - Hệ Thống Quản Lý Sinh Viên</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-header h1 {
            color: #333;
            margin-bottom: 10px;
        }

        .login-header p {
            color: #666;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: bold;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            outline: none;
            border-color: #667eea;
        }

        .btn-login {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.2s;
        }

        .btn-login:hover {
            transform: translateY(-2px);
        }

        .message {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 6px;
            text-align: center;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .login-info {
            margin-top: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 6px;
            border-left: 4px solid #007bff;
        }

        .login-info h4 {
            color: #007bff;
            margin-bottom: 8px;
        }

        .login-info p {
            margin: 5px 0;
            color: #666;
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="login-header">
        <h1>Đăng Nhập</h1>
        <p>Hệ Thống Quản Lý Sinh Viên</p>
    </div>

    <!-- Display messages -->
    <c:if test="${not empty param.error}">
        <div class="message error">${param.error}</div>
    </c:if>

    <c:if test="${not empty param.message}">
        <div class="message success">${param.message}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="message error">${error}</div>
    </c:if>

    <form action="login" method="post">
        <div class="form-group">
            <label for="username">Tên đăng nhập:</label>
            <input type="text" id="username" name="username" required
                   placeholder="Nhập tên đăng nhập" value="${param.username}">
        </div>

        <div class="form-group">
            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password" required
                   placeholder="Nhập mật khẩu">
        </div>

        <button type="submit" class="btn-login">Đăng Nhập</button>
    </form>

    <div class="login-info">
        <h4>Thông tin đăng nhập demo:</h4>
        <p><strong>Tên đăng nhập:</strong> admin</p>
        <p><strong>Mật khẩu:</strong> 123456789</p>
    </div>
</div>

<script>
    // Tự động focus vào ô username khi trang load
    window.onload = function() {
        document.getElementById('username').focus();
    };

    // Tự động ẩn thông báo sau 5 giây
    setTimeout(function() {
        var messages = document.querySelectorAll('.message');
        messages.forEach(function(message) {
            message.style.opacity = '0';
            setTimeout(function() {
                message.style.display = 'none';
            }, 300);
        });
    }, 5000);
</script>
</body>
</html>