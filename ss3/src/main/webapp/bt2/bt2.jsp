
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>


<form action="bt2.jsp" method="get">
    <div>
        <label >nhap ten </label>
        <input type="text" name="name">

    </div>
    <div>
        <label >nhap email </label>
        <input type="email" name="email">
    </div>
    <input type="submit" value="gui">
</form>
<%
String name = request.getParameter("name");
String email = request.getParameter("email");

    request.setAttribute("name", name);
    request.setAttribute("email", email);
%>

<h3>thong tin vua nhap</h3>
<div>
    <h5>ten: <%=request.getAttribute("name")%></h5>
    <h5>email: <%=request.getAttribute("email")%></h5>
</div>

</body>
</html>
