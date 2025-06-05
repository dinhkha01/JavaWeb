package dk.controller;


import dk.model.entity.bt6.User;

import dk.model.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Locale;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private MessageSource messageSource;

    // Hiển thị form đăng ký
    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    // Xử lý đăng ký người dùng
    @PostMapping("/register")
    public String registerUser(@Valid @ModelAttribute("user") User user,
                               BindingResult bindingResult,
                               HttpServletRequest request,
                               RedirectAttributes redirectAttributes,
                               Model model) {

        Locale locale = request.getLocale();

        // Kiểm tra lỗi validation cơ bản
        if (bindingResult.hasErrors()) {
            return "register";
        }

        // Kiểm tra password confirmation
        if (!user.isPasswordMatching()) {
            String errorMessage = messageSource.getMessage("user.password.mismatch",
                    null, locale);
            model.addAttribute("passwordMismatchError", errorMessage);
            return "register";
        }

        try {
            // Kiểm tra username đã tồn tại
            if (userService.isUsernameExists(user.getUsername())) {
                String errorMessage = messageSource.getMessage("user.username.exists",
                        null, locale);
                model.addAttribute("usernameExistsError", errorMessage);
                return "register";
            }

            // Kiểm tra email đã tồn tại
            if (userService.isEmailExists(user.getEmail())) {
                String errorMessage = messageSource.getMessage("user.email.exists",
                        null, locale);
                model.addAttribute("emailExistsError", errorMessage);
                return "register";
            }

            // Lưu người dùng vào database
            userService.saveUser(user);

            // Thông báo thành công
            String successMessage = messageSource.getMessage("user.register.success",
                    new Object[]{user.getUsername()},
                    locale);
            redirectAttributes.addFlashAttribute("successMessage", successMessage);

            return "redirect:/user/register?success";

        } catch (Exception e) {
            String errorMessage = messageSource.getMessage("user.register.error",
                    null, locale);
            model.addAttribute("generalError", errorMessage);
            return "register";
        }
    }

    // Hiển thị danh sách người dùng (tùy chọn)
    @GetMapping("/list")
    public String listUsers(Model model) {
        model.addAttribute("users", userService.getAllUsers());
        return "user-list";
    }
}