<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Đăng ký thông tin người dùng</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      max-width: 500px;
      margin: 50px auto;
      padding: 20px;
      background-color: #f5f5f5;
    }
    .form-container {
      background: white;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    h2 {
      text-align: center;
      color: #333;
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
    input[type="text"], input[type="email"], input[type="tel"] {
      width: 100%;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 4px;
      font-size: 14px;
      box-sizing: border-box;
    }
    input[type="text"]:focus, input[type="email"]:focus, input[type="tel"]:focus {
      border-color: #007bff;
      outline: none;
    }
    .error {
      color: #dc3545;
      font-size: 12px;
      margin-top: 5px;
      display: block;
    }
    .error-input {
      border-color: #dc3545 !important;
    }
    .submit-btn {
      width: 100%;
      padding: 12px;
      background-color: #007bff;
      color: white;
      border: none;
      border-radius: 4px;
      font-size: 16px;
      cursor: pointer;
      margin-top: 10px;
    }
    .submit-btn:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>
<div class="form-container">
  <h2>Đăng ký thông tin người dùng</h2>

  <form action="/registration" method="post">
    <!-- Trường tên người dùng -->
    <div class="form-group">
      <label for="name">Tên người dùng <span style="color: red;">*</span></label>
      <input type="text"
             id="name"
             name="name"
             value="${user.name != null ? user.name : ''}"
             class="${errors.name != null ? 'error-input' : ''}"
             placeholder="Nhập tên của bạn">
      <c:if test="${errors.name != null}">
        <span class="error">${errors.name}</span>
      </c:if>
    </div>

    <!-- Trường email -->
    <div class="form-group">
      <label for="email">Địa chỉ Email <span style="color: red;">*</span></label>
      <input type="email"
             id="email"
             name="email"
             value="${user.email != null ? user.email : ''}"
             class="${errors.email != null ? 'error-input' : ''}"
             placeholder="Nhập email của bạn">
      <c:if test="${errors.email != null}">
        <span class="error">${errors.email}</span>
      </c:if>
    </div>

    <!-- Trường số điện thoại -->
    <div class="form-group">
      <label for="phone">Số điện thoại <span style="color: red;">*</span></label>
      <input type="tel"
             id="phone"
             name="phone"
             value="${user.phone != null ? user.phone : ''}"
             class="${errors.phone != null ? 'error-input' : ''}"
             placeholder="Nhập số điện thoại của bạn">
      <c:if test="${errors.phone != null}">
        <span class="error">${errors.phone}</span>
      </c:if>
    </div>

    <!-- Nút submit -->
    <button type="submit" class="submit-btn">Đăng ký</button>
  </form>
</div>
</body>
</html>