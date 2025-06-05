package dk.controller;


import dk.model.entity.bt5.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
public class AuthController {

    @GetMapping("/login")
    public String showLogin(Model model, HttpSession session) {
        // Nếu đã đăng nhập, chuyển hướng đến trang quản lý đơn hàng
        if (session.getAttribute("user") != null) {
            return "redirect:/orders";
        }

        model.addAttribute("user", new User());
        return "login";
    }

    @PostMapping("/login")
    public String login(@ModelAttribute User user, HttpSession session, Model model) {
        // Đăng nhập đơn giản (có thể thay thế bằng logic xác thực thực tế)
        if (user.getUsername() != null && !user.getUsername().trim().isEmpty() &&
                user.getPassword() != null && !user.getPassword().trim().isEmpty()) {

            // Lưu thông tin user vào session
            session.setAttribute("user", user);
            return "redirect:/orders";
        } else {
            model.addAttribute("error", "Vui lòng nhập đầy đủ thông tin đăng nhập");
            return "login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // Xóa toàn bộ session
        return "redirect:/login";
    }
}