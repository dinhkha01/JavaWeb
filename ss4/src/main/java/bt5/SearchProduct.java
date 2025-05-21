package bt5;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
@WebServlet("/bt5")

public class SearchProduct extends HttpServlet {
    private static final List<Product> lisetProduct = new ArrayList<>();
    static {
        lisetProduct.add(new Product("P1","1",10));
        lisetProduct.add(new Product("P2","2",20));
        lisetProduct.add(new Product("P3","3",30));
        lisetProduct.add(new Product("p4","4",40));
        lisetProduct.add(new Product("p5","5",50));
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/Views/bt5/bt5.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String id = req.getParameter("id");
            Product product = lisetProduct.stream().filter(p -> p.getId().equals(id)).findFirst().orElse(null);
            req.setAttribute("product",product);
             req.getRequestDispatcher("/Views/bt5/bt5.jsp").forward(req,resp);
    }
}
