package bt4;

import bt1.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet("/productList")
public class listProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Product p1 = new Product("1", "Sản phẩm 01", null, "Mô tả sp 01");
        Product p2 = new Product(null, "Sản phẩm 02", 3000.0, "Mô tả sp 02");
        Product p3 = new Product("3", null, 3000.0, "Mô tả sp 03");
        Product p4 = new Product("4", "san pham 4", 3000.0, null);
        List<Product> productList = Arrays.asList(p1,p2,p3,p4);
        req.setAttribute("products",productList);
        req.getRequestDispatcher("/Views/bt4/listProduct.jsp").forward(req,resp);
    }
}
