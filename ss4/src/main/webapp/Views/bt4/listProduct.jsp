<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 21/5/2025
  Time: 12:51 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>Danh sach san pham</h1>
<c:choose>
  <c:when test="${not empty products}">
      <table border="10" cellspacing="10" cellpadding="10">
            <tr>
              <th>ID</th>
              <th>Name</th>
              <th>Price</th>
              <th>Description</th>
            </tr>
        <c:forEach var="p" items="${products}">
          <tr>
            <td>
              <c:choose>
                <c:when test="${not empty p.id}">
                  ${p.id}
                </c:when>
                <c:otherwise>
                  san pham khong co id
                </c:otherwise>
              </c:choose>
            </td>
            <td>
              <c:choose>
                <c:when test="${not empty p.name}">
                  ${p.name}
                </c:when>
                <c:otherwise>
                  san pham khong co name
                </c:otherwise>
              </c:choose>
            </td>
            <td>
              <c:choose>
                <c:when test="${not empty p.price}">
                  ${p.price}
                </c:when>
                <c:otherwise>
                  san pham khong co price
                </c:otherwise>
              </c:choose>
            </td>
            <td>
              <c:choose>
                <c:when test="${not empty p.description}">
                  ${p.description}
                </c:when>
                <c:otherwise>
                  san pham khong co description
                </c:otherwise>
              </c:choose>
            </td>
          </tr>
        </c:forEach>
      </table>
  </c:when>
  <c:otherwise>
    <h3>không có thông tin sản phẩm nào cả</h3>
  </c:otherwise>
</c:choose>
</body>
</html>
