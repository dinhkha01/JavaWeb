package dk.model.service.bt1;

import dk.model.dao.bt1.CustomerDAO;
import dk.model.entity.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CustomerService {
    @Autowired
    private CustomerDAO customerDao;

    public void registerCustomer(Customer customer) {
        // Kiểm tra username đã tồn tại
        if (customerDao.existsByUsername(customer.getUsername())) {
            throw new RuntimeException("Tên đăng nhập đã tồn tại!");
        }

        // Kiểm tra email đã tồn tại
        if (customerDao.existsByEmail(customer.getEmail())) {
            throw new RuntimeException("Email đã được sử dụng!");
        }

        customerDao.saveUser(customer);
    }

    @Transactional(readOnly = true)
    public Customer getCustomerById(Long id) {
        return customerDao.getUserById(id);
    }

    @Transactional(readOnly = true)
    public boolean isUsernameExists(String username) {
        return customerDao.existsByUsername(username);
    }

    @Transactional(readOnly = true)
    public boolean isEmailExists(String email) {
        return customerDao.existsByEmail(email);
    }
}