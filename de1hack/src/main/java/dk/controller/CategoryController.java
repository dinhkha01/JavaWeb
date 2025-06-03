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

    /**
     * Hiển thị danh sách danh mục với tìm kiếm
     */
    @GetMapping
    public String list(@RequestParam(value = "search", required = false) String search, Model model) {
        try {
            List<Category> categories;

            if (search != null && !search.trim().isEmpty()) {
                categories = categoryService.searchByName(search.trim());
                model.addAttribute("search", search);
            } else {
                categories = categoryService.findAll();
            }

            if (categories.isEmpty()) {
                if (search != null && !search.trim().isEmpty()) {
                    model.addAttribute("message", "Không tìm thấy danh mục nào với từ khóa: " + search);
                } else {
                    model.addAttribute("message", "Chưa có danh mục nào");
                }
            }

            model.addAttribute("categories", categories);
            return "categories/list";

        } catch (Exception e) {
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi tải danh sách danh mục: " + e.getMessage());
            return "categories/list";
        }
    }

    /**
     * Hiển thị form thêm mới danh mục
     */
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("category", new Category());
        return "categories/add-category";
    }

    /**
     * Xử lý thêm mới danh mục
     */
    @PostMapping("/add")
    public String add(@Valid @ModelAttribute("category") Category category,
                      BindingResult bindingResult,
                      RedirectAttributes redirectAttributes,
                      Model model) {

        if (bindingResult.hasErrors()) {
            return "categories/add-category";
        }

        try {
            // Set default status if not provided
            if (category.getStatus() == null) {
                category.setStatus(true);
            }

            categoryService.save(category);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Thêm danh mục '" + category.getCategoryName() + "' thành công!");
            return "redirect:/categories";

        } catch (Exception e) {
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi thêm danh mục: " + e.getMessage());
            return "categories/add-category";
        }
    }

    /**
     * Hiển thị form chỉnh sửa danh mục
     */
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
        try {
            Category category = categoryService.findById(id);
            if (category == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy danh mục với ID: " + id);
                return "redirect:/categories";
            }

            model.addAttribute("category", category);
            return "categories/edit-category";

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi tải thông tin danh mục: " + e.getMessage());
            return "redirect:/categories";
        }
    }

    /**
     * Xử lý cập nhật danh mục
     */
    @PostMapping("/edit/{id}")
    public String update(@PathVariable("id") Integer id,
                         @Valid @ModelAttribute("category") Category category,
                         BindingResult bindingResult,
                         RedirectAttributes redirectAttributes,
                         Model model) {

        if (bindingResult.hasErrors()) {
            return "categories/edit-category";
        }

        try {
            // Đảm bảo ID được set đúng
            category.setCategoryId(id);

            categoryService.save(category);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Cập nhật danh mục '" + category.getCategoryName() + "' thành công!");
            return "redirect:/categories";

        } catch (Exception e) {
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật danh mục: " + e.getMessage());
            return "categories/edit-category";
        }
    }

    /**
     * Xóa danh mục
     */
    @PostMapping("/delete/{id}")
    public String delete(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        try {
            Category category = categoryService.findById(id);
            if (category == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy danh mục với ID: " + id);
                return "redirect:/categories";
            }

            // Kiểm tra xem danh mục có thể xóa không (không có sản phẩm nào đang sử dụng)
            if (!categoryService.canDelete(id)) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "Không thể xóa danh mục '" + category.getCategoryName() + "' vì đang có sản phẩm sử dụng!");
                return "redirect:/categories";
            }

            categoryService.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Xóa danh mục '" + category.getCategoryName() + "' thành công!");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi xóa danh mục: " + e.getMessage());
        }

        return "redirect:/categories";
    }
}