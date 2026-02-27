package org.example.laptopshop.controller.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.example.laptopshop.Repository.OrderDetailRepository;
import org.example.laptopshop.Repository.OrderRepository;
import org.example.laptopshop.domain.Order;
import org.example.laptopshop.service.OrderService;
import org.example.laptopshop.service.ProductService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
public class OrderController {

    private final OrderRepository orderRepository;
    private final OrderService orderService;
    private final ProductService productService;
    private final OrderDetailRepository orderDetailRepository;

    public OrderController(OrderRepository orderRepository, OrderService orderService, ProductService productService,
            OrderDetailRepository orderDetailRepository) {
        this.orderRepository = orderRepository;
        this.orderService = orderService;
        this.productService = productService;
        this.orderDetailRepository = orderDetailRepository;
    }

    @GetMapping("/admin/order")
    public String getDashboard(Model model, @RequestParam("page") Optional<String> pageOptional) {
        int page = 1;

        try {
            if (pageOptional.isPresent()) {
                page = Integer.parseInt(pageOptional.get());
            }
        } catch (Exception e) {
        }

        Pageable pageable = PageRequest.of(page - 1, 2);
        Page<Order> prs = this.orderService.getAllOrders(pageable);
        List<Order> orders = prs.getContent();
        model.addAttribute("orders", orders);
        model.addAttribute("currPage", page);
        model.addAttribute("totalPage", prs.getTotalPages());

        return "admin/order/show.jsp";
    }

    @GetMapping("admin/order/{id}")
    public String getProductDetailPage(Model model, @PathVariable long id) {
        Order order = this.orderRepository.findById(id);
        model.addAttribute("order", order);
        model.addAttribute("id", id);
        model.addAttribute("orderDetails", order.getOrderDetails());

        return "admin/order/detail.jsp";
    }

    @GetMapping("admin/order/delete/{id}")
    public String getDeletePage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newOrder", new Order());
        return "admin/order/delete.jsp";
    }

    @PostMapping("admin/order/delete")
    public String Delete(@ModelAttribute("newOrder") Order order) {
        this.orderService.deleteOrderById(order.getId());
        return "redirect:/admin/order";
    }

    @GetMapping("admin/order/update/{id}")
    public String getUpdatePage(Model model, @PathVariable long id) {
        Order order = this.orderService.getProductById(id);
        model.addAttribute("newOrder", order);
        return "admin/order/update.jsp";
    }

    @PostMapping("admin/order/update")
    public String postMethodName(@ModelAttribute("newOrder") Order order) {
        this.orderService.updateOrder(order);
        return "redirect:/admin/order";
    }

}
