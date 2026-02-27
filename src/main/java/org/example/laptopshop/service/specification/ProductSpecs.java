package org.example.laptopshop.service.specification;

import org.example.laptopshop.domain.Product;
import org.example.laptopshop.domain.Product_;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;

public class ProductSpecs {
    public static Specification<Product> nameLike(String name) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.like(root.get(Product_.NAME), "%" + name + "%");
    }

    public static Specification<Product> min(Double minPrice) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.ge(root.get(Product_.PRICE),
                minPrice);
    }

    public static Specification<Product> max(Double maxPrice) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.ge(root.get(Product_.PRICE),
                maxPrice);
    }

    // public static Specification<Product> factory(String factory) {
    // return (root, query, criteriaBuilder) ->
    // criteriaBuilder.equal(root.get(Product_.FACTORY),
    // factory);
    // }

    public static Specification<Product> factory(List<String> factory) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.in(root.get(Product_.FACTORY)).value(factory);
    }

    public static Specification<Product> target(List<String> target) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.in(root.get(Product_.TARGET)).value(target);
    }

    // public static Specification<Product> price(double minPrice, double maxPrice)
    // {
    // return (root, query, criteriaBuilder) ->
    // criteriaBuilder.and(criteriaBuilder.gt(root.get(Product_.PRICE),
    // minPrice),
    // criteriaBuilder.le(root.get(Product_.PRICE),
    // maxPrice));
    // }

    public static Specification<Product> price(double minPrice, double maxPrice) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.between(root.get(Product_.PRICE),
                minPrice, maxPrice);
    }

}


