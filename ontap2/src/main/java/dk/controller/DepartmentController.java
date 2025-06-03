package dk.controller;

import dk.model.entity.Department;
import dk.model.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/departments")
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @GetMapping
    public String index(Model model, @RequestParam(value = "search", required = false) String search) {
        List<Department> departments;

        if (search != null && !search.trim().isEmpty()) {
            departments = departmentService.searchByName(search.trim());
            model.addAttribute("search", search);
            if (departments.isEmpty()) {
                model.addAttribute("message", "Không tìm thấy phòng ban!");
            }
        } else {
            departments = departmentService.findAll();
            if (departments.isEmpty()) {
                model.addAttribute("message", "Danh sách trống!");
            }
        }

        model.addAttribute("departments", departments);
        return "department/index";
    }

    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("department", new Department());
        return "department/create";
    }

    @PostMapping("/create")
    public String create(@Valid @ModelAttribute Department department,
                         BindingResult bindingResult,
                         RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            return "department/create";
        }

        try {
            departmentService.save(department);
            redirectAttributes.addFlashAttribute("successMessage", "Thêm phòng ban thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/departments";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Integer id, Model model) {
        Department department = departmentService.findById(id);
        if (department == null) {
            return "redirect:/departments";
        }
        model.addAttribute("department", department);
        return "department/edit";
    }

    @PostMapping("/edit/{id}")
    public String update(@PathVariable Integer id,
                         @Valid @ModelAttribute Department department,
                         BindingResult bindingResult,
                         RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            department.setDepartmentId(id);
            return "department/edit";
        }

        try {
            department.setDepartmentId(id);
            departmentService.save(department);
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật phòng ban thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/departments";
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        try {
            departmentService.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa phòng ban thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/departments";
    }
}