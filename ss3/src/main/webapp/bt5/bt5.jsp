
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="<%=request.getContextPath()%>/bt5" method="post">
  <div>
    <label > ten dang nhap </label>
    <input type="text" name="name">
  </div>
  <div>
    <label >password</label>
    <input type="password" name="pass">
  </div>
  <div>
    <label >nhap email</label>
    <input type="email" name="email">
  </div>
  <button type="submit">gui</button>
</form>
<ul>
  <li>ten: ${name}</li>
  <li>pass: ${pass}</li>
  <li>email: ${email}</li>

</ul>
</body>
</html>
