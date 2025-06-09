package dk.controller;

import dk.model.entity.Customer;
import dk.model.service.bt1.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.springframework.transaction.annotation.Transactional;
import javax.validation.Valid;

@Controller
public class Bt1 {

    @Autowired
    private CustomerService customerService;

    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("customer", new Customer());
        return "bt1/register";
    }

    @PostMapping("/register")
    @Transactional
    public String registerCustomer(@Valid @ModelAttribute("customer") Customer customer,
                                   BindingResult result,
                                   Model model,
                                   RedirectAttributes redirectAttributes) {

        // Kiểm tra validation errors
        if (result.hasErrors()) {
            return "bt1/register";
        }

        try {
            // Lưu customer vào database
            customerService.registerCustomer(customer);

            // Thêm thông báo thành công
            redirectAttributes.addFlashAttribute("successMessage",
                    "Đăng ký tài khoản thành công! Chào mừng " + customer.getUsername());
            redirectAttributes.addFlashAttribute("customer", customer);

            return "redirect:/register/success";

        } catch (Exception e) {
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi đăng ký: " + e.getMessage());
            return "bt1/register";
        }
    }

    @GetMapping("/register/success")
    public String showSuccessPage() {
        return "bt1/result";
    }
}