<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f5f5f5;
        }

        .container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }

        .form-section {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }

        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
        }

        input[type="text"]:focus, input[type="number"]:focus {
            border-color: #007bff;
            outline: none;
        }

        .error {
            color: #dc3545;
            font-size: 12px;
            margin-top: 5px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            transition: background-color 0.3s;
        }

        .btn-primary {
            background-color: #007bff;
            color: white;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-danger {
            background-color: #dc3545;
            color: white;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        .btn-warning {
            background-color: #ffc107;
            color: #212529;
        }

        .btn-warning:hover {
            background-color: #e0a800;
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
            color: #555;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        .price {
            text-align: right;
            font-weight: bold;
            color: #28a745;
        }

        .no-products {
            text-align: center;
            color: #6c757d;
            font-style: italic;
            padding: 20px;
        }

        .actions {
            text-align: center;
            margin-top: 20px;
        }

        .form-row {
            display: flex;
            gap: 15px;
        }

        .form-row .form-group {
            flex: 1;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>🛍️ Quản lý sản phẩm</h1>

    <!-- Form thêm sản phẩm -->
    <div class="form-section">
        <h2>Thêm sản phẩm mới</h2>
        <form:form modelAttribute="product" method="post" action="/products/add">
            <div class="form-row">
                <div class="form-group">
                    <label for="productCode">Mã sản phẩm:</label>
                    <form:input path="productCode" id="productCode" placeholder="Nhập mã sản phẩm"/>
                    <form:errors path="productCode" cssClass="error"/>
                </div>

                <div class="form-group">
                    <label for="productName">Tên sản phẩm:</label>
                    <form:input path="productName" id="productName" placeholder="Nhập tên sản phẩm"/>
                    <form:errors path="productName" cssClass="error"/>
                </div>

                <div class="form-group">
                    <label for="price">Giá (VNĐ):</label>
                    <form:input path="price" id="price" type="number" step="0.01" placeholder="Nhập giá"/>
                    <form:errors path="price" cssClass="error"/>
                </div>
            </div>

            <div style="text-align: center; margin-top: 20px;">
                <button type="submit" class="btn btn-primary">➕ Thêm sản phẩm</button>
            </div>
        </form:form>
    </div>

    <!-- Danh sách sản phẩm -->
    <div>
        <h2>Danh sách sản phẩm (${products.size()} sản phẩm)</h2>

        <c:choose>
            <c:when test="${not empty products}">
                <table>
                    <thead>
                    <tr>
                        <th>STT</th>
                        <th>Mã sản phẩm</th>
                        <th>Tên sản phẩm</th>
                        <th>Giá</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="product" items="${products}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td><strong>${product.productCode}</strong></td>
                            <td>${product.productName}</td>
                            <td class="price">
                                <fmt:formatNumber value="${product.price}" type="currency"
                                                  currencySymbol="" pattern="#,##0 VNĐ"/>
                            </td>
                            <td>
                                <a href="/products/delete/${product.productCode}"
                                   class="btn btn-danger"
                                   onclick="return confirm('Bạn có chắc muốn xóa sản phẩm ${product.productName}?')">
                                    🗑️ Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <div class="actions">
                    <a href="/products/clear" class="btn btn-warning"
                       onclick="return confirm('Bạn có chắc muốn xóa tất cả sản phẩm?')">
                        🧹 Xóa tất cả
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-products">
                    📦 Chưa có sản phẩm nào. Hãy thêm sản phẩm đầu tiên!
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>