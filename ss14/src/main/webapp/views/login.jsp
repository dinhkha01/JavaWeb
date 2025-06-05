<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng Nhập</title>
    <meta charset="UTF-8">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background: white;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            width: 300px;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }
        button {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
        }
        button:hover {
            background-color: #0056b3;
        }
        .error {
            color: #dc3545;
            margin-top: 10px;
            text-align: center;
        }
        .demo-info {
            background-color: #e7f3ff;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            font-size: 12px;
            color: #0066cc;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h1>Đăng Nhập</h1>

    <div class="demo-info">
        <strong>Demo:</strong> Nhập bất kỳ tên đăng nhập và mật khẩu nào để truy cập hệ thống
    </div>

    <form:form method="post" action="/login" modelAttribute="user">
        <div class="form-group">
            <form:label path="username">Tên đăng nhập:</form:label>
            <form:input path="username" type="text" placeholder="Nhập tên đăng nhập" required="true"/>
        </div>
        <div class="form-group">
            <form:label path="password">Mật khẩu:</form:label>
            <form:input path="password" type="password" placeholder="Nhập mật khẩu" required="true"/>
        </div>
        <button type="submit">Đăng Nhập</button>
    </form:form>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>
</div>
</body>
</html>