package dk.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Bt1 {
    @GetMapping("/")
    public String Wellcom(){
        return "bt1";
    }
}
