package com.example.ss2.bt2;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
@WebServlet(name = "submit", value = "/submit")
public class UserInfoServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/bt2.jsp").forward(request,response);
    }


    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");
        String name = request.getParameter("userName");
        int age = Integer.parseInt(request.getParameter("userAge"));
        System.out.println(name);
        request.setAttribute("name",name);
        request.setAttribute("age",age);
        request.getRequestDispatcher("/bt2.jsp").forward(request,response);

    }
}
