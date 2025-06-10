package dk.controller;

import dk.model.entity.Customer;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;
@Controller
public class HomeController {
    @GetMapping("/home")
    public String showHomePage(HttpSession session, Model model) {
        Customer loggedInUser = (Customer) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            model.addAttribute("errorMessage", "Vui lòng đăng nhập để tiếp tục!");
            return "redirect:/login";
        }

        model.addAttribute("user", loggedInUser);
        return "bt3/home";
    }
}
