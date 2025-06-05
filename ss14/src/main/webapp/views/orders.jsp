<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Đơn Hàng</title>
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
            max-width: 1000px;
            margin: 20px auto;
            padding: 0 20px;
        }
        .section {
            background: white;
            margin: 20px 0;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-row {
            display: flex;
            gap: 15px;
            align-items: end;
        }
        .form-row .form-group {
            flex: 1;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-warning {
            background-color: #ffc107;
            color: #212529;
        }
        .btn-warning:hover {
            background-color: #e0a800;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f8f9fa;
            font-weight: bold;
            color: #495057;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .actions {
            display: flex;
            gap: 5px;
        }
        .empty-state {
            text-align: center;
            color: #6c757d;
            font-style: italic;
            padding: 40px;
        }
        h2 {
            color: #333;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="header">
    <h1>Quản Lý Đơn Hàng</h1>
    <div>
        Xin chào, <strong>${user.username}</strong>
        <a href="/logout" style="color: white; text-decoration: none; margin-left: 15px; background: rgba(255,255,255,0.2); padding: 5px 10px; border-radius: 3px;">Đăng xuất</a>
    </div>
</div>

<div class="container">
    <!-- Form thêm đơn hàng -->
    <div class="section">
        <h2>Thêm Đơn Hàng Mới</h2>
        <form:form method="post" action="/orders/add" modelAttribute="order">
            <div class="form-row">
                <div class="form-group">
                    <form:label path="orderId">Mã đơn hàng:</form:label>
                    <form:input path="orderId" type="text" placeholder="Nhập mã đơn hàng" required="true"/>
                </div>
                <div class="form-group">
                    <form:label path="productName">Tên sản phẩm:</form:label>
                    <form:input path="productName" type="text" placeholder="Nhập tên sản phẩm" required="true"/>
                </div>
                <div class="form-group">
                    <form:label path="quantity">Số lượng:</form:label>
                    <form:input path="quantity" type="number" min="1" value="1" required="true"/>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn-primary">Thêm đơn hàng</button>
                </div>
            </div>
        </form:form>
    </div>

    <!-- Danh sách đơn hàng -->
    <div class="section">
        <h2>Danh Sách Đơn Hàng (Session)</h2>
        <c:choose>
            <c:when test="${empty orders}">
                <div class="empty-state">
                    <p>Chưa có đơn hàng nào được tạo</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                    <tr>
                        <th>Mã đơn hàng</th>
                        <th>Tên sản phẩm</th>
                        <th>Số lượng</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td><strong>${order.orderId}</strong></td>
                            <td>${order.productName}</td>
                            <td>${order.quantity}</td>
                            <td>
                                <div class="actions">
                                    <a href="/orders/edit/${order.orderId}" class="btn-warning" style="text-decoration: none; display: inline-block; padding: 8px 12px; font-size: 12px;">Sửa</a>
                                    <form method="post" action="/orders/delete/${order.orderId}" style="display: inline;">
                                        <button type="submit" class="btn-danger" onclick="return confirm('Bạn có chắc muốn xóa đơn hàng này?')" style="padding: 8px 12px; font-size: 12px;">Xóa</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <div style="margin-top: 20px;">
                    <p><strong>Tổng số đơn hàng:</strong> ${orders.size()}</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>