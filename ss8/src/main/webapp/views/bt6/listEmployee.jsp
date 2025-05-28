<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Danh Sách Nhân Viên</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #f2f2f2; font-weight: bold; }
        tr:nth-child(even) { background-color: #f9f9f9; }
        .btn {
            background-color: #4CAF50; color: white; padding: 10px 15px;
            text-decoration: none; border-radius: 4px; display: inline-block;
            margin-bottom: 20px;
        }
        .btn:hover { background-color: #45a049; }
        .no-data { text-align: center; padding: 20px; color: #666; }
    </style>
</head>
<body>
<h2>Danh Sách Nhân Viên</h2>

<a href="/employees/add" class="btn">Thêm Nhân Viên Mới</a>

<c:choose>
    <c:when test="${not empty employees}">
        <table>
            <thead>
            <tr>
                <th>STT</th>
                <th>Tên</th>
                <th>Email</th>
                <th>Vị trí</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="employee" items="${employees}" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>${employee.name}</td>
                    <td>${employee.email}</td>
                    <td>${employee.position}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:when>
    <c:otherwise>
        <div class="no-data">
            <p>Chưa có nhân viên nào trong hệ thống.</p>
        </div>
    </c:otherwise>
</c:choose>

<p style="margin-top: 20px;">
    <strong>Tổng số nhân viên:</strong> ${employees.size()}
</p>
</body>
</html>