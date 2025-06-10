package dk.model.dao.bt1;

import dk.model.entity.Customer;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.exception.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public class CustomerImpl implements CustomerDAO {
    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void saveUser(Customer customer) {
        try {
            Session session = sessionFactory.getCurrentSession();
            session.saveOrUpdate(customer);
            // Đảm bảo flush để bắt lỗi constraint ngay lập tức
            session.flush();

        } catch (ConstraintViolationException e) {
            // Xử lý lỗi constraint từ database
            String constraintName = e.getConstraintName();
            if (constraintName != null) {
                if (constraintName.toLowerCase().contains("username")) {
                    throw new DataIntegrityViolationException("Tên đăng nhập đã tồn tại");
                } else if (constraintName.toLowerCase().contains("email")) {
                    throw new DataIntegrityViolationException("Email đã được sử dụng");
                }
            }
            throw new DataIntegrityViolationException("Dữ liệu không hợp lệ: " + e.getMessage());

        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi lưu dữ liệu: " + e.getMessage(), e);
        }
    }

    @Override
    @Transactional(readOnly = true)
    public Customer getUserById(Long id) {
        try {
            Session session = sessionFactory.getCurrentSession();
            return session.get(Customer.class, id);
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi tìm người dùng theo ID: " + e.getMessage(), e);
        }
    }

    @Override
    @Transactional(readOnly = true)
    public List<Customer> getAllUsers() {
        try {
            Session session = sessionFactory.getCurrentSession();
            return session.createQuery("from Customer", Customer.class).list();
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi lấy danh sách người dùng: " + e.getMessage(), e);
        }
    }

    @Override
    public void deleteUser(Long id) {
        try {
            Session session = sessionFactory.getCurrentSession();
            Customer user = session.byId(Customer.class).load(id);
            if (user != null) {
                session.delete(user);
                session.flush();
            }
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi xóa người dùng: " + e.getMessage(), e);
        }
    }

    @Override
    @Transactional(readOnly = true)
    public Customer findByUsername(String username) {
        try {
            if (username == null || username.trim().isEmpty()) {
                return null;
            }

            Session session = sessionFactory.getCurrentSession();
            return session.createQuery("FROM Customer c WHERE c.username = :username", Customer.class)
                    .setParameter("username", username.trim())
                    .uniqueResult();

        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi tìm người dùng theo username: " + e.getMessage(), e);
        }
    }

    @Override
    @Transactional(readOnly = true)
    public Customer findByEmail(String email) {
        try {
            if (email == null || email.trim().isEmpty()) {
                return null;
            }

            Session session = sessionFactory.getCurrentSession();
            return session.createQuery("FROM Customer c WHERE c.email = :email", Customer.class)
                    .setParameter("email", email.trim())
                    .uniqueResult();

        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi tìm người dùng theo email: " + e.getMessage(), e);
        }
    }

    @Override
    @Transactional(readOnly = true)
    public boolean existsByUsername(String username) {
        try {
            return findByUsername(username) != null;
        } catch (Exception e) {
            // Nếu có lỗi khi kiểm tra, coi như không tồn tại để tránh block user
            return false;
        }
    }

    @Override
    @Transactional(readOnly = true)
    public boolean existsByEmail(String email) {
        try {
            return findByEmail(email) != null;
        } catch (Exception e) {
            // Nếu có lỗi khi kiểm tra, coi như không tồn tại để tránh block user
            return false;
        }
    }
}