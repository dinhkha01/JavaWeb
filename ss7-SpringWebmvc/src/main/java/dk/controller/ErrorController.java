package dk.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
public class ErrorController {
    @RequestMapping("/**")
    public String error(){
        return "error";
    }
}
