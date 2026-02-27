package org.example.laptopshop.controller.client;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.example.laptopshop.domain.Product;
import org.example.laptopshop.domain.User;
import org.example.laptopshop.domain.dto.RegisterDTO;
import org.example.laptopshop.service.ProductService;
import org.example.laptopshop.service.UserService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@Controller
public class HomePageController {

    private final ProductService productService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public HomePageController(ProductService productService, UserService userService, PasswordEncoder passwordEncoder) {
        this.productService = productService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/")
    public String getProducts(Model model, HttpServletRequest request) {
        Pageable pageable = PageRequest.of(0, 10);
        Page<Product> page = this.productService.getAllProductsHome(pageable);
        List<Product> products = page.getContent();
        model.addAttribute("products", products);

        return "client/homepage/show.jsp";
    }

    @GetMapping("/register")
    public String getRegisterPage(Model model) {

        model.addAttribute("registerUser", new RegisterDTO());
        return "client/auth/register.jsp";
    }

    @PostMapping("/register")
    public String postMethodName(@ModelAttribute("registerUser") @Valid RegisterDTO registerDTO,
                                 BindingResult bindingResult) {
        User user = this.userService.registerDTOtoUser(registerDTO);

        if (bindingResult.hasErrors()) {
            return "client/auth/register.jsp";
        }

        String hashPassword = this.passwordEncoder.encode(user.getPassword());

        user.setPassword(hashPassword);
        user.setRole(this.userService.getRoleByName("USER"));

        this.userService.handleSaveUser(user);
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String getLoginPage(Model model) {

        return "client/auth/login.jsp";
    }

    @GetMapping("/access-deny")
    public String getDenyPage(Model model) {

        return "client/auth/deny.jsp";
    }
}
// @PostMapping("/login")
// public String postMethodName() {

// return "client/homepage/show.jsp";
// }

