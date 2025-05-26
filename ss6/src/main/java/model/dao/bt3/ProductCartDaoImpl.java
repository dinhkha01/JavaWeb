package model.dao.bt3;

import configs.ConnectionDB;
import model.entity.ProductCart;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductCartDaoImpl implements IProductCartDao {

    @Override
    public List<ProductCart> findAll() {
        List<ProductCart> carts = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = ConnectionDB.openConnection();
            String sql = "SELECT * FROM productCarts ORDER BY id";
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                ProductCart cart = new ProductCart();
                cart.setId(resultSet.getInt("id"));
                cart.setUserId(resultSet.getInt("userId"));
                cart.setProductId(resultSet.getInt("productId"));
                cart.setQuantity(resultSet.getInt("quantity"));
                carts.add(cart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) ConnectionDB.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return carts;
    }

    @Override
    public ProductCart findById(Integer id) {
        ProductCart cart = null;
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = ConnectionDB.openConnection();
            String sql = "SELECT * FROM productCarts WHERE id = ?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                cart = new ProductCart();
                cart.setId(resultSet.getInt("id"));
                cart.setUserId(resultSet.getInt("userId"));
                cart.setProductId(resultSet.getInt("productId"));
                cart.setQuantity(resultSet.getInt("quantity"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) ConnectionDB.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return cart;
    }

    @Override
    public void save(ProductCart cart) {
        if (cart == null) {
            return;
        }

        Connection connection = null;
        CallableStatement statement = null;

        try {
            connection = ConnectionDB.openConnection();

            if (cart.getId() == 0) {
                // Thêm mới
                statement = connection.prepareCall("{CALL AddToCart(?, ?, ?)}");
                statement.setInt(1, cart.getUserId());
                statement.setInt(2, cart.getProductId());
                statement.setInt(3, cart.getQuantity());
            } else {
                // Cập nhật
                statement = connection.prepareCall("{CALL UpdateCartQuantity(?, ?)}");
                statement.setInt(1, cart.getId());
                statement.setInt(2, cart.getQuantity());
            }

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (statement != null) statement.close();
                if (connection != null) ConnectionDB.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void deleteById(Integer id) {
        Connection connection = null;
        CallableStatement statement = null;

        try {
            connection = ConnectionDB.openConnection();
            statement = connection.prepareCall("{CALL RemoveFromCart(?)}");
            statement.setInt(1, id);

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (statement != null) statement.close();
                if (connection != null) ConnectionDB.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Các phương thức bổ sung đặc thù cho ProductCart

    /**
     * Lấy giỏ hàng của user với thông tin sản phẩm
     */
    @Override
    public List<Map<String, Object>> getCartByUserId(int userId) {
        List<Map<String, Object>> cartItems = new ArrayList<>();
        Connection connection = null;
        CallableStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = ConnectionDB.openConnection();
            statement = connection.prepareCall("{CALL GetCartByUserId(?)}");
            statement.setInt(1, userId);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Map<String, Object> item = new HashMap<>();
                item.put("id", resultSet.getInt("id"));
                item.put("userId", resultSet.getInt("userId"));
                item.put("productId", resultSet.getInt("productId"));
                item.put("quantity", resultSet.getInt("quantity"));
                item.put("name", resultSet.getString("name"));
                item.put("price", resultSet.getDouble("price"));
                item.put("imageUrl", resultSet.getString("imageUrl"));
                item.put("totalPrice", resultSet.getDouble("totalPrice"));
                cartItems.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) ConnectionDB.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return cartItems;
    }

    /**
     * Lấy tổng tiền giỏ hàng
     */
    @Override
    public Map<String, Object> getCartTotal(int userId) {
        Map<String, Object> total = new HashMap<>();
        Connection connection = null;
        CallableStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = ConnectionDB.openConnection();
            statement = connection.prepareCall("{CALL GetCartTotal(?)}");
            statement.setInt(1, userId);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                total.put("totalAmount", resultSet.getDouble("totalAmount"));
                total.put("totalItems", resultSet.getInt("totalItems"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) ConnectionDB.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return total;
    }

    /**
     * Xóa tất cả sản phẩm trong giỏ hàng của user
     */
    @Override
    public boolean clearCart(int userId) {
        Connection connection = null;
        CallableStatement statement = null;

        try {
            connection = ConnectionDB.openConnection();
            statement = connection.prepareCall("{CALL ClearCart(?)}");
            statement.setInt(1, userId);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected >= 0; // >= 0 vì có thể cart đã rỗng
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (statement != null) statement.close();
                if (connection != null) ConnectionDB.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Kiểm tra sản phẩm có trong giỏ hàng không
     */
    @Override
    public ProductCart checkProductInCart(int userId, int productId) {
        ProductCart cart = null;
        Connection connection = null;
        CallableStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = ConnectionDB.openConnection();
            statement = connection.prepareCall("{CALL CheckProductInCart(?, ?)}");
            statement.setInt(1, userId);
            statement.setInt(2, productId);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                cart = new ProductCart();
                cart.setId(resultSet.getInt("id"));
                cart.setUserId(resultSet.getInt("userId"));
                cart.setProductId(resultSet.getInt("productId"));
                cart.setQuantity(resultSet.getInt("quantity"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) ConnectionDB.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return cart;
    }
}