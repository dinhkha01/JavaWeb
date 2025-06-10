package dk.model.service.bt3;

import dk.model.dao.bt3.ProductDAO;
import dk.model.entity.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {

    @Autowired
    private ProductDAO productDAO;

    public void saveProduct(Product product) {
        productDAO.saveProduct(product);
    }

    public Product getProductById(Long id) {
        return productDAO.getProductById(id);
    }

    public List<Product> getAllProducts() {
        return productDAO.getAllProducts();
    }

    public void deleteProduct(Long id) {
        productDAO.deleteProduct(id);
    }

    public Page<Product> getProductsWithPagination(int page, int size) {
        return productDAO.findAllWithPagination(page, size);
    }

    public long getTotalProducts() {
        return productDAO.getTotalProducts();
    }
}