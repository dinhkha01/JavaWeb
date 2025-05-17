
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h3>Form</h3>
    <form action="submit" method="post">
        <div>
            <label >Nhap ten</label>
            <input type="text" name="userName">
        </div>
        <div>
            <label >Nhap tuoi</label>
            <input type="text" name="userAge">
        </div>
        <input type="submit" value="OK">
    </form>

<div>
     ${name}
    ${age}
</div>
</body>
</html>
