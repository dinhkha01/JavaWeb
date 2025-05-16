package dk.ss1.bt2;

import java.io.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "bt2", value = "/bt2")
public class bt2 extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        // Hello
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h5>" + "1. src/main/java\n" +
                "\n" +
                "Vai trò: Chứa toàn bộ mã nguồn Java của ứng dụng\n" +
                "Nội dung thường có:\n" +
                "\n" +
                "Các package chứa Java classes\n" +
                "Servlets xử lý request/response\n" +
                "Các đối tượng model (POJO)\n" +
                "Service classes chứa logic nghiệp vụ\n" +
                "DAO (Data Access Object) để tương tác với database\n" +
                "Controllers trong kiến trúc MVC" + "</h1>");
        out.println("<h5>" + "2. src/main/resources\n" +
                "\n" +
                "Vai trò: Chứa các tài nguyên và file cấu hình không phải mã nguồn\n" +
                "Nội dung thường có:\n" +
                "\n" +
                "File cấu hình ứng dụng (properties, xml)\n" +
                "File cấu hình logging\n" +
                "File cấu hình Hibernate/JPA\n" +
                "File migrations database\n" +
                "Các tài nguyên tĩnh khác không phải là nội dung web"+ "</h1>");
        out.println("<h5>" + "3. src/main/webapp\n" +
                "\n" +
                "Vai trò: Chứa các tài nguyên web và nội dung hiển thị\n" +
                "Nội dung thường có:\n" +
                "\n" +
                "Thư mục WEB-INF chứa web.xml và các thư mục cấu hình web\n" +
                "JSP files (như index.jsp vừa tạo)\n" +
                "HTML, CSS, JavaScript files\n" +
                "Thư mục resources hoặc assets chứa hình ảnh, font chữ\n" +
                "Các thư viện client-side" + "</h1>");
        out.println("</body></html>");
    }

    public void destroy() {
    }
}
