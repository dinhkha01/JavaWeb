package dk.model.dao;

import dk.configs.ConnectionDB;
import dk.model.entity.Department;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class DepartmentImp implements IDepartmentDao {

    @Override
    public List<Department> findAll() {
        List<Department> departments = new ArrayList<>();
        try (Connection connection = ConnectionDB.openConnection();
             CallableStatement stmt = connection.prepareCall("{CALL sp_GetAllDepartments()}")) {

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Department dept = new Department();
                dept.setDepartmentId(rs.getInt("department_id"));
                dept.setDepartmentName(rs.getString("department_name"));
                dept.setDescription(rs.getString("description"));
                dept.setStatus(rs.getBoolean("status"));
                departments.add(dept);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return departments;
    }

    @Override
    public Department findById(Integer id) {
        Department department = null;
        try (Connection connection = ConnectionDB.openConnection();
             CallableStatement stmt = connection.prepareCall("{CALL sp_GetDepartmentById(?)}")) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                department = new Department();
                department.setDepartmentId(rs.getInt("department_id"));
                department.setDepartmentName(rs.getString("department_name"));
                department.setDescription(rs.getString("description"));
                department.setStatus(rs.getBoolean("status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return department;
    }

    @Override
    public void save(Department department) {
        if (department.getDepartmentId() == 0) {
            // Thêm mới
            add(department);
        } else {
            // Cập nhật
            update(department);
        }
    }

    private void add(Department department) {
        try (Connection connection = ConnectionDB.openConnection();
             CallableStatement stmt = connection.prepareCall("{CALL sp_AddDepartment(?, ?)}")) {

            stmt.setString(1, department.getDepartmentName());
            stmt.setString(2, department.getDescription());
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    private void update(Department department) {
        try (Connection connection = ConnectionDB.openConnection();
             CallableStatement stmt = connection.prepareCall("{CALL sp_UpdateDepartment(?, ?, ?, ?)}")) {

            stmt.setInt(1, department.getDepartmentId());
            stmt.setString(2, department.getDepartmentName());
            stmt.setString(3, department.getDescription());
            stmt.setBoolean(4, department.isStatus());
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    @Override
    public void deleteById(Integer id) {
        try (Connection connection = ConnectionDB.openConnection();
             CallableStatement stmt = connection.prepareCall("{CALL sp_DeleteDepartment(?)}")) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public List<Department> searchByName(String name) {
        List<Department> departments = new ArrayList<>();
        try (Connection connection = ConnectionDB.openConnection();
             CallableStatement stmt = connection.prepareCall("{CALL sp_SearchDepartmentsByName(?)}")) {

            stmt.setString(1, name);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Department dept = new Department();
                dept.setDepartmentId(rs.getInt("department_id"));
                dept.setDepartmentName(rs.getString("department_name"));
                dept.setDescription(rs.getString("description"));
                dept.setStatus(rs.getBoolean("status"));
                departments.add(dept);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return departments;
    }

    public List<Department> getActiveDepartments() {
        List<Department> departments = new ArrayList<>();
        try (Connection connection = ConnectionDB.openConnection();
             CallableStatement stmt = connection.prepareCall("{CALL sp_GetActiveDepartments()}")) {

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Department dept = new Department();
                dept.setDepartmentId(rs.getInt("department_id"));
                dept.setDepartmentName(rs.getString("department_name"));
                departments.add(dept);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return departments;
    }
}