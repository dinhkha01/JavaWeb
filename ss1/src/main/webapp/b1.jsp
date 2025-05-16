<%--
  Created by IntelliJ IDEA.
  User: dinhk
  Date: 5/16/2025
  Time: 9:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div>
    1. Client - Trình duyệt Web

    Chức năng: Hiển thị giao diện người dùng và tương tác với người dùng cuối
    Đặc điểm: Gửi HTTP/HTTPS request đến Web Server và hiển thị phản hồi trả về
    Công nghệ: HTML, CSS, JavaScript, các framework frontend (React, Angular, Vue.js)

    2. Web Server - Nginx/Apache

    Chức năng: Xử lý các yêu cầu HTTP/HTTPS từ client
    Đặc điểm: Phục vụ tài nguyên tĩnh (HTML, CSS, JS, hình ảnh), cân bằng tải, bảo mật
    Công nghệ: Nginx, Apache HTTP Server, Microsoft IIS

    3. Application Server - Tomcat/WildFly

    Chức năng: Chạy mã nguồn Java, xử lý logic nghiệp vụ của ứng dụng
    Đặc điểm: Quản lý vòng đời ứng dụng, xử lý yêu cầu động, kết nối với database
    Công nghệ: Apache Tomcat, WildFly (JBoss), WebLogic, WebSphere

    4. Database - MySQL/PostgreSQL/Oracle

    Chức năng: Lưu trữ và quản lý dữ liệu ứng dụng
    Đặc điểm: Thực hiện các thao tác CRUD (Create, Read, Update, Delete)
    Công nghệ: MySQL, PostgreSQL, Oracle, Microsoft SQL Server

    Cách các thành phần tương tác với nhau
    Trong kiến trúc ứng dụng web Java, các thành phần tương tác với nhau theo một luồng xử lý có tổ chức. Khi người dùng tương tác với giao diện trên trình duyệt (Client), trình duyệt sẽ gửi HTTP/HTTPS request đến Web Server. Web Server đóng vai trò như cổng vào đầu tiên, xử lý các tài nguyên tĩnh và chuyển tiếp các yêu cầu động đến Application Server.
    Application Server chứa logic nghiệp vụ của ứng dụng được viết bằng Java, xử lý các yêu cầu động thông qua các Servlet, JSP, hoặc framework như Spring. Khi cần truy xuất hoặc cập nhật dữ liệu, Application Server thiết lập kết nối với Database thông qua JDBC hoặc ORM framework như Hibernate. Database xử lý các truy vấn, thực hiện các thao tác với dữ liệu và trả kết quả về cho Application Server.
    Application Server sau khi nhận được kết quả từ Database sẽ xử lý và định dạng dữ liệu, sau đó gửi phản hồi về cho Web Server. Cuối cùng, Web Server chuyển phản hồi này đến trình duyệt của người dùng. Toàn bộ quá trình này diễn ra trong vài giây hoặc thậm chí là mili giây, tạo ra trải nghiệm mượt mà cho người dùng cuối.
</div>

</body>
</html>
