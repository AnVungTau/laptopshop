package org.example.laptopshop.Repository;

import org.example.laptopshop.domain.Order;
import org.example.laptopshop.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    Order save(Order an);

    Order findById(long id);

    List<Order> findByUser(User user);

}
