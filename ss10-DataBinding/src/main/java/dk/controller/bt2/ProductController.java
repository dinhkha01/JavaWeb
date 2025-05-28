package dk.controller.bt2;


import dk.model.entity.bt2.Product;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class ProductController {
    @GetMapping("/product")
    public String showUserPage(Model model ) {
        model.addAttribute("product", new Product());
        return "bt2";
    }
    @PostMapping("/product")
    public String submit(@ModelAttribute Product product, Model model) {
        model.addAttribute("product", product);
        return "bt2";
    }
}
