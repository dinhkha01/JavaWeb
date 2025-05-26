package model.service;

import model.dao.bt3.IProductCartDao;
import model.dao.bt3.ProductCartDaoImpl;
import model.entity.ProductCart;
import java.util.List;
import java.util.Map;

public class ProductCartService {
    private IProductCartDao productCartDao;
    private ProductService productService;

    public ProductCartService() {
        this.productCartDao = new ProductCartDaoImpl();
        this.productService = new ProductService();
    }

    /**
     * Lấy tất cả items trong giỏ hàng
     */
    public List<ProductCart> getAllCartItems() {
        return productCartDao.findAll();
    }

    /**
     * Lấy cart item theo ID
     */
    public ProductCart getCartItemById(int id) {
        if (id <= 0) {
            return null;
        }
        return productCartDao.findById(id);
    }

    /**
     * Thêm sản phẩm vào giỏ hàng
     */
    public boolean addToCart(int userId, int productId, int quantity) {
        // Validate input
        if (userId <= 0 || productId <= 0 || quantity <= 0) {
            return false;
        }

        // Kiểm tra sản phẩm có tồn tại không
        if (!productService.isProductExists(productId)) {
            return false;
        }

        try {
            ProductCart cart = new ProductCart();
            cart.setId(0); // Đặt id = 0 để báo hiệu đây là thêm mới
            cart.setUserId(userId);
            cart.setProductId(productId);
            cart.setQuantity(quantity);

            productCartDao.save(cart);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Cập nhật số lượng sản phẩm trong giỏ hàng
     */
    public boolean updateCartQuantity(int cartId, int quantity) {
        if (cartId <= 0 || quantity <= 0) {
            return false;
        }

        ProductCart cart = productCartDao.findById(cartId);
        if (cart == null) {
            return false;
        }

        try {
            cart.setQuantity(quantity);
            productCartDao.save(cart);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Xóa sản phẩm khỏi giỏ hàng
     */
    public boolean removeFromCart(int cartId) {
        if (cartId <= 0) {
            return false;
        }

        try {
            productCartDao.deleteById(cartId);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Lấy giỏ hàng của user (với thông tin sản phẩm)
     */
    public List<Map<String, Object>> getCartByUserId(int userId) {
        if (userId <= 0) {
            return null;
        }
        return productCartDao.getCartByUserId(userId);
    }

    /**
     * Lấy tổng tiền giỏ hàng
     */
    public Map<String, Object> getCartTotal(int userId) {
        if (userId <= 0) {
            return null;
        }
        return productCartDao.getCartTotal(userId);
    }

    /**
     * Xóa tất cả sản phẩm trong giỏ hàng của user
     */
    public boolean clearCart(int userId) {
        if (userId <= 0) {
            return false;
        }
        return productCartDao.clearCart(userId);
    }

    /**
     * Kiểm tra sản phẩm có trong giỏ hàng không
     */
    public ProductCart checkProductInCart(int userId, int productId) {
        if (userId <= 0 || productId <= 0) {
            return null;
        }
        return productCartDao.checkProductInCart(userId, productId);
    }

    /**
     * Kiểm tra giỏ hàng có rỗng không
     */
    public boolean isCartEmpty(int userId) {
        if (userId <= 0) {
            return true;
        }

        List<Map<String, Object>> cartItems = getCartByUserId(userId);
        return cartItems == null || cartItems.isEmpty();
    }

    /**
     * Đếm số lượng items trong giỏ hàng
     */
    public int getCartItemCount(int userId) {
        if (userId <= 0) {
            return 0;
        }

        Map<String, Object> total = getCartTotal(userId);
        if (total != null && total.containsKey("totalItems")) {
            Object totalItems = total.get("totalItems");
            if (totalItems instanceof Integer) {
                return (Integer) totalItems;
            }
        }
        return 0;
    }

    /**
     * Lấy tổng tiền giỏ hàng
     */
    public double getCartTotalAmount(int userId) {
        if (userId <= 0) {
            return 0.0;
        }

        Map<String, Object> total = getCartTotal(userId);
        if (total != null && total.containsKey("totalAmount")) {
            Object totalAmount = total.get("totalAmount");
            if (totalAmount instanceof Double) {
                return (Double) totalAmount;
            } else if (totalAmount instanceof Number) {
                return ((Number) totalAmount).doubleValue();
            }
        }
        return 0.0;
    }

    /**
     * Thêm hoặc cập nhật sản phẩm trong giỏ hàng (smart add)
     * Nếu sản phẩm đã có trong giỏ thì tăng số lượng, nếu chưa có thì thêm mới
     */
    public boolean addOrUpdateCart(int userId, int productId, int quantity) {
        if (userId <= 0 || productId <= 0 || quantity <= 0) {
            return false;
        }

        // Kiểm tra sản phẩm có tồn tại không
        if (!productService.isProductExists(productId)) {
            return false;
        }

        // Kiểm tra sản phẩm có trong giỏ hàng chưa
        ProductCart existingCart = checkProductInCart(userId, productId);

        if (existingCart != null) {
            // Nếu đã có thì cập nhật số lượng
            int newQuantity = existingCart.getQuantity() + quantity;
            return updateCartQuantity(existingCart.getId(), newQuantity);
        } else {
            // Nếu chưa có thì thêm mới
            return addToCart(userId, productId, quantity);
        }
    }
}