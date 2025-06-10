package dk.model.dao.bt3;

import dk.model.entity.Customer;
import dk.model.entity.Product;

import java.util.List;

public interface ProductDAO {
    void saveUser(Product product);
    Product getUserById(Long id);
    List<Product> getAllUsers();
    void deleteUser(Long id);
}
