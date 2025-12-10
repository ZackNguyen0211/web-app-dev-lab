package com.example.productmanagement.service;

import com.example.productmanagement.entity.Product;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ProductService {

    List<Product> getAllProducts();

    Optional<Product> getProductById(Long id);

    Product saveProduct(Product product);

    void deleteProduct(Long id);

    List<Product> searchProducts(String keyword);

    List<Product> getProductsByCategory(String category);

    List<Product> getAllProducts(Sort sort);

    Page<Product> searchProducts(String keyword, Pageable pageable);

    List<Product> advancedSearch(String name, String category, BigDecimal minPrice, BigDecimal maxPrice);

    List<String> getAllCategories();

    long countByCategory(String category);

    BigDecimal calculateTotalValue();

    BigDecimal calculateAveragePrice();

    List<Product> findLowStockProducts(int threshold);
}
