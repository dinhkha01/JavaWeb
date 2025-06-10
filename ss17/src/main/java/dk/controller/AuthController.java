package dk.controller;

import dk.model.entity.Customer;
import dk.model.service.bt1.CustomerService;
import dk.model.service.bt1.CustomerService.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
public class AuthController {

    @Autowired
    private CustomerService customerService;

    // ======= REGISTER METHODS =======
    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("customer", new Customer());
        return "bt1/register";
    }

    @PostMapping("/register")
    public String registerCustomer(@Valid @ModelAttribute("customer") Customer customer,
                                   BindingResult result,
                                   Model model,
                                   RedirectAttributes redirectAttributes) {

        // Kiểm tra validation errors từ annotation
        if (result.hasErrors()) {
            model.addAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin hợp lệ!");
            return "bt1/register";
        }

        try {
            // Gọi service để đăng ký
            customerService.registerCustomer(customer);

            // Thành công - chuyển hướng với thông báo
            redirectAttributes.addFlashAttribute("successMessage",
                    "🎉 Chúc mừng! Tài khoản '" + customer.getUsername() + "' đã được tạo thành công!");
            redirectAttributes.addFlashAttribute("customer", customer);

            return "redirect:/register/success";

        } catch (ServiceException e) {
            // Lỗi từ service - hiển thị thông báo thân thiện
            model.addAttribute("errorMessage", e.getMessage());
            return "bt1/register";

        } catch (Exception e) {
            // Lỗi không mong muốn
            model.addAttribute("errorMessage", "⚠️ Có lỗi xảy ra trong hệ thống. Vui lòng thử lại sau!");
            // Log lỗi để debug (nên sử dụng logger thực tế)
            System.err.println("Unexpected error in register: " + e.getMessage());
            e.printStackTrace();
            return "bt1/register";
        }
    }

    @GetMapping("/register/success")
    public String showSuccessPage() {
        return "bt1/result";
    }

    // ======= LOGIN METHODS =======
    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("customer", new Customer());
        return "bt2/login";
    }

    @PostMapping("/login")
    public String loginCustomer(@ModelAttribute("customer") Customer customer,
                                BindingResult result,
                                Model model,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {

        // Kiểm tra dữ liệu đầu vào cơ bản
        if (customer.getUsername() == null || customer.getUsername().trim().isEmpty()) {
            model.addAttribute("errorMessage", "Vui lòng nhập tên đăng nhập!");
            return "bt2/login";
        }

        if (customer.getPassword() == null || customer.getPassword().trim().isEmpty()) {
            model.addAttribute("errorMessage", "Vui lòng nhập mật khẩu!");
            return "bt2/login";
        }

        try {
            // Xác thực thông tin đăng nhập
            Customer authenticatedCustomer = customerService.authenticateCustomer(
                    customer.getUsername().trim(),
                    customer.getPassword()
            );

            // Đăng nhập thành công
            session.setAttribute("loggedInUser", authenticatedCustomer);
            session.setAttribute("username", authenticatedCustomer.getUsername());
            session.setAttribute("role", authenticatedCustomer.getRole());

            // Chuyển hướng dựa trên role
            if ("ADMIN".equals(authenticatedCustomer.getRole())) {
                redirectAttributes.addFlashAttribute("successMessage",
                        "🔑 Chào mừng Admin " + authenticatedCustomer.getUsername() + "!");
                return "redirect:/admin";
            } else {
                redirectAttributes.addFlashAttribute("successMessage",
                        "✅ Đăng nhập thành công! Chào mừng " + authenticatedCustomer.getUsername() + "!");
                return "redirect:/home";
            }

        } catch (ServiceException e) {
            // Lỗi xác thực - hiển thị thông báo thân thiện
            model.addAttribute("errorMessage", e.getMessage());
            return "bt2/login";

        } catch (Exception e) {
            // Lỗi không mong muốn
            model.addAttribute("errorMessage", "⚠️ Có lỗi xảy ra trong hệ thống. Vui lòng thử lại sau!");
            // Log lỗi để debug
            System.err.println("Unexpected error in login: " + e.getMessage());
            e.printStackTrace();
            return "bt2/login";
        }
    }

    // ======= LOGOUT METHOD =======
    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            String username = (String) session.getAttribute("username");
            session.invalidate();

            redirectAttributes.addFlashAttribute("successMessage",
                    "👋 Đăng xuất thành công" + (username != null ? "! Hẹn gặp lại " + username : "") + "!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("successMessage", "Đăng xuất thành công!");
        }

        return "redirect:/login";
    }

    // ======= DASHBOARD PAGES =======
    @GetMapping("/admin")
    public String showAdminPage(HttpSession session, Model model) {
        Customer loggedInUser = (Customer) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            model.addAttribute("errorMessage", "Vui lòng đăng nhập để tiếp tục!");
            return "redirect:/login";
        }

        if (!"ADMIN".equals(loggedInUser.getRole())) {
            model.addAttribute("errorMessage", "Bạn không có quyền truy cập trang này!");
            return "redirect:/home";
        }

        model.addAttribute("user", loggedInUser);
        return "bt3/admin";
    }



    @GetMapping("/")
    public String redirectToLogin() {
        return "redirect:/login";
    }
}