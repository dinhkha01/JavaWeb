// IDepartmentDao.java
package dk.model.dao;

import dk.model.entity.Department;
import java.util.List;

public interface IDepartmentDao extends IGenericDao<Department, Integer> {
    List<Department> searchByName(String name);
    List<Department> getActiveDepartments();
}
