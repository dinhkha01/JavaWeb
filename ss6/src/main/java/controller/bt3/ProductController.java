package controller.bt3;

import model.service.ProductService;
import model.service.ProductCartService;
import model.entity.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductController extends HttpServlet {
    private ProductService productService;
    private ProductCartService cartService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.productService = new ProductService();
        this.cartService = new ProductCartService();
    }

    /**
     * Hiển thị trang danh sách sản phẩm
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Lấy danh sách tất cả sản phẩm
            List<Product> products = productService.getAllProducts();

            // Đặt danh sách sản phẩm vào request attribute
            request.setAttribute("products", products);


            Integer userId = (Integer) request.getAttribute("userId");
            if (userId == null) {
                userId = 1; // Default user ID cho demo
                request.setAttribute("userId", userId);
            }

            // Lấy số lượng items trong cart
            int cartItemCount = cartService.getCartItemCount(userId);
            request.setAttribute("cartItemCount", cartItemCount);

            // Forward đến trang listProduct.jsp
            request.getRequestDispatcher("/Views/bt3/listProduct.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách sản phẩm");
            request.getRequestDispatcher("/Views/bt3/listProduct.jsp").forward(request, response);
        }
    }

    /**
     * Xử lý việc thêm sản phẩm vào giỏ hàng
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Lấy thông tin từ form
            String productIdStr = request.getParameter("productId");
            String quantityStr = request.getParameter("quantity");

            if (productIdStr == null || quantityStr == null) {
                request.setAttribute("error", "Thông tin sản phẩm không hợp lệ");
                doGet(request, response);
                return;
            }

            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);

            // Lấy userId từ session

            Integer userId = (Integer) request.getAttribute("userId");
            if (userId == null) {
                userId = 1; // Default user ID cho demo
                request.setAttribute("userId", userId);
            }

            // Thêm sản phẩm vào giỏ hàng
            boolean success = cartService.addToCart(userId, productId, quantity);

            if (success) {
                request.setAttribute("success", "Đã thêm sản phẩm vào giỏ hàng thành công!");
            } else {
                request.setAttribute("error", "Không thể thêm sản phẩm vào giỏ hàng");
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Thông tin sản phẩm không hợp lệ");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi thêm sản phẩm vào giỏ hàng");
        }

        doGet(request, response);
    }
}