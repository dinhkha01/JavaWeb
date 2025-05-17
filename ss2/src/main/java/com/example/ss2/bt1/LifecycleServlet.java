package com.example.ss2.bt1;

import java.io.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "lifecycle", value = "/lifecycle")
public class LifecycleServlet extends HttpServlet {
    private String message;

    public void init() {
        message = "Khi load thì chạy init xong đến chạy goGet khi dừng chương trình thì bắt destroy được gọi";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        // Hello
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>" + message + "</h1>");
        out.println("</body></html>");
    }

    public void destroy() {
    }
}