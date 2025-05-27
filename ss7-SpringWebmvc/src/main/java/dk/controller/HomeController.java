package dk.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeController {
    @RequestMapping({"/home","/"})
    public String home(Model model){
        model.addAttribute("message","helopro");
        return "home";
    }
    @RequestMapping("/greet")
    public String greet(@RequestParam(defaultValue = "nhap ten di m tren duong dan a") String name, Model model){
        model.addAttribute("name", name);
        return "bt2";
    }
}
