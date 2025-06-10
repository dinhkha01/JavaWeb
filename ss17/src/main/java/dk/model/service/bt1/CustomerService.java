package dk.model.service.bt1;

import dk.model.dao.bt1.CustomerDAO;
import dk.model.entity.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CustomerService {
    @Autowired
    private CustomerDAO customerDao;

    @Transactional
    public void registerCustomer(Customer customer) throws ServiceException {
        try {
            // Kiểm tra username đã tồn tại
            if (customerDao.existsByUsername(customer.getUsername())) {
                throw new ServiceException("Tên đăng nhập '" + customer.getUsername() + "' đã được sử dụng. Vui lòng chọn tên khác!");
            }

            // Kiểm tra email đã tồn tại
            if (customerDao.existsByEmail(customer.getEmail())) {
                throw new ServiceException("Email '" + customer.getEmail() + "' đã được đăng ký. Vui lòng sử dụng email khác!");
            }

            // Lưu customer
            customerDao.saveUser(customer);

        } catch (ServiceException e) {
            // Ném lại ServiceException để controller xử lý
            throw e;
        } catch (Exception e) {
            // Bắt các exception khác và chuyển thành ServiceException
            throw new ServiceException("Có lỗi xảy ra trong hệ thống. Vui lòng thử lại sau!");
        }
    }

    /**
     * Xác thực thông tin đăng nhập
     * @param username tên đăng nhập
     * @param password mật khẩu
     * @return Customer nếu thông tin đúng, null nếu sai
     */
    @Transactional(readOnly = true)
    public Customer authenticateCustomer(String username, String password) throws ServiceException {
        try {

            // Tìm customer theo username
            Customer customer = customerDao.findByUsername(username.trim());

            if (customer == null) {
                throw new ServiceException("Tên đăng nhập hoặc mật khẩu không đúng!");
            }

            // Kiểm tra mật khẩu
            if (!password.equals(customer.getPassword())) {
                throw new ServiceException("Tên đăng nhập hoặc mật khẩu không đúng!");
            }

            // Kiểm tra trạng thái tài khoản
            if (!customer.isStatus()) {
                throw new ServiceException("Tài khoản của bạn đã bị khóa. Vui lòng liên hệ quản trị viên!");
            }

            return customer;

        } catch (ServiceException e) {
            throw e;
        } catch (Exception e) {
            throw new ServiceException("Có lỗi xảy ra trong hệ thống. Vui lòng thử lại sau!");
        }
    }

    /**
     * Tìm customer theo username
     */
    @Transactional(readOnly = true)
    public Customer findByUsername(String username) {
        if (username == null || username.trim().isEmpty()) {
            return null;
        }
        return customerDao.findByUsername(username.trim());
    }

    @Transactional(readOnly = true)
    public Customer getCustomerById(Long id) {
        if (id == null) {
            return null;
        }
        return customerDao.getUserById(id);
    }

    @Transactional(readOnly = true)
    public boolean isUsernameExists(String username) {
        if (username == null || username.trim().isEmpty()) {
            return false;
        }
        return customerDao.existsByUsername(username.trim());
    }

    @Transactional(readOnly = true)
    public boolean isEmailExists(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return customerDao.existsByEmail(email.trim());
    }



    /**
     * Custom Exception cho Service layer
     */
    public static class ServiceException extends Exception {
        public ServiceException(String message) {
            super(message);
        }

        public ServiceException(String message, Throwable cause) {
            super(message, cause);
        }
    }
}