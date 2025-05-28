package dk.model.service;

import dk.model.dao.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {
    @Autowired
    private ProductRepository productRepository;

    public List<String> getAllProducts() {
        return productRepository.getAll();
    }
}
