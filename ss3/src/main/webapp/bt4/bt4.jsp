<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Addition Calculator</title>
</head>
<body>
<%
    int sum = 0;
    String aParam = request.getParameter("a");
    String bParam = request.getParameter("b");
    if (aParam != null && !aParam.isEmpty() && bParam != null && !bParam.isEmpty()) {
        int a = Integer.parseInt(aParam);
        int b = Integer.parseInt(bParam);
        sum = a + b;
    }
%>

<div>
    <h3>Enter 2 numbers</h3>
    <form method="get">
        <label>Enter first number</label>
        <input type="text" name="a">
        <label>Enter second number</label>
        <input type="text" name="b">
        <button type="submit">Add</button>
    </form>
</div>
<h2>Sum is: <%= sum %></h2>


</body>
</html>