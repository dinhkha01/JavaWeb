package dk.model.service;


import dk.model.entity.bt6.User;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserService {

    // Mô phỏng database bằng List (trong thực tế sẽ sử dụng JPA/Hibernate)
    private List<User> users = new ArrayList<>();

    // Lưu người dùng mới
    public void saveUser(User user) {
        // Trong thực tế, mật khẩu nên được mã hóa trước khi lưu
        // user.setPassword(passwordEncoder.encode(user.getPassword()));
        users.add(user);
    }

    // Kiểm tra username đã tồn tại
    public boolean isUsernameExists(String username) {
        return users.stream()
                .anyMatch(user -> user.getUsername().equalsIgnoreCase(username));
    }

    // Kiểm tra email đã tồn tại
    public boolean isEmailExists(String email) {
        return users.stream()
                .anyMatch(user -> user.getEmail().equalsIgnoreCase(email));
    }

    // Lấy tất cả người dùng
    public List<User> getAllUsers() {
        return new ArrayList<>(users);
    }

    // Tìm người dùng theo username
    public User findByUsername(String username) {
        return users.stream()
                .filter(user -> user.getUsername().equalsIgnoreCase(username))
                .findFirst()
                .orElse(null);
    }

    // Tìm người dùng theo email
    public User findByEmail(String email) {
        return users.stream()
                .filter(user -> user.getEmail().equalsIgnoreCase(email))
                .findFirst()
                .orElse(null);
    }

    // Đếm số lượng người dùng
    public int getUserCount() {
        return users.size();
    }
}