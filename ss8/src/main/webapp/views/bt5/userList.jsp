<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Danh sách người dùng</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
      background-color: #f5f5f5;
    }
    .container {
      max-width: 1200px;
      margin: 0 auto;
      background: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    h1 {
      color: #333;
      text-align: center;
      margin-bottom: 30px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }
    th, td {
      border: 1px solid #ddd;
      padding: 12px;
      text-align: left;
    }
    th {
      background-color: #007bff;
      color: white;
      font-weight: bold;
      text-align: center;
    }
    tr:nth-child(even) {
      background-color: #f9f9f9;
    }
    tr:hover {
      background-color: #f1f1f1;
    }
    .no-data {
      text-align: center;
      color: #666;
      font-style: italic;
      padding: 20px;
    }
    .user-count {
      margin-bottom: 10px;
      color: #666;
      font-weight: bold;
    }
    .email {
      color: #007bff;
    }
    .phone {
      color: #28a745;
    }
    .age {
      text-align: center;
      font-weight: bold;
    }
    .birth-date {
      text-align: center;
    }
  </style>
</head>
<body>
<div class="container">
  <h1>Danh sách người dùng</h1>
      <table>
        <thead>
        <tr>
          <th>STT</th>
          <th>Tên người dùng</th>
          <th>Email</th>
          <th>Số điện thoại</th>
          <th>Ngày sinh</th>
          <th>Tuổi</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach var="user" items="${userList}" >
          <tr>
            <td style="text-align: center;">${status.index + 1}</td>
            <td>${user.name}</td>
            <td class="email">${user.email}</td>
            <td class="phone">${user.phone}</td>
            <td class="birth-date">${user.dob}</td>
            <td class="age">${user.age}</td>
          </tr>
        </c:forEach>
        </tbody>
      </table>

</div>
</body>
</html>