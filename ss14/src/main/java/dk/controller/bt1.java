package dk.controller;

import dk.model.entity.bt1.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
public class bt1 {
    @GetMapping("/bt1")
    public String login(Model model) {
        model.addAttribute("user", new User());
        return "bt1/login";
    }
    @PostMapping("/bt1")
    public String login(@Valid @ModelAttribute User user,  BindingResult result, HttpSession session ) {
        if (result.hasErrors()) {
            return "bt1/login";
        }
        session.setAttribute("user", user);
        return "redirect:/welcome";
    }
    @GetMapping("/welcome")
    public String welcome(@SessionAttribute("user") User user, Model model) {
        if (user == null) {
            return "redirect:/bt1";
        }
        model.addAttribute("username", user.getUsername());
        return "bt1/welcome";
    }
}
