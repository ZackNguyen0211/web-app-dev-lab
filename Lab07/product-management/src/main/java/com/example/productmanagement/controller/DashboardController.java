package com.example.productmanagement.controller;

import com.example.productmanagement.entity.Product;
import com.example.productmanagement.service.ProductService;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.data.domain.Sort;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/dashboard")
public class DashboardController {

    private final ProductService productService;

    @Autowired
    public DashboardController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping
    public String showDashboard(Model model) {
        List<String> categories = productService.getAllCategories();
        Map<String, Long> countsByCategory = new HashMap<>();
        for (String cat : categories) {
            countsByCategory.put(cat, productService.countByCategory(cat));
        }

        BigDecimal totalValue = productService.calculateTotalValue();
        BigDecimal averagePrice = productService.calculateAveragePrice();
        List<Product> lowStock = productService.findLowStockProducts(10);

        model.addAttribute("totalProducts", productService.getAllProducts().size());
        model.addAttribute("countsByCategory", countsByCategory);
        model.addAttribute("totalValue", totalValue);
        model.addAttribute("averagePrice", averagePrice);
        model.addAttribute("lowStock", lowStock);

        // recent products = last 5 by id desc
        List<Product> recent = productService.getAllProducts(Sort.by("id").descending())
                .stream()
                .limit(5)
                .toList();
        model.addAttribute("recentProducts", recent);

        return "dashboard";
    }
}
