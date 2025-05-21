<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<jsp:include page="Views/bt3/header.jsp"/>
<h1><%= "Hello World!" %>
</h1>
<br/>
<a href="hello-servlet">Hello Servlet</a>
<hr>
<a href="product">bt1</a>
<hr>
<a href="bt2">bt2</a>
<hr>
<a href="productList">bt4</a>
<hr>
<a href="bt5">bt5</a>
</body>
</html>