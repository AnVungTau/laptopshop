package org.example.laptopshop.service;

import java.util.List;
import java.util.Optional;

import org.example.laptopshop.Repository.OrderDetailRepository;
import org.example.laptopshop.Repository.OrderRepository;
import org.example.laptopshop.domain.Order;
import org.example.laptopshop.domain.OrderDetail;
import org.example.laptopshop.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;



@Service
public class OrderService {

    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public OrderService(OrderRepository orderRepository, OrderDetailRepository orderDetailRepository) {
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    public Page<Order> getAllOrders(Pageable pageable) {
        return this.orderRepository.findAll(pageable);
    }

    public Order getProductById(long id) {
        return this.orderRepository.findById(id);
    }

    public void deleteOrderById(long id) {
        Order order = this.orderRepository.findById(id);

        if (order != null) {
            Order currOrder = order;
            List<OrderDetail> orderDetails = currOrder.getOrderDetails();
            for (OrderDetail odt : orderDetails) {
                this.orderDetailRepository.deleteById(odt.getId());
            }
        }

        this.orderRepository.deleteById(id);
    }

    public void updateOrder(Order order) {
        Order currOrder = this.orderRepository.findById(order.getId());

        if (currOrder != null) {
            currOrder.setStatus(order.getStatus());
            this.orderRepository.save(currOrder);
        }
    }

    public List<Order> findOrderByUser(User user) {
        return this.orderRepository.findByUser(user);
    }

}
