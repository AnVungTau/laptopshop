package org.example.laptopshop.service;


import jakarta.servlet.http.HttpSession;
import org.example.laptopshop.Repository.CartDetailRepository;
import org.example.laptopshop.Repository.CartRepository;
import org.example.laptopshop.Repository.OrderDetailRepository;
import org.example.laptopshop.Repository.OrderRepository;
import org.example.laptopshop.Repository.ProductRepository;
import org.example.laptopshop.domain.Cart;
import org.example.laptopshop.domain.Cart_detail;
import org.example.laptopshop.domain.Order;
import org.example.laptopshop.domain.OrderDetail;
import org.example.laptopshop.domain.Product;
import org.example.laptopshop.domain.User;
import org.example.laptopshop.domain.dto.ProductCriteriaDTO;
import org.example.laptopshop.service.specification.ProductSpecs;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Service
public class ProductService {

    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public ProductService(ProductRepository productRepository, CartRepository cartRepository,
                          CartDetailRepository cartDetailRepository, UserService userService, OrderRepository orderRepository,
                          OrderDetailRepository orderDetailRepository) {
        this.productRepository = productRepository;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.userService = userService;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    public Product handlersaveProduct(Product product) {
        Product product2 = this.productRepository.save(product);
        return product2;
    }

    public Page<Product> getAllProductsHome(Pageable pageable) {
        return this.productRepository.findAll(pageable);
    }

    public Page<Product> getAllProducts(Pageable pageable, ProductCriteriaDTO dto) {

        Specification<Product> spec = (root, query, cb) -> cb.conjunction();

        if (dto != null) {

            if (dto.getTarget() != null && dto.getTarget().isPresent()) {
                spec = spec.and(ProductSpecs.target(dto.getTarget().get()));
            }

            if (dto.getFactory() != null && dto.getFactory().isPresent()) {
                spec = spec.and(ProductSpecs.factory(dto.getFactory().get()));
            }

            if (dto.getPrice() != null && dto.getPrice().isPresent()) {
                Specification<Product> priceSpec = getAllProductsPrice(dto.getPrice().get());

                if (priceSpec != null) {
                    spec = spec.and(priceSpec);
                }
            }
        }

        return productRepository.findAll(spec, pageable);
    }



    public Page<Product> getAllProductsMinprice(Pageable pageable, double
     minprice) {
     return this.productRepository.findAll(ProductSpecs.min(minprice), pageable);
     }

     public Page<Product> getAllProductsMaxprice(Pageable pageable, double
     maxprice) {
     return this.productRepository.findAll(ProductSpecs.max(maxprice), pageable);
     }

     public Page<Product> getAllProductsfactory(Pageable pageable, String factory)
     {
     return this.productRepository.findAll(ProductSpecs.factory(Collections.singletonList(factory)),
     pageable);
     }

     public Page<Product> getAllProductsfactory(Pageable pageable, List<String>
     factory) {
     return this.productRepository.findAll(ProductSpecs.factory(factory),
     pageable);
     }

     public Page<Product> getAllProductsPrice(Pageable pageable, String price) {

     if (price.equals("10-toi-15-trieu")) {
     double min = 10000000;
     double max = 15000000;
     return this.productRepository.findAll(ProductSpecs.price(min, max),
     pageable);
     } else if (price.equals("15-toi-30-trieu")) {
     double min = 15000000;
     double max = 30000000;
     return this.productRepository.findAll(ProductSpecs.price(min, max),
     pageable);
     } else
     return this.productRepository.findAll(pageable);
     }

    public Specification<Product> getAllProductsPrice(List<String> price) {
        Specification<Product> combined = Specification.where((Specification<Product>) null);

        for (String p : price) {
            double min = 0;
            double max = 0;
            switch (p) {
                case "duoi-10-trieu":
                    min = 1;
                    max = 10000000;
                    break;
                case "10-toi-15-trieu":
                    min = 10000000;
                    max = 15000000;
                    break;
                case "15-toi-20-trieu":
                    min = 15000000;
                    max = 20000000;
                    break;
                case "tren-20-trieu":
                    min = 20000000;
                    max = 200000000;
                    break;
            }
            if (min != 0 && max != 0) {
                Specification<Product> range = ProductSpecs.price(min, max);
                combined = combined.or(range);
            }
        }

        return combined;
    }

    public Product getProductById(long id) {
        return this.productRepository.findById(id);
    }

    public void deleteById(long id) {
        this.productRepository.deleteById(id);
    }

    public void handlerAddProductToCart(String email, long productId, HttpSession session, long quantity) {
        User user = this.userService.getUserByEmail(email);
        if (user != null) {
            Cart cart = this.cartRepository.findByUser(user);
            if (cart == null) {
                Cart newCart = new Cart();
                newCart.setUser(user);
                newCart.setSum(0);
                cart = this.cartRepository.save(newCart);
            }
            Product p = this.productRepository.findById(productId);
            if (p != null) {

                Cart_detail productInCart = this.cartDetailRepository.findByCartAndProduct(cart, p);
                if (productInCart == null) {
                    Product realProduct = p;
                    Cart_detail cd = new Cart_detail();
                    cd.setCart(cart);
                    cd.setProduct(realProduct);
                    cd.setPrice(realProduct.getPrice());
                    cd.setQuantity(quantity);
                    this.cartDetailRepository.save(cd);

                    int s = cart.getSum() + 1;
                    cart.setSum(cart.getSum() + 1);
                    this.cartRepository.save(cart);
                    session.setAttribute("sum", s);
                } else {
                    productInCart.setQuantity(productInCart.getQuantity() + quantity);
                    this.cartDetailRepository.save(productInCart);
                }

            }

        }
    }

    public Cart fetchByUser(User user) {
        return this.cartRepository.findByUser(user);
    }

    public void removeCartDetail(long cart_detailsId, HttpSession session) {

        // - Tìm cart-detail theo id (id từ view gửi lên)
        Optional<Cart_detail> cart_detail = this.cartDetailRepository.findById(cart_detailsId);

        if (cart_detail.isPresent()) {
            // - Từ cart-detail này, lấy ra đối tượng cart (giỏ hàng) tương ứng
            Cart_detail cd = cart_detail.get();

            Cart currCart = cd.getCart();

            // - Xóa cart-detail
            this.cartDetailRepository.deleteById(cart_detailsId);

            // - Kiểm tra điều kiện:
            // - Nếu Cart có sum > 1 => update trừ đi 1 đơn vị (update cart)
            if (currCart.getSum() > 1) {
                int s = currCart.getSum() - 1;
                currCart.setSum(s);
                session.setAttribute("sum", s);
                this.cartRepository.save(currCart);
            }
            // - Nếu Cart có sum = 1 => xóa cart
            else {
                User user = currCart.getUser();

                if(user != null){
                    user.setCart(null);
                }

                this.cartRepository.delete(currCart);
                session.setAttribute("sum", 0);
            }
        }
    }

    public void updateCartToCheckout(List<Cart_detail> cart_details) {
        for (Cart_detail cd : cart_details) {
            Optional<Cart_detail> cdop = this.cartDetailRepository.findById(cd.getId());
            if (cdop.isPresent()) {
                Cart_detail currCart_detail = cdop.get();
                currCart_detail.setQuantity(cd.getQuantity());
                this.cartDetailRepository.save(currCart_detail);
            }
        }
    }

    public void placeOrder(User user, HttpSession session, String recieverName, String recieverAddress,
                           String recieverPhone) {

        Cart cart = this.cartRepository.findByUser(user);
        if (cart != null) {
            List<Cart_detail> cdt = cart.getCart_details();
            if (cdt != null) {
                Order order = new Order();

                order.setUser(user);
                order.setReceiverName(recieverName);
                order.setReceiverAddress(recieverAddress);
                order.setReceiverPhone(recieverPhone);
                order.setStatus("PENDING");

                double sum = 0;
                for (Cart_detail cd : cdt) {
                    sum += cd.getPrice();
                }
                order.setTotalPrice(sum);
                order = this.orderRepository.save(order);

                // lay cart = user

                for (Cart_detail cd : cdt) {
                    OrderDetail od = new OrderDetail();

                    od.setOrder(order);
                    od.setProduct(cd.getProduct());
                    od.setPrice(cd.getPrice());
                    od.setQuantity(cd.getQuantity());
                    this.orderDetailRepository.save(od);
                }

                // xoa cartdetail va cart

                for (Cart_detail cd : cdt) {
                    this.cartDetailRepository.deleteById(cd.getId());

                }
                User u = cart.getUser();

                if(u != null){
                    u.setCart(null);
                }

                this.cartRepository.delete(cart);

                // update session
                session.setAttribute("sum", 0);
            }
        }
    }
}

