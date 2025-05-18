package com.example.ss2.bt6;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "bt6", value = "/bt6")
public class ProductServlet extends HttpServlet {
    private static final List<Product> listProduct = new ArrayList<>();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Product product = new Product();
        product.setId(listProduct.size()+1);
        product.setName(req.getParameter("name"));
        product.setPrice(Double.parseDouble(req.getParameter("price")));
        listProduct.add(product);
        req.setAttribute("products", listProduct);
        req.getRequestDispatcher("bt6/productList.jsp").forward(req, resp);
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("products", listProduct);
        req.getRequestDispatcher("bt6/productList.jsp").forward(req, resp);
    }
}