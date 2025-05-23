<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sửa Thông Tin Sinh Viên</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
      background-color: #f5f5f5;
    }

    .container {
      max-width: 600px;
      margin: 0 auto;
      background-color: white;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }

    h1 {
      color: #333;
      text-align: center;
      margin-bottom: 30px;
    }

    .form-group {
      margin-bottom: 20px;
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
      border: 1px solid #ddd;
      border-radius: 4px;
      font-size: 16px;
      box-sizing: border-box;
    }

    input[type="text"]:focus, input[type="number"]:focus {
      border-color: #4CAF50;
      outline: none;
    }

    .btn {
      padding: 12px 20px;
      margin: 10px 5px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
      text-decoration: none;
      display: inline-block;
    }

    .btn-primary {
      background-color: #4CAF50;
      color: white;
    }

    .btn-primary:hover {
      background-color: #45a049;
    }

    .btn-secondary {
      background-color: #6c757d;
      color: white;
    }

    .btn-secondary:hover {
      background-color: #5a6268;
    }

    .form-actions {
      text-align: center;
      margin-top: 30px;
    }
  </style>
</head>
<body>
<div class="container">
  <h1>Sửa Thông Tin Sinh Viên</h1>

  <form action="bt4" method="post">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="id" value="${student.id}">

    <div class="form-group">
      <label for="name">Họ và Tên:</label>
      <input type="text" id="name" name="name" value="${student.name}" required>
    </div>

    <div class="form-group">
      <label for="age">Tuổi:</label>
      <input type="number" id="age" name="age" value="${student.age}" min="1" max="100" required>
    </div>

    <div class="form-group">
      <label for="address">Địa Chỉ:</label>
      <input type="text" id="address" name="address" value="${student.address}" required>
    </div>

    <div class="form-actions">
      <button type="submit" class="btn btn-primary">Cập Nhật</button>
      <a href="bt4?action=list" class="btn btn-secondary">Hủy</a>
    </div>
  </form>
</div>
</body>
</html>