
package dk.controller;

import dk.model.entity.Category;
import dk.model.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/categories")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @GetMapping
    public String listCategories(@RequestParam(value = "search", required = false) String search, Model model) {
        List<Category> categories;

        if (search != null && !search.trim().isEmpty()) {
            categories = categoryService.searchByName(search.trim());
            model.addAttribute("search", search);
            if (categories.isEmpty()) {
                model.addAttribute("message", "Không tìm thấy danh mục!");
            }
        } else {
            categories = categoryService.findAll();
            if (categories.isEmpty()) {
                model.addAttribute("message", "Danh sách trống!");
            }
        }

        model.addAttribute("categories", categories);
        return "category/list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("category", new Category());
        return "category/form";
    }

    @PostMapping("/add")
    public String addCategory(@Valid @ModelAttribute("category") Category category,
                              BindingResult result,
                              Model model,
                              RedirectAttributes redirectAttributes) {

        // Debug: In ra các lỗi validation
        if (result.hasErrors()) {
            System.out.println("Validation errors found:");
            result.getAllErrors().forEach(error -> {
                System.out.println("Error: " + error.getDefaultMessage());
            });

            // Đảm bảo model có category object để form hiển thị lại
            model.addAttribute("category", category);
            return "category/form";
        }

        try {
            categoryService.save(category);
            redirectAttributes.addFlashAttribute("successMessage", "Thêm danh mục thành công!");
        } catch (RuntimeException e) {
            model.addAttribute("category", category);
            model.addAttribute("errorMessage", e.getMessage());
            return "category/form";
        }

        return "redirect:/categories";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Integer id, Model model) {
        Category category = categoryService.findById(id);
        if (category == null) {
            return "redirect:/categories";
        }
        model.addAttribute("category", category);
        return "category/form";
    }

    @PostMapping("/edit/{id}")
    public String updateCategory(@PathVariable Integer id,
                                 @Valid @ModelAttribute("category") Category category,
                                 BindingResult result,
                                 Model model,
                                 RedirectAttributes redirectAttributes) {

        if (result.hasErrors()) {
            // Debug: In ra các lỗi validation
            System.out.println("Validation errors found in update:");
            result.getAllErrors().forEach(error -> {
                System.out.println("Error: " + error.getDefaultMessage());
            });

            category.setCategoryId(id); // Đảm bảo ID được set
            model.addAttribute("category", category);
            return "category/form";
        }

        try {
            category.setCategoryId(id);
            categoryService.save(category);
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật danh mục thành công!");
        } catch (RuntimeException e) {
            category.setCategoryId(id);
            model.addAttribute("category", category);
            model.addAttribute("errorMessage", e.getMessage());
            return "category/form";
        }

        return "redirect:/categories";
    }

    @PostMapping("/delete/{id}")
    public String deleteCategory(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        try {
            if (!categoryService.canDelete(id)) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không thể xóa danh mục đang có sản phẩm!");
            } else {
                categoryService.deleteById(id);
                redirectAttributes.addFlashAttribute("successMessage", "Xóa danh mục thành công!");
            }
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/categories";
    }

    @GetMapping("/search")
    public String searchCategories(@RequestParam("name") String name, Model model) {
        return listCategories(name, model);
    }
}