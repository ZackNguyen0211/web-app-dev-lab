package com.example.productmanagement.controller;

import com.example.productmanagement.entity.Product;
import com.example.productmanagement.service.ProductService;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/products")
public class ProductController {

    private final ProductService productService;

    @Autowired
    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    // List all products - GET /products
    @GetMapping
    public String listProducts(Model model) {
        List<Product> products = productService.getAllProducts();
        model.addAttribute("products", products);
        return "product-list";
    }

    // Show new product form - GET /products/new
    @GetMapping("/new")
    public String showNewForm(Model model) {
        model.addAttribute("product", new Product());
        return "product-form";
    }

    // Show edit form - GET /products/edit/{id}
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Product> productOpt = productService.getProductById(id);
        if (productOpt.isPresent()) {
            model.addAttribute("product", productOpt.get());
            return "product-form";
        }
        redirectAttributes.addFlashAttribute("error", "Product not found");
        return "redirect:/products";
    }

    // Save product - POST /products/save
    @PostMapping("/save")
    public String saveProduct(@ModelAttribute("product") Product product, RedirectAttributes redirectAttributes) {
        productService.saveProduct(product);
        redirectAttributes.addFlashAttribute("success", "Product saved successfully");
        return "redirect:/products";
    }

    // Delete product - GET /products/delete/{id}
    @GetMapping("/delete/{id}")
    public String deleteProduct(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        productService.deleteProduct(id);
        redirectAttributes.addFlashAttribute("success", "Product deleted successfully");
        return "redirect:/products";
    }

    // Search products - GET /products/search
    @GetMapping("/search")
    public String searchProducts(@RequestParam("keyword") String keyword, Model model) {
        List<Product> results = productService.searchProducts(keyword);
        model.addAttribute("products", results);
        model.addAttribute("keyword", keyword);
        return "product-list";
    }
}
