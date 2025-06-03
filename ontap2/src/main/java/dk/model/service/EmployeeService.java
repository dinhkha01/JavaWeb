package dk.model.service;

import dk.model.dao.EmployeeImp;
import dk.model.entity.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    private EmployeeImp employeeDao;

    public List<Employee> findAll() {
        return employeeDao.findAll();
    }

    public List<Employee> findAllWithPaging(int page, int size) {
        return employeeDao.findAllWithPaging(page, size);
    }

    public int countAll() {
        return employeeDao.countAll();
    }

    public Employee findById(Integer id) {
        return employeeDao.findById(id);
    }

    public void save(Employee employee) throws Exception {
        try {
            employeeDao.save(employee);
        } catch (RuntimeException e) {
            throw new Exception(e.getMessage());
        }
    }

    public void deleteById(Integer id) {
        employeeDao.deleteById(id);
    }

    public List<Employee> searchByName(String name) {
        return employeeDao.searchByName(name);
    }

    public List<Employee> searchByNameWithPaging(String name, int page, int size) {
        return employeeDao.searchByNameWithPaging(name, page, size);
    }

    public int countSearchResults(String name) {
        return employeeDao.countSearchResults(name);
    }

    public int getTotalPages(int totalRecords, int pageSize) {
        return (int) Math.ceil((double) totalRecords / pageSize);
    }
}