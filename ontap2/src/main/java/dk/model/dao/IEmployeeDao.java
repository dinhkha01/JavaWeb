package dk.model.dao;

import dk.model.entity.Employee;
import java.util.List;

public interface IEmployeeDao {
    List<Employee> findAll();
    List<Employee> findAllWithPaging(int page, int size);
    int countAll();
    Employee findById(Integer id);
    void save(Employee employee);
    void deleteById(Integer id);
    List<Employee> searchByName(String name);
    List<Employee> searchByNameWithPaging(String name, int page, int size);
    int countSearchResults(String name);
}