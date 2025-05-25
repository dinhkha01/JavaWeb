package model.service.bt2;

import model.dao.bt2.UserDaoImpl;
import model.entity.User;

public class UserService {
    private UserDaoImpl userDao;

    public UserService() {
        this.userDao = new UserDaoImpl();
    }

    // Xác thực đăng nhập
    public User authenticateUser(String email, String password) {
        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            return null;
        }
        return userDao.findByEmailAndPassword(email.trim(), password);
    }

    // Đăng ký tài khoản mới
    public boolean registerUser(User user) {
        if (user == null || user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            return false;
        }

        // Kiểm tra email đã tồn tại
        if (userDao.isEmailExists(user.getEmail().trim())) {
            return false;
        }

        // Lưu user mới
        try {
            userDao.save(user);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Kiểm tra email đã tồn tại
    public boolean isEmailExists(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return userDao.isEmailExists(email.trim());
    }
}