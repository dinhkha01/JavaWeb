<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chỉnh Sửa Đơn Hàng</title>
    <meta charset="UTF-8">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f8f9fa;
        }
        .header {
            background-color: #007bff;
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .container {
            max-width: 600px;
            margin: 20px auto;
            padding: 0 20px;
        }
        .section {
            background: white;
            margin: 20px 0;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }
        input[readonly] {
            background-color: #f8f9fa;
            color: #6c757d;
        }
        button {
            padding: 12px 24px;
            margin-right: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
        h2 {
            color: #333;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
            margin-bottom: 25px;
        }
        .form-actions {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #dee2e6;
        }
    </style>
</head>
<body>
<div class="header">
    <h1>Chỉnh Sửa Đơn Hàng</h1>
    <div>
        Xin chào, <strong>${user.username}</strong>
        <a href="/logout" style="color: white; text-decoration: none; margin-left: 15px; background: rgba(255,255,255,0.2); padding: 5px 10px; border-radius: 3px;">Đăng xuất</a>
    </div>
</div>

<div class="container">
    <div class="section">
        <h2>Chỉnh Sửa Thông Tin Đơn Hàng</h2>

        <form:form method="post" action="/orders/update" modelAttribute="order">
            <div class="form-group">
                <form:label path="orderId">Mã đơn hàng:</form:label>
                <form:input path="orderId" type="text" readonly="true"/>
                <small style="color: #6c757d;">Mã đơn hàng không thể thay đổi</small>
            </div>

            <div class="form-group">
                <form:label path="productName">Tên sản phẩm:</form:label>
                <form:input path="productName" type="text" placeholder="Nhập tên sản phẩm" required="true"/>
            </div>

            <div class="form-group">
                <form:label path="quantity">Số lượng:</form:label>
                <form:input path="quantity" type="number" min="1" required="true"/>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn-primary">Cập nhật đơn hàng</button>
                <a href="/orders" class="btn-secondary">Hủy bỏ</a>
            </div>
        </form:form>
    </div>
</div>
</body>
</html>