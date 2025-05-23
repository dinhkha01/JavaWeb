<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Thông Tin Sinh Viên</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      max-width: 600px;
      margin: 50px auto;
      padding: 20px;
      background-color: #f5f5f5;
    }
    .container {
      background-color: white;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    h3 {
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
      border: 2px solid #ddd;
      border-radius: 4px;
      font-size: 16px;
      box-sizing: border-box;
    }
    input[type="text"]:focus, input[type="number"]:focus {
      border-color: #4CAF50;
      outline: none;
    }
    .btn {
      background-color: #4CAF50;
      color: white;
      padding: 12px 30px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
      width: 100%;
    }
    .btn:hover {
      background-color: #45a049;
    }
    .error-messages {
      background-color: #f8d7da;
      color: #721c24;
      padding: 15px;
      border-radius: 4px;
      margin-bottom: 20px;
      border: 1px solid #f5c6cb;
    }
    .error-messages ul {
      margin: 0;
      padding-left: 20px;
    }
    .error-messages li {
      margin-bottom: 5px;
    }
  </style>
</head>
<body>
<div class="container">
  <h3>Nhập Các Thông Tin Tương Ứng</h3>

  <!-- Display error messages if any -->
  <c:if test="${not empty errors}">
    <div class="error-messages">
      <strong>Lỗi nhập liệu:</strong>
      <ul>
        <c:forEach var="error" items="${errors}">
          <li>${error}</li>
        </c:forEach>
      </ul>
    </div>
  </c:if>

  <form action="confirmbt3" method="post">
    <div class="form-group">
      <label for="svName">Nhập Tên *</label>
      <input type="text" id="svName" name="svName"

             placeholder="Ví dụ: Nguyễn Văn A" required>
    </div>

    <div class="form-group">
      <label for="svAge">Nhập Tuổi *</label>
      <input type="number" id="svAge" name="svAge"/>
    </div>

    <div class="form-group">
      <label for="svAddress">Nhập Địa Chỉ *</label>
      <input type="text" id="svAddress" name="svAddress"

             placeholder="Ví dụ: 123 Đường ABC, Quận XYZ, TP.HCM" required>
    </div>

    <button type="submit" class="btn">Gửi Thông Tin</button>
  </form>
</div>
</body>
</html>