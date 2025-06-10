package dk.model.dao.bt1;

import dk.model.entity.Customer;

import java.util.List;

public interface CustomerDAO {
    void saveUser(Customer user);
    Customer getUserById(Long id);
    List<Customer> getAllUsers();
    void deleteUser(Long id);

    Customer findByUsername(String username);
    Customer findByEmail(String email);
    boolean existsByUsername(String username);
    boolean existsByEmail(String email);
}