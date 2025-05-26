package model.dao.bt3;

import model.dao.IGenericDao;
import model.entity.ProductCart;

public interface IProductCartDao extends IGenericDao<ProductCart, Integer> {

    java.util.List<java.util.Map<String, Object>> getCartByUserId(int userId);
    java.util.Map<String, Object> getCartTotal(int userId);
    boolean clearCart(int userId);
    ProductCart checkProductInCart(int userId, int productId);
}