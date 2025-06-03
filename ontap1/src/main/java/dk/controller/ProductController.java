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

import javax.servlet.ServletContext;
import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/products")
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ServletContext servletContext;

    private static final int PAGE_SIZE = 5;
    private static final String UPLOAD_DIR = "C:/uploads/products";

    /**
     * Hiển thị danh sách sản phẩm với tìm kiếm và phân trang
     */
    @GetMapping
    public String list(@RequestParam(value = "search", required = false) String search,
                       @RequestParam(value = "page", defaultValue = "1") int page,
                       Model model) {
        try {
            List<Product> products;
            int totalRecords;

            if (search != null && !search.trim().isEmpty()) {
                products = productService.searchByNameWithPaging(search.trim(), page, PAGE_SIZE);
                totalRecords = productService.getTotalSearchProducts(search.trim());
                model.addAttribute("search", search);
            } else {
                products = productService.findAllWithPaging(page, PAGE_SIZE);
                totalRecords = productService.getTotalProducts();
            }

            int totalPages = productService.getTotalPages(totalRecords, PAGE_SIZE);

            if (products.isEmpty()) {
                if (search != null && !search.trim().isEmpty()) {
                    model.addAttribute("message", "Không tìm thấy sản phẩm nào với từ khóa: " + search);
                } else {
                    model.addAttribute("message", "Chưa có sản phẩm nào");
                }
            }

            // Tính toán phân trang
            int startPage = Math.max(1, page - 2);
            int endPage = Math.min(totalPages, page + 2);

            model.addAttribute("products", products);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("totalRecords", totalRecords);
            model.addAttribute("startPage", startPage);
            model.addAttribute("endPage", endPage);

            return "products/list";

        } catch (Exception e) {
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi tải danh sách sản phẩm: " + e.getMessage());
            return "products/list";
        }
    }

    /**
     * Hiển thị form thêm mới sản phẩm
     */
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("product", new Product());
        model.addAttribute("categories", categoryService.getActiveCategories());
        return "products/add-product";
    }

    /**
     * Xử lý thêm mới sản phẩm
     */
    @PostMapping("/add")
    public String add(@Valid @ModelAttribute("product") Product product,
                      BindingResult bindingResult,
                      @RequestParam("imageFile") MultipartFile imageFile,
                      RedirectAttributes redirectAttributes,
                      Model model) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("categories", categoryService.getActiveCategories());
            return "products/add-product";
        }

        try {
            // Xử lý upload ảnh
            if (!imageFile.isEmpty()) {
                String fileName = saveUploadedFile(imageFile);
                product.setImageUrl("/products/images/" + fileName);
            }

            // Set default status if not provided
            if (product.getStatus() == null) {
                product.setStatus(true);
            }

            productService.save(product);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Thêm sản phẩm '" + product.getProductName() + "' thành công!");
            return "redirect:/products";

        } catch (Exception e) {
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi thêm sản phẩm: " + e.getMessage());
            model.addAttribute("categories", categoryService.getActiveCategories());
            return "products/add-product";
        }
    }

    /**
     * Hiển thị form chỉnh sửa sản phẩm
     */
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
        try {
            Product product = productService.findById(id);
            if (product == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy sản phẩm với ID: " + id);
                return "redirect:/products";
            }

            model.addAttribute("product", product);
            model.addAttribute("categories", categoryService.getActiveCategories());
            return "products/edit-product";

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi tải thông tin sản phẩm: " + e.getMessage());
            return "redirect:/products";
        }
    }

    /**
     * Xử lý cập nhật sản phẩm
     */
    @PostMapping("/edit/{id}")
    public String update(@PathVariable("id") Integer id,
                         @Valid @ModelAttribute("product") Product product,
                         BindingResult bindingResult,
                         @RequestParam("imageFile") MultipartFile imageFile,
                         RedirectAttributes redirectAttributes,
                         Model model) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("categories", categoryService.getActiveCategories());
            return "products/edit-product";
        }

        try {
            // Lấy sản phẩm hiện tại để giữ lại ảnh cũ nếu không upload ảnh mới
            Product existingProduct = productService.findById(id);
            if (existingProduct == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy sản phẩm với ID: " + id);
                return "redirect:/products";
            }

            // Đảm bảo ID được set đúng
            product.setProductId(id);

            // Xử lý upload ảnh mới
            if (!imageFile.isEmpty()) {
                String fileName = saveUploadedFile(imageFile);
                product.setImageUrl("/products/images/" + fileName);
            } else {
                // Keep existing image if no new image uploaded
                product.setImageUrl(existingProduct.getImageUrl());
            }

            productService.save(product);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Cập nhật sản phẩm '" + product.getProductName() + "' thành công!");
            return "redirect:/products";

        } catch (Exception e) {
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật sản phẩm: " + e.getMessage());
            model.addAttribute("categories", categoryService.getActiveCategories());
            return "products/edit-product";
        }
    }

    /**
     * Xóa sản phẩm
     */
    @PostMapping("/delete/{id}")
    public String delete(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        try {
            Product product = productService.findById(id);
            if (product == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy sản phẩm với ID: " + id);
                return "redirect:/products";
            }

            // Xóa ảnh nếu có
            if (product.getImageUrl() != null) {
                deleteImage(product.getImageUrl());
            }

            productService.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Xóa sản phẩm '" + product.getProductName() + "' thành công!");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi xóa sản phẩm: " + e.getMessage());
        }

        return "redirect:/products";
    }

    /**
     * Lưu ảnh upload
     */
    private String saveImage(MultipartFile file) throws IOException {
        if (file.isEmpty()) {
            return null;
        }

        // Tạo thư mục nếu chưa tồn tại
        String uploadPath = servletContext.getRealPath("") + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Tạo tên file unique
        String originalFilename = file.getOriginalFilename();
        String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        String filename = UUID.randomUUID().toString() + extension;

        // Lưu file
        Path filePath = Paths.get(uploadPath + filename);
        Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

        return UPLOAD_DIR + filename;
    }

    /**
     * Xóa ảnh
     */
    private void deleteImage(String imageUrl) {
        try {
            if (imageUrl != null && !imageUrl.isEmpty()) {
                String fullPath = servletContext.getRealPath("") + imageUrl;
                File file = new File(fullPath);
                if (file.exists()) {
                    file.delete();
                }
            }
        } catch (Exception e) {
            // Log error but don't throw exception
            System.err.println("Error deleting image: " + e.getMessage());
        }
    }
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
        return fileName;
    }
}