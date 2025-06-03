package dk.model.service;

import dk.model.dao.ProductImpl;
import dk.model.entity.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {

    @Autowired
    private ProductImpl productDao;

    public List<Product> findAll() {
        return productDao.findAll();
    }

    public List<Product> findAllWithPaging(int page, int size) {
        return productDao.findAllWithPaging(page, size);
    }

    public Product findById(Integer id) {
        return productDao.findById(id);
    }

    public void save(Product product) {
        productDao.save(product);
    }

    public void deleteById(Integer id) {
        productDao.deleteById(id);
    }

    public List<Product> searchByName(String name) {
        return productDao.searchByName(name);
    }

    public List<Product> searchByNameWithPaging(String name, int page, int size) {
        return productDao.searchByNameWithPaging(name, page, size);
    }

    public int getTotalProducts() {
        return productDao.getTotalProducts();
    }

    public int getTotalSearchProducts(String name) {
        return productDao.getTotalSearchProducts(name);
    }

    public int getTotalPages(int totalRecords, int size) {
        return (int) Math.ceil((double) totalRecords / size);
    }
}