package org.example.laptopshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.example.laptopshop.service.ProductService;
import org.example.laptopshop.service.UploadService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import org.example.laptopshop.domain.Product;


@Controller
public class ProductController {

    private final UploadService uploadService;
    private final ProductService productService;

    public ProductController(UploadService uploadService, ProductService productService) {
        this.uploadService = uploadService;
        this.productService = productService;
    }

    @GetMapping("/admin/product")
    public String getDashboard(Model model, @RequestParam("page") Optional<String> pageOp) {
        int page = 1;

        try {
            if (pageOp.isPresent()) {
                page = Integer.parseInt(pageOp.get());
            } else {
            }
        } catch (Exception e) {
        }
        Pageable pageable = PageRequest.of(page - 1, 4);
        Page<Product> prs = this.productService.getAllProductsHome(pageable);
        List<Product> products = prs.getContent();
        model.addAttribute("products", products);
        model.addAttribute("currPage", page);
        model.addAttribute("totalPage", prs.getTotalPages());
        return "admin/product/show.jsp";
    }

    @GetMapping("/admin/product/create")
    public String getMethodName(Model model) {
        model.addAttribute("newProduct", new Product());
        return "admin/product/create.jsp";
    }

    @PostMapping(value = "/admin/product/create")
    public String createUser(Model model, @ModelAttribute("newProduct") @Valid Product product,
            BindingResult newProductBindingResult,
            @RequestParam("file") MultipartFile file) {

        List<FieldError> errors = newProductBindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>>" + error.getField() + " - " + error.getDefaultMessage());
        }
        // valid
        if (newProductBindingResult.hasErrors()) {
            return "admin/product/create.jsp";
        }

        //
        String avatar = this.uploadService.handleSaveUploadFile(file, "product");
        // String hashPassword = this.passwordEncoder.encode(anUser.getPassword());
        product.setImage(avatar);
        // anUser.setPassword(hashPassword);
        this.productService.handlersaveProduct(product);

        return "redirect:/admin/product";
    }

    @GetMapping("admin/product/{id}")
    public String getProductDetailPage(Model model, @PathVariable long id) {
        Product product = this.productService.getProductById(id);
        model.addAttribute("product", product);
        model.addAttribute("id", id);
        return "admin/product/detail.jsp";
    }

    @GetMapping("admin/product/delete/{id}")
    public String getProduct(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        Product newProduct = new Product();
        model.addAttribute("newProduct", newProduct);
        return "admin/product/delete.jsp";
    }

    @PostMapping("admin/product/delete")
    public String DeleteProduct(Model model, @ModelAttribute("product") Product newProduct) {
        this.productService.deleteById(newProduct.getId());
        return "redirect:/admin/product";
    }

    @GetMapping("admin/product/update/{id}")
    public String getMethodName(Model model, @PathVariable long id) {
        Product newProduct = this.productService.getProductById(id);
        model.addAttribute("newProduct", newProduct);
        return "admin/product/update.jsp";
    }

    @PostMapping("admin/product/update")
    public String postMethodName(Model model, @ModelAttribute("newProduct") @Valid Product Product,
            BindingResult producBindingResult, @RequestParam("file") MultipartFile file) {

        List<FieldError> errors = producBindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>>" + error.getField() + " - " + error.getDefaultMessage());
        }
        // valid
        if (producBindingResult.hasErrors()) {
            return "admin/product/update.jsp";
        }
        //
        Product currProduct = this.productService.getProductById(Product.getId());
        Product product = currProduct;
        System.out.println(currProduct);
        if (currProduct != null) {
            if (!file.isEmpty()) {
                String img = this.uploadService.handleSaveUploadFile(file, "product");
                product.setImage(img);
            }
            product.setName(Product.getName());
            product.setPrice(Product.getPrice());
            product.setDetailDesc(Product.getDetailDesc());
            product.setShortDesc(Product.getShortDesc());
            product.setQuantity(Product.getQuantity());
            product.setFactory(Product.getFactory());
            product.setTarget(Product.getTarget());

            this.productService.handlersaveProduct(product);
        }

        return "redirect:/admin/product";
    }

}
