package controller.bt3;

import model.service.ProductCartService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/cart")
public class CartController extends HttpServlet {
    private ProductCartService cartService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.cartService = new ProductCartService();
    }

    /**
     * Hiển thị trang giỏ hàng
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            Integer userId = (Integer) request.getAttribute("userId");
            if (userId == null) {
                userId = 1; // Default user ID cho demo
                request.setAttribute("userId", userId);
            }

            // Lấy danh sách sản phẩm trong giỏ hàng
            List<Map<String, Object>> cartItems = cartService.getCartByUserId(userId);

            // Lấy thông tin tổng tiền
            Map<String, Object> cartTotal = cartService.getCartTotal(userId);

            // Đặt dữ liệu vào request attributes
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("cartTotal", cartTotal);

            // Kiểm tra giỏ hàng có rỗng không
            boolean isEmpty = cartItems == null || cartItems.isEmpty();
            request.setAttribute("isEmpty", isEmpty);

            // Forward đến trang cart.jsp
            request.getRequestDispatcher("/Views/bt3/cart.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải giỏ hàng");
            request.getRequestDispatcher("/Views/bt3/cart.jsp").forward(request, response);
        }
    }

    /**
     * Xử lý việc xóa sản phẩm khỏi giỏ hàng
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String action = request.getParameter("action");

            if ("remove".equals(action)) {
                // Xóa sản phẩm khỏi giỏ hàng
                String cartIdStr = request.getParameter("cartId");

                if (cartIdStr != null) {
                    int cartId = Integer.parseInt(cartIdStr);
                    boolean success = cartService.removeFromCart(cartId);

                    if (success) {
                        request.setAttribute("success", "Đã xóa sản phẩm khỏi giỏ hàng");
                    } else {
                        request.setAttribute("error", "Không thể xóa sản phẩm khỏi giỏ hàng");
                    }
                }

            } else if ("update".equals(action)) {
                // Cập nhật số lượng sản phẩm
                String cartIdStr = request.getParameter("cartId");
                String quantityStr = request.getParameter("quantity");

                if (cartIdStr != null && quantityStr != null) {
                    int cartId = Integer.parseInt(cartIdStr);
                    int quantity = Integer.parseInt(quantityStr);

                    if (quantity <= 0) {
                        // Nếu số lượng <= 0 thì xóa sản phẩm
                        boolean success = cartService.removeFromCart(cartId);
                        if (success) {
                            request.setAttribute("success", "Đã xóa sản phẩm khỏi giỏ hàng");
                        }
                    } else {
                        // Cập nhật số lượng
                        boolean success = cartService.updateCartQuantity(cartId, quantity);
                        if (success) {
                            request.setAttribute("success", "Đã cập nhật số lượng sản phẩm");
                        } else {
                            request.setAttribute("error", "Không thể cập nhật số lượng sản phẩm");
                        }
                    }
                }

            } else if ("clear".equals(action)) {
                // Xóa tất cả sản phẩm trong giỏ hàng
                HttpSession session = request.getSession();
                Integer userId = (Integer) session.getAttribute("userId");
                if (userId == null) {
                    userId = 1;
                }

                boolean success = cartService.clearCart(userId);
                if (success) {
                    request.setAttribute("success", "Đã xóa tất cả sản phẩm khỏi giỏ hàng");
                } else {
                    request.setAttribute("error", "Không thể xóa giỏ hàng");
                }
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Thông tin không hợp lệ");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi xử lý giỏ hàng");
        }

        // Redirect về trang giỏ hàng để hiển thị kết quả
        doGet(request, response);
    }
}