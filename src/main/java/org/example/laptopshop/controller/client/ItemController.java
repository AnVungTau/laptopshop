package org.example.laptopshop.controller.client;

import java.util.ArrayList;
import java.util.List;

import org.example.laptopshop.domain.Cart;
import org.example.laptopshop.domain.Cart_detail;
import org.example.laptopshop.domain.Order;
import org.example.laptopshop.domain.Product;
import org.example.laptopshop.domain.User;
import org.example.laptopshop.domain.dto.ProductCriteriaDTO;
import org.example.laptopshop.service.OrderService;
import org.example.laptopshop.service.ProductService;
import org.example.laptopshop.service.UserService;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.security.core.Authentication;

import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

@Controller
public class ItemController {

    private final ProductService productService;
    private final OrderService orderService;
    private final UserService userService;

    public ItemController(ProductService productService,
                          OrderService orderService,
                          UserService userService) {
        this.productService = productService;
        this.orderService = orderService;
        this.userService = userService;
    }

    private User getCurrentUser(Authentication authentication){
        String email = authentication.getName();
        return userService.getUserByEmail(email);
    }

    @GetMapping("/product/detail/{id}")
    public String getProductDetail(Model model, @PathVariable long id) {
        Product product = this.productService.getProductById(id);
        model.addAttribute("product", product);
        model.addAttribute("id", id);
        return "client/product/detail.jsp";
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(@PathVariable long id,
                                   Authentication authentication,
                                   HttpSession session) {

        User user = getCurrentUser(authentication);

        this.productService.handlerAddProductToCart(
                user.getEmail(),
                id,
                session,
                1
        );

        return "redirect:/";
    }

    @GetMapping("/cart")
    public String getCartDetail(Model model,
                                Authentication authentication) {

        User user = getCurrentUser(authentication);

        Cart cart = this.productService.fetchByUser(user);
        List<Cart_detail> cartDetails =
                cart == null ? new ArrayList<>() : cart.getCart_details();

        double total = cartDetails.stream()
                .mapToDouble(cd -> cd.getPrice() * cd.getQuantity())
                .sum();

        model.addAttribute("cart", cart);
        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("total", total);

        return "client/cart/show.jsp";
    }

    @PostMapping("/delete-cart-product/{id}")
    public String deleteProductInCart(@PathVariable long id,
                                      HttpSession session) {

        this.productService.removeCartDetail(id, session);
        return "redirect:/cart";
    }

    @GetMapping("/checkout")
    public String checkout(Model model,
                           Authentication authentication) {

        User user = getCurrentUser(authentication);

        Cart cart = this.productService.fetchByUser(user);
        List<Cart_detail> cartDetails =
                cart == null ? new ArrayList<>() : cart.getCart_details();

        double total = cartDetails.stream()
                .mapToDouble(cd -> cd.getPrice() * cd.getQuantity())
                .sum();

        model.addAttribute("cart", cart);
        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("total", total);

        return "client/cart/checkout.jsp";
    }

    @PostMapping("/confirm-checkout")
    public String confirmCheckout(@ModelAttribute("cart") Cart cart) {

        List<Cart_detail> cd =
                cart == null ? new ArrayList<>() : cart.getCart_details();

        this.productService.updateCartToCheckout(cd);

        return "redirect:/checkout";
    }

    @PostMapping("/place-order")
    public String placeOrder(Authentication authentication,
                             HttpSession session,
                             @RequestParam String receiverName,
                             @RequestParam String receiverAddress,
                             @RequestParam String receiverPhone) {

        User user = getCurrentUser(authentication);

        this.productService.placeOrder(
                user,
                session,
                receiverName,
                receiverAddress,
                receiverPhone
        );

        return "redirect:/thanks";
    }

    @GetMapping("/thanks")
    public String thanks() {
        return "client/cart/thanks.jsp";
    }

    @GetMapping("/history")
    public String history(Model model,
                          Authentication authentication) {

        User user = getCurrentUser(authentication);

        List<Order> orders = this.orderService.findOrderByUser(user);

        model.addAttribute("orders", orders);

        return "client/cart/history.jsp";
    }

    @PostMapping("/add-product-from-detail")
    public String addFromDetail(@RequestParam long id,
                                @RequestParam long quantity,
                                Authentication authentication,
                                HttpSession session) {

        User user = getCurrentUser(authentication);

        this.productService.handlerAddProductToCart(
                user.getEmail(),
                id,
                session,
                quantity
        );

        return "redirect:/product/detail/" + id;
    }

    @GetMapping("/product")
    public String getProducts(Model model,
                              ProductCriteriaDTO dto) {

        int page = (dto.getPage() != null)
                ? Integer.parseInt(dto.getPage())
                : 1;

        Pageable pageable = PageRequest.of(page - 1, 5);

        if (dto.getSort() != null && dto.getSort().isPresent()) {

            String sort = dto.getSort().get();

            if (sort.equals("gia-tang-dan")) {
                pageable = PageRequest.of(page - 1, 5,
                        Sort.by("price").ascending());

            } else if (sort.equals("gia-giam-dan")) {
                pageable = PageRequest.of(page - 1, 5,
                        Sort.by("price").descending());
            }
        }

        Page<Product> prs =
                this.productService.getAllProducts(pageable, dto);

        model.addAttribute("products", prs.getContent());
        model.addAttribute("currPage", page);
        model.addAttribute("totalPage", prs.getTotalPages());

        return "client/product/product.jsp";
    }
}
