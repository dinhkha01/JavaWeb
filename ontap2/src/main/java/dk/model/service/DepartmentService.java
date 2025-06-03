package dk.model.service;

import dk.model.dao.DepartmentImp;
import dk.model.entity.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    private DepartmentImp departmentDao;

    public List<Department> findAll() {
        return departmentDao.findAll();
    }

    public Department findById(Integer id) {
        return departmentDao.findById(id);
    }

    public void save(Department department) {
        departmentDao.save(department);
    }

    public void deleteById(Integer id) throws Exception {
        try {
            departmentDao.deleteById(id);
        } catch (RuntimeException e) {
            throw new Exception(e.getMessage());
        }
    }

    public List<Department> searchByName(String name) {
        return departmentDao.searchByName(name);
    }

    public List<Department> getActiveDepartments() {
        return departmentDao.getActiveDepartments();
    }
}