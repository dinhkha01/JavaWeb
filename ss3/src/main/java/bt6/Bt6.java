package bt6;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/bt6")
public class Bt6 extends HttpServlet {
    private static final List<Product> listProducts = new ArrayList<>();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Product product = new Product();
        product.setId( req.getParameter("id"));
        product.setName(req.getParameter("name"));
        String priceParam=req.getParameter("price");
        String quantityParam =req.getParameter("quantity");
        product.setDescription(req.getParameter("description"));

        if(priceParam!=null && quantityParam!= null && !priceParam.isEmpty() && !quantityParam.isEmpty()){
            product.setQuantity(Integer.parseInt(quantityParam));
            product.setPrice(Integer.parseInt(priceParam));
        }

        listProducts.add(product);
        req.setAttribute("products",listProducts);
        req.getRequestDispatcher("bt6/bt6.jsp").forward(req,resp);


    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("bt6/bt6.jsp").forward(req,resp);
    }
}
