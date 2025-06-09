package dk.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Bt1 {
    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("message", "Welcome to the BT1 Index Page!");
        return "bt1/index";
    }
}