package dk.model.dao;

import dk.configs.ConnectionDB;
import dk.model.entity.Employee;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Repository
public class EmployeeImp implements IEmployeeDao {

    public List<Employee> findAll() {
        List<Employee> employees = new ArrayList<>();
        try (Connection connection = ConnectionDB.openConnection();
             CallableStatement stmt = connection.prepareCall("{CALL sp_GetAllEmployees()}")) {

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Employee emp = mapResultSetToEmployee(rs);
                employees.add(emp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }

    public List<Employee> findAllWithPaging(int page, int size) {
        List<Employee> employees = new ArrayList<>();
        try (Connection connection = ConnectionDB.openConnection();
             CallableStatement stmt = connection.prepareCall("{CALL sp_GetEmployeesWithPaging(?, ?)}")) {

            stmt.setInt(1, page);
            stmt.setInt(2, size);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Employee emp = mapResultSetToEmployee(rs);
                employees.add(emp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }

    public int countAll() {
        try (Connection connection = ConnectionDB.openConnection();
             CallableStatement stmt = connection.prepareCall("{CALL sp_CountAllEmployees()}")) {

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("total_employees");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Employee findById(Integer id) {
        Employee employee = null;
        try (Connection connection = ConnectionDB.openConnection();
             CallableStatement stmt = connection.prepareCall("{CALL sp_GetEmployeeById(?)}")) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                employee = mapResultSetToEmployee(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employee;
    }

    public void save(Employee employee) {
        if (employee.getEmployeeId() == 0) {
            add(employee);
        } else {
            update(employee);
        }
    }

    private void add(Employee employee) {
        try (Connection connection = ConnectionDB.openConnection();
             CallableStatement stmt = connection.prepareCall("{CALL sp_AddEmployee(?, ?, ?, ?, ?)}")) {

            stmt.setString(1, employee.getFullName());
            stmt.setString(2, employee.getEmail());
            stmt.setString(3, employee.getPhoneNumber());
            stmt.setString(4, employee.getAvatarUrl());
            stmt.setInt(5, employee.getDepartmentId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    private void update(Employee employee) {
        try (Connection connection = ConnectionDB.openConnection();
             CallableStatement stmt = connection.prepareCall("{CALL sp_UpdateEmployee(?, ?, ?, ?, ?, ?, ?)}")) {

            stmt.setInt(1, employee.getEmployeeId());
            stmt.setString(2, employee.getFullName());
            stmt.setString(3, employee.getEmail());
            stmt.setString(4, employee.getPhoneNumber());
            stmt.setString(5, employee.getAvatarUrl());
            stmt.setBoolean(6, employee.isStatus());
            stmt.setInt(7, employee.getDepartmentId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public void deleteById(Integer id) {
        try (Connection connection = ConnectionDB.openConnection();
             CallableStatement stmt = connection.prepareCall("{CALL sp_DeleteEmployee(?)}")) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Employee> searchByName(String name) {
        List<Employee> employees = new ArrayList<>();
        try (Connection connection = ConnectionDB.openConnection();
             CallableStatement stmt = connection.prepareCall("{CALL sp_SearchEmployeesByName(?)}")) {

            stmt.setString(1, name);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Employee emp = mapResultSetToEmployee(rs);
                employees.add(emp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }

    public List<Employee> searchByNameWithPaging(String name, int page, int size) {
        List<Employee> employees = new ArrayList<>();
        try (Connection connection = ConnectionDB.openConnection();
             CallableStatement stmt = connection.prepareCall("{CALL sp_SearchEmployeesByNameWithPaging(?, ?, ?)}")) {

            stmt.setString(1, name);
            stmt.setInt(2, page);
            stmt.setInt(3, size);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Employee emp = mapResultSetToEmployee(rs);
                employees.add(emp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }

    public int countSearchResults(String name) {
        try (Connection connection = ConnectionDB.openConnection();
             CallableStatement stmt = connection.prepareCall("{CALL sp_CountSearchEmployees(?)}")) {

            stmt.setString(1, name);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("total_employees");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private Employee mapResultSetToEmployee(ResultSet rs) throws SQLException {
        Employee emp = new Employee();
        emp.setEmployeeId(rs.getInt("employee_id"));
        emp.setFullName(rs.getString("full_name"));
        emp.setEmail(rs.getString("email"));
        emp.setPhoneNumber(rs.getString("phone_number"));
        emp.setAvatarUrl(rs.getString("avatar_url"));
        emp.setStatus(rs.getBoolean("status"));

        Timestamp timestamp = rs.getTimestamp("created_at");
        if (timestamp != null) {
            emp.setCreatedAt(timestamp.toLocalDateTime());
        }

        emp.setDepartmentId(rs.getInt("department_id"));
        emp.setDepartmentName(rs.getString("department_name"));
        return emp;
    }
}