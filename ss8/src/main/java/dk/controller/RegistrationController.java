package dk.controller;


import dk.model.entity.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

@Controller
public class RegistrationController {
    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    private static final Pattern PHONE_PATTERN =
            Pattern.compile("^0[0-9]{9,10}$");

    // Hiển thị form đăng ký
    @GetMapping("/registration")
    public String showRegistrationForm(Model model) {
        model.addAttribute("user", new User());
        return "registration";
    }

    // Xử lý form đăng ký
    @PostMapping("/registration")
    public String processRegistration(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("phone") String phone,
            Model model) {

        User user = new User(name, email, phone);
        Map<String, String> errors = validateUser(user);

        // Nếu có lỗi, trả về form với thông báo lỗi
        if (!errors.isEmpty()) {
            model.addAttribute("user", user);
            model.addAttribute("errors", errors);
            return "registration";
        }

        // Nếu không có lỗi, chuyển đến trang kết quả
        model.addAttribute("user", user);
        model.addAttribute("message", "Đăng ký thành công!");
        return "result";
    }

    // Phương thức kiểm tra tính hợp lệ của dữ liệu
    private Map<String, String> validateUser(User user) {
        Map<String, String> errors = new HashMap<>();

        // Kiểm tra tên
        if (user.getName() == null || user.getName().trim().isEmpty()) {
            errors.put("name", "Vui lòng nhập tên người dùng");
        } else if (user.getName().trim().length() < 2) {
            errors.put("name", "Tên phải có ít nhất 2 ký tự");
        }

        // Kiểm tra email
        if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            errors.put("email", "Vui lòng nhập địa chỉ email");
        } else if (!EMAIL_PATTERN.matcher(user.getEmail().trim()).matches()) {
            errors.put("email", "Địa chỉ email không hợp lệ");
        }

        // Kiểm tra số điện thoại
        if (user.getPhone() == null || user.getPhone().trim().isEmpty()) {
            errors.put("phone", "Vui lòng nhập số điện thoại");
        } else if (!PHONE_PATTERN.matcher(user.getPhone().trim()).matches()) {
            errors.put("phone", "Số điện thoại không hợp lệ (phải bắt đầu bằng 0 và có 10-11 số)");
        }

        return errors;
    }
}