package com.example.ss2.bt4;


import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
@WebServlet(name = "bt4", value = "/bt4")
public class RegisterServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("bt4/form.jsp").forward(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");
        String name = request.getParameter("userName");
        String email = request.getParameter("email");
        System.out.println(name+" "+ email);
        response.sendRedirect("bt4/thankyou.jsp");
    }
}
