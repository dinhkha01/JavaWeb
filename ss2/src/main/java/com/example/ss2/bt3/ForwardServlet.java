package com.example.ss2.bt3;
import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "bt3", value = "/bt3")
public class ForwardServlet extends HttpServlet{
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("bt3/bt3Form.jsp").forward(request,response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");
        String name = request.getParameter("userName");
        int age = Integer.parseInt(request.getParameter("userAge"));
        System.out.println(name);
        request.setAttribute("name",name);
        request.setAttribute("age",age);
        request.getRequestDispatcher("bt3/display.jsp").forward(request,response);

    }
}
