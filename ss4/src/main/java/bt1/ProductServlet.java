package bt1;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Product product1 = new Product("P001", "Laptop", 1500.0, "Laptop gaming");
        Product product2 = new Product("P002", "Smartphone", 800.0, "Điện thoại thông minh");
        Product product3 = new Product("P003", "Headphone", 200.0, "Tai nghe không dây");
        List<Product> listProduct = Arrays.asList(product1,product2,product3);
        req.setAttribute("products", listProduct);
        req.getRequestDispatcher("/Views/bt1/bt1.jsp").forward(req,resp);
    }
}
