package org.example.laptopshop.Repository;

import org.example.laptopshop.domain.Cart;
import org.example.laptopshop.domain.Cart_detail;
import org.example.laptopshop.domain.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CartDetailRepository extends JpaRepository<Cart_detail, Long> {
    boolean existsByCartAndProduct(Cart cart, Product product);

    Cart_detail findByCartAndProduct(Cart cart, Product product);
}