package dk.controller;

import dk.model.entity.bt3.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;

@Controller
public class Bt3 {
    @GetMapping("/bt3")
    public String showBt3(Model model) {
        model.addAttribute("user",new User());
        return "bt3/form";
    }
    @PostMapping("/addUser")
    public String addUser(@Valid  @ModelAttribute User user, BindingResult result, Model model) {
        if(result.hasErrors()) {
            return "bt3/form";
        }
        model.addAttribute("user", user);
        return "bt3/result";
    }
}
