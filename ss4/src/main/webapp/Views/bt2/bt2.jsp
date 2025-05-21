<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="<%=request.getContextPath()%>/bt2" method="post">
    <div>
      <label >UserName</label>
      <input type="text" name="name">
    </div>
  <button type="submit">Dang nhap</button>
</form>

<c:if test="${not empty name}">
  <div style="margin-top: 20px;">
    <c:if test="${name == 'admin'}">
      <p >Đăng nhập thành công!</p>
    </c:if>
    <c:if test="${name != 'admin'}">
      <p>Sai tên đăng nhập! Vui lòng thử lại.</p>
    </c:if>
  </div>
</c:if>
</body>
</html>
