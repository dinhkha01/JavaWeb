<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="<spring:message code="language.code" text="en"/>">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><spring:message code="user.register.title"/></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f9f9f9;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .error {
            color: #dc3545;
            font-size: 14px;
            margin-top: 5px;
        }
        .success {
            color: #28a745;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 15px;
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

    <h1><spring:message code="user.register.form.title"/></h1>

    <!-- Success Message -->
    <c:if test="${param.success != null && successMessage != null}">
        <div class="success">
                ${successMessage}
        </div>
    </c:if>

    <!-- Flash Success Message -->
    <c:if test="${successMessage != null}">
        <div class="success">
                ${successMessage}
        </div>
    </c:if>

    <!-- General Error Message -->
    <c:if test="${generalError != null}">
        <div class="error">
                ${generalError}
        </div>
    </c:if>

    <form:form method="post" modelAttribute="user" action="${pageContext.request.contextPath}/user/register">

        <!-- Username Field -->
        <div class="form-group">
            <form:label path="username"><spring:message code="user.username.label"/></form:label>
            <form:input path="username" placeholder="${usernamePlaceholder}" />
            <form:errors path="username" cssClass="error"/>
            <c:if test="${usernameExistsError != null}">
                <div class="error">${usernameExistsError}</div>
            </c:if>
        </div>

        <!-- Password Field -->
        <div class="form-group">
            <form:label path="password"><spring:message code="user.password.label"/></form:label>
            <form:password path="password" placeholder="${passwordPlaceholder}" />
            <form:errors path="password" cssClass="error"/>
        </div>

        <!-- Confirm Password Field -->
        <div class="form-group">
            <form:label path="confirmPassword"><spring:message code="user.confirmPassword.label"/></form:label>
            <form:password path="confirmPassword" placeholder="${confirmPasswordPlaceholder}" />
            <form:errors path="confirmPassword" cssClass="error"/>
            <c:if test="${passwordMismatchError != null}">
                <div class="error">${passwordMismatchError}</div>
            </c:if>
        </div>

        <!-- Email Field -->
        <div class="form-group">
            <form:label path="email"><spring:message code="user.email.label"/></form:label>
            <form:input path="email" type="email" placeholder="${emailPlaceholder}" />
            <form:errors path="email" cssClass="error"/>
            <c:if test="${emailExistsError != null}">
                <div class="error">${emailExistsError}</div>
            </c:if>
        </div>

        <!-- Submit Button -->
        <div class="form-group">
            <button type="submit" class="btn">
                <spring:message code="user.register.button"/>
            </button>
        </div>

    </form:form>
</div>

<!-- Set placeholders using Spring messages -->
<spring:message code="user.username.placeholder" var="usernamePlaceholder"/>
<spring:message code="user.password.placeholder" var="passwordPlaceholder"/>
<spring:message code="user.confirmPassword.placeholder" var="confirmPasswordPlaceholder"/>
<spring:message code="user.email.placeholder" var="emailPlaceholder"/>

</body>
</html>