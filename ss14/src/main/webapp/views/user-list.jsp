<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="<spring:message code="language.code" text="en"/>">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><spring:message code="user.list.title"/></title>
    <style>
        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f9f9f9;
        }
        .language-switcher {
            text-align: right;
            margin-bottom: 20px;
        }
        .language-switcher a {
            margin: 0 5px;
            text-decoration: none;
            color: #007bff;
        }
        .navigation {
            text-align: center;
            margin-bottom: 20px;
        }
        .navigation a {
            margin: 0 10px;
            text-decoration: none;
            color: #007bff;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #e9e9e9;
        }
        .user-count {
            margin-top: 20px;
            font-weight: bold;
            color: #007bff;
        }
        .empty-message {
            text-align: center;
            color: #666;
            font-style: italic;
            margin: 30px 0;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Language Switcher -->
    <div class="language-switcher">
        <spring:message code="language.label"/>
        <a href="?lang=en"><spring:message code="english.label"/></a> |
        <a href="?lang=vi"><spring:message code="vietnamese.label"/></a>
    </div>

    <!-- Navigation -->
    <div class="navigation">
        <a href="${pageContext.request.contextPath}/"><spring:message code="nav.home"/></a>
        <a href="${pageContext.request.contextPath}/user/register"><spring:message code="nav.register"/></a>
        <a href="${pageContext.request.contextPath}/user/list"><spring:message code="nav.users"/></a>
    </div>

    <h1><spring:message code="user.list.title"/></h1>

    <c:choose>
        <c:when test="${empty users}">
            <div class="empty-message">
                <spring:message code="user.list.empty"/>
            </div>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                <tr>
                    <th><spring:message code="user.list.username"/></th>
                    <th><spring:message code="user.list.email"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td><c:out value="${user.username}"/></td>
                        <td><c:out value="${user.email}"/></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <div class="user-count">
                <spring:message code="user.list.count" arguments="${fn:length(users)}"/>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>