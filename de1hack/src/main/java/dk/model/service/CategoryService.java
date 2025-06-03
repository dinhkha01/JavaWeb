package dk.model.service;

import dk.model.dao.CategoryImpl;
import dk.model.entity.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService {

    @Autowired
    private CategoryImpl categoryDao;

    public List<Category> findAll() {
        return categoryDao.findAll();
    }

    public Category findById(Integer id) {
        return categoryDao.findById(id);
    }

    public void save(Category category) {
        categoryDao.save(category);
    }

    public void deleteById(Integer id) {
        categoryDao.deleteById(id);
    }

    public List<Category> searchByName(String name) {
        return categoryDao.searchByName(name);
    }

    public boolean canDelete(Integer categoryId) {
        return categoryDao.canDelete(categoryId);
    }

    public List<Category> getActiveCategories() {
        return categoryDao.getActiveCategories();
    }
}