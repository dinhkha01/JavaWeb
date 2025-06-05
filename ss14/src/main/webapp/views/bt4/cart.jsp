<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Giỏ Hàng</title>
    <meta charset="UTF-8">
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"], input[type="number"] {
            width: 200px; padding: 8px; border: 1px solid #ddd; border-radius: 4px;
        }
        button {
            padding: 10px 15px; margin: 5px; background-color: #007bff;
            color: white; border: none; border-radius: 4px; cursor: pointer;
        }
        button:hover { background-color: #0056b3; }
        .btn-danger { background-color: #dc3545; }
        .btn-danger:hover { background-color: #c82333; }
        .btn-warning { background-color: #ffc107; color: #212529; }
        .btn-warning:hover { background-color: #e0a800; }
        table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #f8f9fa; }
        .section { margin: 30px 0; padding: 20px; border: 1px solid #ddd; border-radius: 5px; }
        .recent-products { background-color: #f8f9fa; }
    </style>
</head>
<body>
<div class="container">
    <h1>Giỏ Hàng của bạn</h1>

    <!-- Form thêm sản phẩm -->
    <div class="section">
        <h2>Thêm sản phẩm vào giỏ hàng</h2>
        <form:form method="post" action="/cart/add" modelAttribute="product">
            <div class="form-group">
                <form:label path="name">Tên sản phẩm:</form:label>
                <form:input path="name" type="text" required="true"/>
            </div>
            <div class="form-group">
                <form:label path="quantity">Số lượng:</form:label>
                <form:input path="quantity" type="number" min="1" value="1" required="true"/>
            </div>
            <button type="submit">Thêm vào giỏ hàng</button>
        </form:form>
    </div>

    <!-- Hiển thị giỏ hàng -->
    <div class="section">
        <h2>Sản phẩm trong giỏ hàng (Session)</h2>
        <c:choose>
            <c:when test="${empty cart}">
                <p>Giỏ hàng trống</p>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                    <tr>
                        <th>Tên sản phẩm</th>
                        <th>Số lượng</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="product" items="${cart}">
                        <tr>
                            <td>${product.name}</td>
                            <td>${product.quantity}</td>
                            <td>
                                <form method="post" action="/cart/remove" style="display: inline;">
                                    <input type="hidden" name="productName" value="${product.name}"/>
                                    <button type="submit" class="btn-danger">Xóa</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <form method="post" action="/cart/clear">
                    <button type="submit" class="btn-warning">Xóa toàn bộ giỏ hàng</button>
                </form>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Hiển thị sản phẩm gần đây từ cookie -->
    <div class="section recent-products">
        <h2>Sản phẩm gần đây (Cookie)</h2>
        <c:choose>
            <c:when test="${empty recentProducts}">
                <p>Chưa có sản phẩm nào được lưu trong cookie</p>
            </c:when>
            <c:otherwise>
                <ul>
                    <c:forEach var="productInfo" items="${recentProducts}">
                        <li>${productInfo}</li>
                    </c:forEach>
                </ul>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>