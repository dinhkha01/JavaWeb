package dk.model.dao;

import dk.model.entity.Category;
import java.util.List;

public interface ICategoryDao extends IGenericDao<Category, Integer> {
    List<Category> searchByName(String name);
    boolean canDelete(Integer categoryId);
}