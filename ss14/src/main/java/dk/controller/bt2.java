package dk.controller;

import dk.model.entity.bt2.Product;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/products")
public class bt2 {

    private static final String PRODUCTS_COOKIE = "products";

    @GetMapping
    public String showProducts(Model model, HttpServletRequest request) {
        model.addAttribute("product", new Product());
        model.addAttribute("products", getProductsFromCookie(request));
        return "bt2/bt2";
    }

    @PostMapping("/add")
    public String addProduct(@Valid @ModelAttribute("product") Product product,
                             BindingResult result,
                             Model model,
                             HttpServletRequest request,
                             HttpServletResponse response) {

        List<Product> products = getProductsFromCookie(request);

        // Kiểm tra trùng mã sản phẩm
        boolean isDuplicate = products.stream()
                .anyMatch(p -> p.getProductCode().equals(product.getProductCode()));

        if (isDuplicate) {
            result.rejectValue("productCode", "duplicate", "Mã sản phẩm đã tồn tại");
        }

        if (result.hasErrors()) {
            model.addAttribute("products", products);
            return "bt2/bt2";
        }

        // Thêm sản phẩm mới
        products.add(product);
        saveProductsToCookie(products, response);

        return "redirect:/products";
    }

    @GetMapping("/delete/{productCode}")
    public String deleteProduct(@PathVariable String productCode,
                                HttpServletRequest request,
                                HttpServletResponse response) {

        List<Product> products = getProductsFromCookie(request);
        products.removeIf(p -> p.getProductCode().equals(productCode));
        saveProductsToCookie(products, response);

        return "redirect:/products";
    }

    @GetMapping("/clear")
    public String clearAllProducts(HttpServletResponse response) {
        Cookie cookie = new Cookie(PRODUCTS_COOKIE, "");
        cookie.setMaxAge(0); // Xóa cookie
        cookie.setPath("/");
        response.addCookie(cookie);

        return "redirect:/products";
    }

    private List<Product> getProductsFromCookie(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (PRODUCTS_COOKIE.equals(cookie.getName())) {
                    String cookieValue = cookie.getValue();
                    if (cookieValue != null && !cookieValue.isEmpty()) {
                        try {
                            String decodedValue = URLDecoder.decode(cookieValue, StandardCharsets.UTF_8.toString());
                            return Arrays.stream(decodedValue.split(";"))
                                    .filter(s -> !s.isEmpty())
                                    .map(Product::new)
                                    .collect(Collectors.toList());
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        }
        return new ArrayList<>();
    }

    private void saveProductsToCookie(List<Product> products, HttpServletResponse response) {
        try {
            String cookieValue = products.stream()
                    .map(Product::toString)
                    .collect(Collectors.joining(";"));

            String encodedValue = URLEncoder.encode(cookieValue, StandardCharsets.UTF_8.toString());

            Cookie cookie = new Cookie(PRODUCTS_COOKIE, encodedValue);
            cookie.setMaxAge(7 * 24 * 60 * 60); // 7 ngày
            cookie.setPath("/");
            response.addCookie(cookie);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}