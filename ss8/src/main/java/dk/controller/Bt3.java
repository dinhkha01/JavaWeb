package dk.controller;

import dk.model.entity.Product;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class Bt3 {
    @GetMapping("/product/add")
    public String showFormAdd(Model model){
        model.addAttribute("product",new Product());
        return "bt3/form";
    }
    @PostMapping("/product/add")
    public String handleSubmit(@ModelAttribute Product product, Model model){
        model.addAttribute("product",product);
        return "bt3/view";
    }

}
