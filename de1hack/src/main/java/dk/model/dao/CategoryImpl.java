package dk.model.dao;

import dk.configs.ConnectionDB;
import dk.model.entity.Category;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class CategoryImpl implements ICategoryDao {

    @Override
    public List<Category> findAll() {
        List<Category> categories = new ArrayList<>();
        Connection conn = null;
        CallableStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionDB.openConnection();
            stmt = conn.prepareCall("{CALL sp_GetAllCategories()}");
            rs = stmt.executeQuery();

            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
                category.setStatus(rs.getBoolean("status"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                ConnectionDB.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return categories;
    }

    @Override
    public Category findById(Integer id) {
        Category category = null;
        Connection conn = null;
        CallableStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionDB.openConnection();
            stmt = conn.prepareCall("{CALL sp_GetCategoryById(?)}");
            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            if (rs.next()) {
                category = new Category();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
                category.setStatus(rs.getBoolean("status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                ConnectionDB.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return category;
    }

    @Override
    public void save(Category category) {
        Connection conn = null;
        CallableStatement stmt = null;

        try {
            conn = ConnectionDB.openConnection();

            if (category.getCategoryId() == null) {
                // Add new category
                stmt = conn.prepareCall("{CALL sp_AddCategory(?, ?)}");
                stmt.setString(1, category.getCategoryName());
                stmt.setString(2, category.getDescription());
            } else {
                // Update category
                stmt = conn.prepareCall("{CALL sp_UpdateCategory(?, ?, ?, ?)}");
                stmt.setInt(1, category.getCategoryId());
                stmt.setString(2, category.getCategoryName());
                stmt.setString(3, category.getDescription());
                stmt.setBoolean(4, category.getStatus());
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
            stmt = conn.prepareCall("{CALL sp_DeleteCategory(?)}");
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
    public List<Category> searchByName(String name) {
        List<Category> categories = new ArrayList<>();
        Connection conn = null;
        CallableStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionDB.openConnection();
            stmt = conn.prepareCall("{CALL sp_SearchCategoriesByName(?)}");
            stmt.setString(1, name);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
                category.setStatus(rs.getBoolean("status"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                ConnectionDB.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return categories;
    }

    @Override
    public boolean canDelete(Integer categoryId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionDB.openConnection();
            stmt = conn.prepareStatement("SELECT COUNT(*) FROM product WHERE category_id = ?");
            stmt.setInt(1, categoryId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) == 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                ConnectionDB.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public List<Category> getActiveCategories() {
        List<Category> categories = new ArrayList<>();
        Connection conn = null;
        CallableStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionDB.openConnection();
            stmt = conn.prepareCall("{CALL sp_GetActiveCategories()}");
            rs = stmt.executeQuery();

            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                ConnectionDB.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return categories;
    }
}