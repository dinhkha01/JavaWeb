<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="<spring:message code="language.code" text="en"/>">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><spring:message code="home.title"/></title>
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
            margin-bottom: 30px;
        }
        .navigation a {
            margin: 0 10px;
            text-decoration: none;
            color: #007bff;
            padding: 8px 16px;
            border: 1px solid #007bff;
            border-radius: 4px;
            transition: all 0.3s ease;
        }
        .navigation a:hover {
            background-color: #007bff;
            color: white;
        }
        .welcome-section {
            text-align: center;
            margin-bottom: 30px;
        }
        .welcome-section h1 {
            color: #007bff;
            margin-bottom: 15px;
        }
        .welcome-message {
            font-size: 18px;
            color: #333;
            margin-bottom: 20px;
        }
        .features-section {
            margin-bottom: 30px;
        }
        .features-section h2 {
            color: #007bff;
            border-bottom: 2px solid #007bff;
            padding-bottom: 5px;
            margin-bottom: 15px;
        }
        .feature-list {
            list-style: none;
            padding: 0;
        }
        .feature-list li {
            background-color: #e9ecef;
            margin: 10px 0;
            padding: 12px;
            border-left: 4px solid #007bff;
            border-radius: 4px;
        }
        .about-section {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        .about-section h2 {
            color: #007bff;
            margin-bottom: 15px;
        }
        .contact-section {
            background-color: #007bff;
            color: white;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
        }
        .contact-section h2 {
            margin-bottom: 15px;
        }
        .quick-actions {
            text-align: center;
            margin: 30px 0;
        }
        .btn {
            display: inline-block;
            background-color: #28a745;
            color: white;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 6px;
            margin: 0 10px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }
        .btn:hover {
            background-color: #218838;
            color: white;
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
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

    <!-- Welcome Section -->
    <div class="welcome-section">
        <h1><spring:message code="home.title"/></h1>
        <div class="welcome-message">
            <spring:message code="welcome.message"/>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="quick-actions">
        <a href="${pageContext.request.contextPath}/user/register" class="btn">
            <spring:message code="nav.register"/>
        </a>
        <a href="${pageContext.request.contextPath}/user/list" class="btn btn-secondary">
            <spring:message code="nav.users"/>
        </a>
    </div>

    <!-- About Section -->
    <div class="about-section">
        <h2><spring:message code="about.title"/></h2>
        <p><spring:message code="about.content"/></p>
    </div>

    <!-- Features Section -->
    <div class="features-section">
        <h2><spring:message code="features.title"/></h2>
        <ul class="feature-list">
            <li><spring:message code="feature.1"/></li>
            <li><spring:message code="feature.2"/></li>
            <li><spring:message code="feature.3"/></li>
        </ul>
    </div>

    <!-- Contact Section -->
    <div class="contact-section">
        <h2><spring:message code="contact.title"/></h2>
        <p><spring:message code="contact.content"/></p>
    </div>
</div>
</body>
</html>