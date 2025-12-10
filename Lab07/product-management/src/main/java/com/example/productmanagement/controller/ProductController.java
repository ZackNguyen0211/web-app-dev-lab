package com.example.productmanagement.controller;

import com.example.productmanagement.entity.Product;
import com.example.productmanagement.service.ProductService;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.validation.Valid;
import org.springframework.validation.BindingResult;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@Controller
@RequestMapping("/products")
public class ProductController {

    private final ProductService productService;
    private static final String DEFAULT_SORT = "id";

    @Autowired
    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    // List all products - GET /products
    @GetMapping
    public String listProducts(@RequestParam(required = false) String sortBy,
                               @RequestParam(defaultValue = "asc") String sortDir,
                               @RequestParam(required = false) String category,
                               Model model) {
        String sortField = (sortBy == null || sortBy.isEmpty()) ? DEFAULT_SORT : sortBy;
        Sort sort = sortDir.equalsIgnoreCase("asc")
                ? Sort.by(sortField).ascending()
                : Sort.by(sortField).descending();

        List<Product> products = (category != null && !category.isEmpty())
                ? productService.getProductsByCategory(category)
                : productService.getAllProducts(sort);

        model.addAttribute("products", products);
        model.addAttribute("categories", productService.getAllCategories());
        model.addAttribute("selectedCategory", category);
        model.addAttribute("name", null);
        model.addAttribute("minPrice", null);
        model.addAttribute("maxPrice", null);
        model.addAttribute("sortBy", sortField);
        model.addAttribute("sortDir", sortDir);
        model.addAttribute("keyword", null);
        model.addAttribute("totalPages", null);
        model.addAttribute("currentPage", 0);
        model.addAttribute("size", null);
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
    public String saveProduct(@Valid @ModelAttribute("product") Product product,
                              BindingResult result,
                              @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
                              Model model,
                              RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "product-form";
        }
        try {
            if (imageFile != null && !imageFile.isEmpty()) {
                String uploadDir = "uploads";
                Files.createDirectories(Paths.get(uploadDir));
                String filename = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();
                Path filePath = Paths.get(uploadDir, filename);
                Files.copy(imageFile.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                product.setImagePath("/uploads/" + filename);
            } else if (product.getId() != null) {
                productService.getProductById(product.getId()).ifPresent(existing -> {
                    product.setImagePath(existing.getImagePath());
                });
            }

            productService.saveProduct(product);
            redirectAttributes.addFlashAttribute("success", "Product saved successfully");
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Error saving file: " + e.getMessage());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        return "redirect:/products";
    }

    // Delete product - GET /products/delete/{id}
    @GetMapping("/delete/{id}")
    public String deleteProduct(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        productService.deleteProduct(id);
        redirectAttributes.addFlashAttribute("success", "Product deleted successfully");
        return "redirect:/products";
    }

    @GetMapping("/search")
    public String searchProducts(@RequestParam("keyword") String keyword,
                                 @RequestParam(defaultValue = "0") int page,
                                 @RequestParam(defaultValue = "10") int size,
                                 Model model) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Product> productPage = productService.searchProducts(keyword, pageable);

        model.addAttribute("products", productPage.getContent());
        model.addAttribute("keyword", keyword);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("size", size);
        model.addAttribute("categories", productService.getAllCategories());
        model.addAttribute("selectedCategory", null);
        model.addAttribute("name", null);
        model.addAttribute("minPrice", null);
        model.addAttribute("maxPrice", null);
        return "product-list";
    }

    @GetMapping("/advanced-search")
    public String advancedSearch(@RequestParam(required = false) String name,
                                 @RequestParam(required = false) String category,
                                 @RequestParam(required = false) BigDecimal minPrice,
                                 @RequestParam(required = false) BigDecimal maxPrice,
                                 Model model) {
        List<Product> results = productService.advancedSearch(name, category, minPrice, maxPrice);
        model.addAttribute("products", results);
        model.addAttribute("name", name);
        model.addAttribute("selectedCategory", category);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("categories", productService.getAllCategories());
        return "product-list";
    }
}
