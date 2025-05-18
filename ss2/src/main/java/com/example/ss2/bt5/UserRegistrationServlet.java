package com.example.ss2.bt5;


import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
@WebServlet(name = "bt5", value = "/bt5")
public class UserRegistrationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       req.getRequestDispatcher("bt5/form.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        String name = req.getParameter("userName");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        req.setAttribute("name",name);
        req.setAttribute("email",email);
        req.setAttribute("password",password);
        req.getRequestDispatcher("bt5/userInfo.jsp").forward(req,resp);
    }
}
