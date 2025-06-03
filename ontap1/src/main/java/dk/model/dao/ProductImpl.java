package dk.model.dao;

import dk.configs.ConnectionDB;
import dk.model.entity.Product;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class ProductImpl implements IProductDao {

    @Override
    public List<Product> findAll() {
        List<Product> products = new ArrayList<>();
        Connection conn = null;
        CallableStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionDB.openConnection();
            stmt = conn.prepareCall("{CALL sp_GetAllProducts()}");
            rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = mapResultSetToProduct(rs);
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt, conn);
        }
        return products;
    }

    @Override
    public List<Product> findAllWithPaging(int page, int size) {
        List<Product> products = new ArrayList<>();
        Connection conn = null;
        CallableStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionDB.openConnection();
            stmt = conn.prepareCall("{CALL sp_GetProductsWithPaging(?, ?)}");
            stmt.setInt(1, page);
            stmt.setInt(2, size);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = mapResultSetToProduct(rs);
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt, conn);
        }
        return products;
    }

    @Override
    public Product findById(Integer id) {
        Product product = null;
        Connection conn = null;
        CallableStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionDB.openConnection();
            stmt = conn.prepareCall("{CALL sp_GetProductById(?)}");
            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            if (rs.next()) {
                product = mapResultSetToProduct(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt, conn);
        }
        return product;
    }

    @Override
    public void save(Product product) {
        Connection conn = null;
        CallableStatement stmt = null;

        try {
            conn = ConnectionDB.openConnection();

            if (product.getProductId() == null) {
                // Add new product
                stmt = conn.prepareCall("{CALL sp_AddProduct(?, ?, ?, ?, ?)}");
                stmt.setString(1, product.getProductName());
                stmt.setString(2, product.getDescription());
                stmt.setDouble(3, product.getPrice());
                stmt.setString(4, product.getImageUrl());
                stmt.setInt(5, product.getCategoryId());
            } else {
                // Update product
                stmt = conn.prepareCall("{CALL sp_UpdateProduct(?, ?, ?, ?, ?, ?, ?)}");
                stmt.setInt(1, product.getProductId());
                stmt.setString(2, product.getProductName());
                stmt.setString(3, product.getDescription());
                stmt.setDouble(4, product.getPrice());
                stmt.setString(5, product.getImageUrl());
                stmt.setBoolean(6, product.getStatus());
                stmt.setInt(7, product.getCategoryId());
            }

            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        } finally {
            try {
                if (stmt != null) stmt.close();
                ConnectionDB.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void deleteById(Integer id) {
        Connection conn = null;
        CallableStatement stmt = null;

        try {
            conn = ConnectionDB.openConnection();
            stmt = conn.prepareCall("{CALL sp_DeleteProduct(?)}");
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        } finally {
            try {
                if (stmt != null) stmt.close();
                ConnectionDB.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public List<Product> searchByName(String name) {
        List<Product> products = new ArrayList<>();
        Connection conn = null;
        CallableStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionDB.openConnection();
            stmt = conn.prepareCall("{CALL sp_SearchProductsByName(?)}");
            stmt.setString(1, name);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = mapResultSetToProduct(rs);
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt, conn);
        }
        return products;
    }

    @Override
    public List<Product> searchByNameWithPaging(String name, int page, int size) {
        List<Product> products = new ArrayList<>();
        Connection conn = null;
        CallableStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionDB.openConnection();
            stmt = conn.prepareCall("{CALL sp_SearchProductsByNameWithPaging(?, ?, ?)}");
            stmt.setString(1, name);
            stmt.setInt(2, page);
            stmt.setInt(3, size);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = mapResultSetToProduct(rs);
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt, conn);
        }
        return products;
    }

    @Override
    public int getTotalProducts() {
        Connection conn = null;
        CallableStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionDB.openConnection();
            stmt = conn.prepareCall("{CALL sp_CountAllProducts()}");
            rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("total_products");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt, conn);
        }
        return 0;
    }

    @Override
    public int getTotalSearchProducts(String name) {
        Connection conn = null;
        CallableStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionDB.openConnection();
            stmt = conn.prepareCall("{CALL sp_CountSearchProducts(?)}");
            stmt.setString(1, name);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("total_products");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt, conn);
        }
        return 0;
    }

    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setProductId(rs.getInt("product_id"));
        product.setProductName(rs.getString("product_name"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getDouble("price"));
        product.setImageUrl(rs.getString("image_url"));
        product.setStatus(rs.getBoolean("status"));

        Timestamp timestamp = rs.getTimestamp("created_at");
        if (timestamp != null) {
            product.setCreatedAt(timestamp.toLocalDateTime());
        }

        product.setCategoryId(rs.getInt("category_id"));
        product.setCategoryName(rs.getString("category_name"));

        return product;
    }

    private void closeResources(ResultSet rs, Statement stmt, Connection conn) {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            ConnectionDB.closeConnection(conn);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}