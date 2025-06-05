package dk.controller;


import dk.model.entity.bt5.Order;
import dk.model.entity.bt5.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/orders")
public class OrderController {

    // Kiểm tra đăng nhập
    private boolean checkLogin(HttpSession session) {
        return session.getAttribute("user") != null;
    }

    @GetMapping
    public String showOrders(HttpSession session, Model model) {
        if (!checkLogin(session)) {
            return "redirect:/login";
        }

        // Lấy danh sách đơn hàng từ session
        List<Order> orders = (List<Order>) session.getAttribute("orders");
        if (orders == null) {
            orders = new ArrayList<>();
        }

        User user = (User) session.getAttribute("user");
        model.addAttribute("user", user);
        model.addAttribute("orders", orders);
        model.addAttribute("order", new Order());

        return "orders";
    }

    @PostMapping("/add")
    public String addOrder(@ModelAttribute Order order, HttpSession session) {
        if (!checkLogin(session)) {
            return "redirect:/login";
        }

        // Lấy danh sách đơn hàng từ session
        List<Order> orders = (List<Order>) session.getAttribute("orders");
        if (orders == null) {
            orders = new ArrayList<>();
        }

        // Kiểm tra trùng mã đơn hàng
        boolean exists = orders.stream()
                .anyMatch(o -> o.getOrderId().equals(order.getOrderId()));

        if (!exists) {
            orders.add(new Order(order.getOrderId(), order.getProductName(), order.getQuantity()));
            session.setAttribute("orders", orders);
        }

        return "redirect:/orders";
    }

    @GetMapping("/edit/{orderId}")
    public String showEditForm(@PathVariable String orderId, HttpSession session, Model model) {
        if (!checkLogin(session)) {
            return "redirect:/login";
        }

        List<Order> orders = (List<Order>) session.getAttribute("orders");
        if (orders != null) {
            Order order = orders.stream()
                    .filter(o -> o.getOrderId().equals(orderId))
                    .findFirst()
                    .orElse(null);

            if (order != null) {
                User user = (User) session.getAttribute("user");
                model.addAttribute("user", user);
                model.addAttribute("order", order);
                model.addAttribute("isEdit", true);
                return "edit-order";
            }
        }

        return "redirect:/orders";
    }

    @PostMapping("/update")
    public String updateOrder(@ModelAttribute Order order, HttpSession session) {
        if (!checkLogin(session)) {
            return "redirect:/login";
        }

        List<Order> orders = (List<Order>) session.getAttribute("orders");
        if (orders != null) {
            for (int i = 0; i < orders.size(); i++) {
                if (orders.get(i).getOrderId().equals(order.getOrderId())) {
                    orders.set(i, order);
                    break;
                }
            }
            session.setAttribute("orders", orders);
        }

        return "redirect:/orders";
    }

    @PostMapping("/delete/{orderId}")
    public String deleteOrder(@PathVariable String orderId, HttpSession session) {
        if (!checkLogin(session)) {
            return "redirect:/login";
        }

        List<Order> orders = (List<Order>) session.getAttribute("orders");
        if (orders != null) {
            orders.removeIf(order -> order.getOrderId().equals(orderId));
            session.setAttribute("orders", orders);
        }

        return "redirect:/orders";
    }
}