<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div>
    <h3>Them san pham</h3>
    <form action="bt6" method="post">
        <div>
            <label >ten</label>
            <input type="text" name="name">
        </div>
        <div>
            <label >gia</label>
            <input type="text" name="price">
        </div>
        <input type="submit" value="them">
    </form>
    <h2>danh sach san pham</h2>
    <table>
        <tr>
            <th>id</th>
            <th>ten</th>
            <th>gia</th>
            <th>hanh dong</th>
        </tr>
        <c:forEach var="product" items="${products}">
       <tr>
           <td>${product.id}</td>
           <td>${product.name}</td>
           <td>${product.price}</td>
           <td>
               <button>sua</button>
               <button>xoa</button>
           </td>
       </tr>
        </c:forEach>
    </table>
</div>

</body>
</html>
