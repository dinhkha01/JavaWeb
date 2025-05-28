package dk.controller.bt2;

import dk.model.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ProductController {
    @Autowired
    private ProductService productService;
    @RequestMapping("/list-product")
    public String getAllProduct(Model model){
        model.addAttribute("products",productService.getAllProducts());
        return "bt2";
    }
}
