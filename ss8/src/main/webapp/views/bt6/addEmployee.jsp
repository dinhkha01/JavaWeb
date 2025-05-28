<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Thêm Nhân Viên</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 20px; }
    .form-group { margin-bottom: 15px; }
    label { display: inline-block; width: 150px; }
    input[type="text"], input[type="email"] {
      padding: 5px; width: 200px;
    }
    input[type="submit"] {
      background-color: #4CAF50; color: white; padding: 10px 20px;
      border: none; cursor: pointer;
    }
  </style>
</head>
<body>
<h2>Thêm Nhân Viên Mới</h2>

<form:form action="/employees" method="post" modelAttribute="employee">
  <div class="form-group">
    <label>Tên nhân viên:</label>
    <form:input path="name" required="true" />
  </div>

  <div class="form-group">
    <label>Email:</label>
    <form:input path="email" type="email" required="true" />
  </div>

  <div class="form-group">
    <label>Vị trí:</label>
    <form:input path="position" required="true" />
  </div>

  <div class="form-group">
    <input type="submit" value="Thêm Nhân Viên">
    <a href="/employees" style="margin-left: 10px;">Quay lại danh sách</a>
  </div>
</form:form>
</body>
</html>