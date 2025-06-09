package dk.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Bt4 {
    @GetMapping("/home")
    public String home() {
        return "bt4/home";
    }
    @GetMapping("/about")
    public String about() {
        return "bt4/about";
    }
    @GetMapping("/contact")
    public String contact() {
        return "bt4/contact";
    }
}
