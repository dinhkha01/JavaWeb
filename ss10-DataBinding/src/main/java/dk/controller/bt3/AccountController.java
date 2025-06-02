package dk.controller.bt3;

import dk.model.entity.bt3.Account;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class AccountController {
    @GetMapping("/account")
    public String showAccountPage(Model model) {
        model.addAttribute("account",new Account());
        return "bt3";
    }

    @PostMapping("/account")
    public String submit(@ModelAttribute Account account, Model model) {
        model.addAttribute("account", account);
        return "bt3";
    }
}
