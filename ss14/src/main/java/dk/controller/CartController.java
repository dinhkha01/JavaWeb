package dk.controller;


import dk.model.entity.bt4.Product;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/cart")
public class CartController {

    @GetMapping
    public String showCart(HttpSession session, HttpServletRequest request, Model model) {
        // Lấy giỏ hàng từ session
        List<Product> cart = (List<Product>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // Lấy thông tin sản phẩm từ cookie
        Cookie[] cookies = request.getCookies();
        List<String> recentProducts = new ArrayList<>();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().startsWith("product_")) {
                    recentProducts.add(cookie.getValue());
                }
            }
        }

        model.addAttribute("cart", cart);
        model.addAttribute("recentProducts", recentProducts);
        model.addAttribute("product", new Product());

        return "bt4/cart";
    }

    @PostMapping("/add")
    public String addToCart(@ModelAttribute Product product,
                            HttpSession session,
                            HttpServletResponse response) {

        // Lấy giỏ hàng từ session
        List<Product> cart = (List<Product>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // Kiểm tra nếu sản phẩm đã tồn tại trong giỏ hàng
        boolean found = false;
        for (Product p : cart) {
            if (p.getName().equals(product.getName())) {
                p.setQuantity(p.getQuantity() + product.getQuantity());
                found = true;
                break;
            }
        }

        // Nếu chưa tồn tại, thêm sản phẩm mới
        if (!found) {
            cart.add(new Product(product.getName(), product.getQuantity()));
        }

        // Lưu giỏ hàng vào session
        session.setAttribute("cart", cart);

        // Lưu thông tin sản phẩm vào cookie
        Cookie productCookie = new Cookie("product_" + System.currentTimeMillis(),
                product.getName() + ":" + product.getQuantity());
        productCookie.setMaxAge(7 * 24 * 60 * 60); // 7 ngày
        productCookie.setPath("/");
        response.addCookie(productCookie);

        return "redirect:/cart";
    }

    @PostMapping("/remove")
    public String removeFromCart(@RequestParam String productName, HttpSession session) {
        List<Product> cart = (List<Product>) session.getAttribute("cart");
        if (cart != null) {
            cart.removeIf(product -> product.getName().equals(productName));
            session.setAttribute("cart", cart);
        }
        return "redirect:/cart";
    }

    @PostMapping("/clear")
    public String clearCart(HttpSession session) {
        session.removeAttribute("cart");
        return "redirect:/cart";
    }
}