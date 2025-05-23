<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Danh Sách Sinh Viên</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f5f5f5;
    }

    .header {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      padding: 15px 20px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .header-content {
      max-width: 1000px;
      margin: 0 auto;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .header h1 {
      margin: 0;
      font-size: 24px;
    }

    .user-info {
      display: flex;
      align-items: center;
      gap: 15px;
    }

    .user-info span {
      font-size: 14px;
    }

    .btn-logout {
      background-color: rgba(255,255,255,0.2);
      color: white;
      padding: 8px 16px;
      text-decoration: none;
      border-radius: 4px;
      border: 1px solid rgba(255,255,255,0.3);
      font-size: 14px;
      transition: background-color 0.3s;
    }

    .btn-logout:hover {
      background-color: rgba(255,255,255,0.3);
    }

    .container {
      max-width: 1000px;
      margin: 20px auto;
      background-color: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }

    .page-title {
      color: #333;
      text-align: center;
      margin-bottom: 30px;
      font-size: 28px;
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
      background-color: #4CAF50;
      color: white;
      font-weight: bold;
    }

    tr:hover {
      background-color: #f5f5f5;
    }

    .btn {
      padding: 8px 16px;
      color: white;
      text-decoration: none;
      border-radius: 4px;
      border: none;
      cursor: pointer;
      font-size: 14px;
      margin-right: 5px;
      display: inline-block;
    }

    .btn-edit {
      background-color: #2196F3;
    }

    .btn-edit:hover {
      background-color: #1976D2;
    }

    .btn-delete {
      background-color: #f44336;
    }

    .btn-delete:hover {
      background-color: #d32f2f;
    }

    .message {
      padding: 12px;
      margin-bottom: 20px;
      border-radius: 4px;
      font-weight: bold;
    }

    .success {
      background-color: #d4edda;
      color: #155724;
      border: 1px solid #c3e6cb;
    }

    .error {
      background-color: #f8d7da;
      color: #721c24;
      border: 1px solid #f5c6cb;
    }

    .no-data {
      text-align: center;
      color: #666;
      margin-top: 20px;
      padding: 40px;
      background-color: #f8f9fa;
      border-radius: 4px;
    }

    .actions-column {
      width: 150px;
    }
  </style>
</head>
<body>
<div class="header">
  <div class="header-content">
    <h1>Hệ Thống Quản Lý Sinh Viên</h1>
    <div class="user-info">
      <span>Xin chào, <strong>${currentUser}</strong>!</span>
      <a href="bt4?action=logout" class="btn-logout" onclick="return confirm('Bạn có chắc chắn muốn đăng xuất?')">Đăng xuất</a>
    </div>
  </div>
</div>

<div class="container">
  <h2 class="page-title">Danh Sách Sinh Viên</h2>

  <!-- Display success messages -->
  <c:if test="${not empty sessionScope.successMessage}">
    <div class="message success">${sessionScope.successMessage}</div>
    <c:remove var="successMessage" scope="session" />
  </c:if>

  <!-- Display error messages -->
  <c:if test="${not empty sessionScope.errorMessage}">
    <div class="message error">${sessionScope.errorMessage}</div>
    <c:remove var="errorMessage" scope="session" />
  </c:if>

  <c:choose>
    <c:when test="${not empty students}">
      <table>
        <thead>
        <tr>
          <th>ID</th>
          <th>Họ và Tên</th>
          <th>Tuổi</th>
          <th>Địa Chỉ</th>
          <th class="actions-column">Hành Động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="student" items="${students}">
          <tr>
            <td>${student.id}</td>
            <td>${student.name}</td>
            <td>${student.age}</td>
            <td>${student.address}</td>
            <td>
              <a href="bt4?action=edit&id=${student.id}" class="btn btn-edit">Sửa</a>
              <a href="#" onclick="confirmDelete(${student.id}, '${student.name}')" class="btn btn-delete">Xóa</a>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </c:when>
    <c:otherwise>
      <div class="no-data">
        <h3>Không có sinh viên nào trong danh sách</h3>
        <p>Hệ thống chưa có dữ liệu sinh viên để hiển thị.</p>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<script>
  function confirmDelete(studentId, studentName) {
    var confirmed = confirm("Bạn có chắc chắn muốn xóa sinh viên '" + studentName + "' không?\n\nHành động này không thể hoàn tác!");
    if (confirmed) {
      window.location.href = "bt4?action=delete&id=" + studentId;
    }
  }

  // Tự động ẩn thông báo sau 5 giây
  window.onload = function() {
    var messages = document.querySelectorAll('.message');
    messages.forEach(function(message) {
      setTimeout(function() {
        message.style.opacity = '0';
        setTimeout(function() {
          message.style.display = 'none';
        }, 300);
      }, 5000);
    });
  };
</script>
</body>
</html>