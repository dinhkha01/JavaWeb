<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thông tin người dùng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 500px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        input[type="text"], input[type="file"] {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .user-info {
            margin-top: 30px;
            padding: 20px;
            background-color: #e8f5e8;
            border-radius: 8px;
            border-left: 4px solid #4CAF50;
        }
        .user-info h3 {
            margin-top: 0;
            color: #2e7d32;
        }
        .user-info p {
            margin: 8px 0;
            color: #333;
        }
        .message {
            background-color: #d4edda;
            color: #155724;
            padding: 10px;
            border-radius: 4px;
            margin: 15px 0;
        }
        .avatar-image {
            max-width: 200px;
            max-height: 200px;
            border-radius: 8px;
            border: 2px solid #ddd;
            margin: 10px 0;
            display: block;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Nhập thông tin người dùng</h2>
    <form:form action="/profile" method="post" modelAttribute="profile" enctype="multipart/form-data">
        <div class="form-group">
            <label>Nhập tên:</label>
            <form:input path="name" required="true" />
        </div>
        <div class="form-group">
            <label>Chọn ảnh:</label>
            <input type="file" name="file" accept="image/*" />
        </div>
        <input type="submit" value="Gửi thông tin">
    </form:form>

    <!-- Hiển thị thông báo -->
    <c:if test="${not empty message}">
        <div class="message">
                ${message}
        </div>
    </c:if>

    <!-- Hiển thị thông tin sau khi submit -->
    <c:if test="${not empty profile && not empty profile.name}">
        <div class="user-info">
            <h3>Thông tin người dùng đã nhập:</h3>
            <p><strong>Tên:</strong> ${profile.name}</p>
            <c:if test="${not empty profile.avatar}">
                <p><strong>Ảnh đại diện:</strong></p>
                 <img src="/static/img/${profile.avatar}" alt="Avatar của ${profile.name}" class="avatar-image" />
                <p><em>File: ${profile.avatar}</em></p>
            </c:if>
        </div>
    </c:if>
</div>
</body>
</html>