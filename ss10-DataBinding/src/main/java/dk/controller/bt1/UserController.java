package dk.controller.bt1;

import dk.model.entity.bt1.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class UserController {
    @GetMapping("/user")
    public String showUserPage(Model model ) {
        model.addAttribute("user", new User());
        return "bt1";
    }
    @PostMapping("/user")
    public String submit(@ModelAttribute User user, Model model) {
        model.addAttribute("user", user);
        return "bt1";
    }
}
