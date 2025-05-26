package model.dao.bt3;

import configs.ConnectionDB;
import model.entity.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDaoImpl implements IProductDao {

    @Override
    public List<Product> findAll() {
        List<Product> products = new ArrayList<>();
        Connection connection = null;
        CallableStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = ConnectionDB.openConnection();
            statement = connection.prepareCall("{CALL GetAllProducts()}");
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Product product = new Product();
                product.setId(resultSet.getInt("id"));
                product.setName(resultSet.getString("name"));
                product.setPrice(resultSet.getDouble("price"));
                product.setImageUrl(resultSet.getString("imageUrl"));
                products.add(product);
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
        return products;
    }

    @Override
    public Product findById(Integer id) {
        Product product = null;
        Connection connection = null;
        CallableStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = ConnectionDB.openConnection();
            statement = connection.prepareCall("{CALL GetProductById(?)}");
            statement.setInt(1, id);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                product = new Product();
                product.setId(resultSet.getInt("id"));
                product.setName(resultSet.getString("name"));
                product.setPrice(resultSet.getDouble("price"));
                product.setImageUrl(resultSet.getString("imageUrl"));
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
        return product;
    }

    @Override
    public void save(Product product) {
        if (product == null) {
            return;
        }

        Connection connection = null;
        CallableStatement statement = null;

        try {
            connection = ConnectionDB.openConnection();

            if (product.getId() == 0) {
                // Thêm mới
                statement = connection.prepareCall("{CALL AddProduct(?, ?, ?)}");
                statement.setString(1, product.getName());
                statement.setDouble(2, product.getPrice());
                statement.setString(3, product.getImageUrl());
            } else {
                // Cập nhật
                statement = connection.prepareCall("{CALL UpdateProduct(?, ?, ?, ?)}");
                statement.setInt(1, product.getId());
                statement.setString(2, product.getName());
                statement.setDouble(3, product.getPrice());
                statement.setString(4, product.getImageUrl());
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
            statement = connection.prepareCall("{CALL DeleteProduct(?)}");
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
}