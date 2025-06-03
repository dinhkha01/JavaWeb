package dk.controller;

import dk.model.entity.Category;
import dk.model.entity.Product;
import dk.model.service.CategoryService;
import dk.model.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/products")
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    private static final int PAGE_SIZE = 5;
    private static final String UPLOAD_DIR = "C:/uploads/products"; // Thư mục upload cố định

    @GetMapping
    public String listProducts(@RequestParam(value = "page", defaultValue = "1") int page,
                               @RequestParam(value = "search", required = false) String search,
                               Model model, HttpServletRequest request) {

        List<Product> products;
        int totalRecords;
        int totalPages;

        if (search != null && !search.trim().isEmpty()) {
            products = productService.searchByNameWithPaging(search.trim(), page, PAGE_SIZE);
            totalRecords = productService.getTotalSearchProducts(search.trim());
            model.addAttribute("search", search);

            if (products.isEmpty()) {
                model.addAttribute("message", "Không tìm thấy sản phẩm!");
            }
        } else {
            products = productService.findAllWithPaging(page, PAGE_SIZE);
            totalRecords = productService.getTotalProducts();

            if (products.isEmpty()) {
                model.addAttribute("message", "Danh sách trống!");
            }
        }

        totalPages = productService.getTotalPages(totalRecords, PAGE_SIZE);

        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalRecords", totalRecords);

        // Pagination logic
        int startPage = Math.max(1, page - 2);
        int endPage = Math.min(totalPages, page + 2);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        return "product/list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("product", new Product());
        model.addAttribute("categories", categoryService.getActiveCategories());
        return "product/form";
    }

    @PostMapping("/add")
    public String addProduct(@Valid @ModelAttribute("product") Product product,
                             BindingResult result,
                             @RequestParam("imageFile") MultipartFile imageFile,
                             Model model,
                             RedirectAttributes redirectAttributes) {

        if (result.hasErrors()) {
            model.addAttribute("categories", categoryService.getActiveCategories());
            return "product/form";
        }

        try {
            // Handle file upload
            if (!imageFile.isEmpty()) {
                String fileName = saveUploadedFile(imageFile);
                product.setImageUrl("/products/images/" + fileName);
            }

            productService.save(product);
            redirectAttributes.addFlashAttribute("successMessage", "Thêm sản phẩm thành công!");
        } catch (Exception e) {
            model.addAttribute("categories", categoryService.getActiveCategories());
            model.addAttribute("errorMessage", "Lỗi: " + e.getMessage());
            return "product/form";
        }

        return "redirect:/products";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Integer id, Model model) {
        Product product = productService.findById(id);
        if (product == null) {
            return "redirect:/products";
        }

        model.addAttribute("product", product);
        model.addAttribute("categories", categoryService.getActiveCategories());
        return "product/form";
    }

    @PostMapping("/edit/{id}")
    public String updateProduct(@PathVariable Integer id,
                                @Valid @ModelAttribute("product") Product product,
                                BindingResult result,
                                @RequestParam("imageFile") MultipartFile imageFile,
                                Model model,
                                RedirectAttributes redirectAttributes) {

        if (result.hasErrors()) {
            model.addAttribute("categories", categoryService.getActiveCategories());
            return "product/form";
        }

        try {
            // Get existing product to preserve current image if no new image uploaded
            Product existingProduct = productService.findById(id);

            // Handle file upload
            if (!imageFile.isEmpty()) {
                String fileName = saveUploadedFile(imageFile);
                product.setImageUrl("/products/images/" + fileName);
            } else {
                // Keep existing image if no new image uploaded
                product.setImageUrl(existingProduct.getImageUrl());
            }

            product.setProductId(id);
            productService.save(product);
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật sản phẩm thành công!");
        } catch (Exception e) {
            model.addAttribute("categories", categoryService.getActiveCategories());
            model.addAttribute("errorMessage", "Lỗi: " + e.getMessage());
            return "product/form";
        }

        return "redirect:/products";
    }

    @PostMapping("/delete/{id}")
    public String deleteProduct(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        try {
            productService.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa sản phẩm thành công!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi: " + e.getMessage());
        }

        return "redirect:/products";
    }

    @GetMapping("/search")
    public String searchProducts(@RequestParam("name") String name,
                                 @RequestParam(value = "page", defaultValue = "1") int page,
                                 Model model, HttpServletRequest request) {
        return listProducts(page, name, model, request);
    }

    // Phương thức hiển thị ảnh
    @GetMapping("/images/{fileName:.+}")
    @ResponseBody
    public ResponseEntity<byte[]> getImage(@PathVariable String fileName) throws IOException {
        File file = new File(UPLOAD_DIR + "/images/" + fileName);
        if (!file.exists()) {
            return ResponseEntity.notFound().build();
        }

        String contentType = Files.probeContentType(file.toPath());
        if (contentType == null || !contentType.startsWith("image/")) {
            return ResponseEntity.badRequest().build();
        }

        byte[] image = Files.readAllBytes(file.toPath());
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(contentType))
                .body(image);
    }

    private String saveUploadedFile(MultipartFile file) throws IOException {
        if (file.isEmpty()) {
            return null;
        }

        // Tạo thư mục uploads nếu chưa tồn tại
        File uploadDir = new File(UPLOAD_DIR + "/images");
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Generate unique filename để tránh trùng lặp
        String originalFilename = file.getOriginalFilename();
        String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        String fileName = UUID.randomUUID().toString() + extension;

        // Lưu file
        String uploadPath = UPLOAD_DIR + "/images/" + fileName;
        file.transferTo(new File(uploadPath));
        System.out.println("Upload path: " + uploadPath);
        return fileName;
    }
}