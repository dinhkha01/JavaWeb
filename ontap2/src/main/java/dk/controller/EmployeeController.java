
package dk.controller;

import dk.model.entity.Employee;
import dk.model.service.EmployeeService;
import dk.model.service.DepartmentService;
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
@RequestMapping("/employees")
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private ServletContext servletContext;

    private static final int PAGE_SIZE = 5;
    private static final String UPLOAD_DIR = "C:/uploads/employees";

    /**
     * Hiển thị danh sách nhân viên với tìm kiếm và phân trang
     */
    @GetMapping
    public String index(@RequestParam(value = "search", required = false) String search,
                        @RequestParam(value = "page", defaultValue = "1") int page,
                        Model model) {
        try {
            List<Employee> employees;
            int totalRecords;

            if (search != null && !search.trim().isEmpty()) {
                employees = employeeService.searchByNameWithPaging(search.trim(), page, PAGE_SIZE);
                totalRecords = employeeService.countSearchResults(search.trim());
                model.addAttribute("search", search);
                if (employees.isEmpty()) {
                    model.addAttribute("message", "Không tìm thấy nhân viên!");
                }
            } else {
                employees = employeeService.findAllWithPaging(page, PAGE_SIZE);
                totalRecords = employeeService.countAll();
                if (employees.isEmpty()) {
                    model.addAttribute("message", "Danh sách trống!");
                }
            }

            int totalPages = employeeService.getTotalPages(totalRecords, PAGE_SIZE);

            // Tính toán phân trang
            int startPage = Math.max(1, page - 2);
            int endPage = Math.min(totalPages, page + 2);

            model.addAttribute("employees", employees);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("totalRecords", totalRecords);
            model.addAttribute("startPage", startPage);
            model.addAttribute("endPage", endPage);

            return "employee/index";

        } catch (Exception e) {
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi tải danh sách nhân viên: " + e.getMessage());
            return "employee/index";
        }
    }

    /**
     * Hiển thị form thêm mới nhân viên
     */
    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("employee", new Employee());
        model.addAttribute("departments", departmentService.getActiveDepartments());
        return "employee/create";
    }

    /**
     * Xử lý thêm mới nhân viên
     */
    @PostMapping("/create")
    public String create(@Valid @ModelAttribute Employee employee,
                         BindingResult bindingResult,
                         @RequestParam("avatarFile") MultipartFile avatarFile,
                         RedirectAttributes redirectAttributes,
                         Model model) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("departments", departmentService.getActiveDepartments());
            return "employee/create";
        }

        try {
            // Xử lý upload ảnh
            if (!avatarFile.isEmpty()) {
                String fileName = saveUploadedFile(avatarFile);
                employee.setAvatarUrl("/employees/images/" + fileName);
            }

            employeeService.save(employee);
            redirectAttributes.addFlashAttribute("successMessage", "Thêm nhân viên thành công!");
            return "redirect:/employees";

        } catch (Exception e) {
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi thêm nhân viên: " + e.getMessage());
            model.addAttribute("departments", departmentService.getActiveDepartments());
            return "employee/create";
        }
    }

    /**
     * Hiển thị form chỉnh sửa nhân viên
     */
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Integer id, Model model, RedirectAttributes redirectAttributes) {
        try {
            Employee employee = employeeService.findById(id);
            if (employee == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy nhân viên với ID: " + id);
                return "redirect:/employees";
            }

            model.addAttribute("employee", employee);
            model.addAttribute("departments", departmentService.getActiveDepartments());
            return "employee/edit";

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi tải thông tin nhân viên: " + e.getMessage());
            return "redirect:/employees";
        }
    }

    /**
     * Xử lý cập nhật nhân viên
     */
    @PostMapping("/edit/{id}")
    public String update(@PathVariable Integer id,
                         @Valid @ModelAttribute Employee employee,
                         BindingResult bindingResult,
                         @RequestParam("avatarFile") MultipartFile avatarFile,
                         RedirectAttributes redirectAttributes,
                         Model model) {

        if (bindingResult.hasErrors()) {
            employee.setEmployeeId(id);
            model.addAttribute("departments", departmentService.getActiveDepartments());
            return "employee/edit";
        }

        try {
            // Lấy nhân viên hiện tại để giữ lại ảnh cũ nếu không upload ảnh mới
            Employee existingEmployee = employeeService.findById(id);
            if (existingEmployee == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy nhân viên với ID: " + id);
                return "redirect:/employees";
            }

            // Đảm bảo ID được set đúng
            employee.setEmployeeId(id);

            // Xử lý upload ảnh mới
            if (!avatarFile.isEmpty()) {
                String fileName = saveUploadedFile(avatarFile);
                employee.setAvatarUrl("/employees/images/" + fileName);
            } else {
                // Giữ lại ảnh cũ nếu không upload ảnh mới
                employee.setAvatarUrl(existingEmployee.getAvatarUrl());
            }

            employeeService.save(employee);
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật nhân viên thành công!");
            return "redirect:/employees";

        } catch (Exception e) {
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật nhân viên: " + e.getMessage());
            model.addAttribute("departments", departmentService.getActiveDepartments());
            return "employee/edit";
        }
    }

    /**
     * Xóa nhân viên
     */
    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        try {
            Employee employee = employeeService.findById(id);
            if (employee == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy nhân viên với ID: " + id);
                return "redirect:/employees";
            }

            // Xóa ảnh nếu có
            if (employee.getAvatarUrl() != null) {
                deleteImage(employee.getAvatarUrl());
            }

            employeeService.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa nhân viên thành công!");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi xóa nhân viên: " + e.getMessage());
        }

        return "redirect:/employees";
    }

    /**
     * Lấy ảnh từ server
     */
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

    /**
     * Lưu file upload
     */
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

    /**
     * Xóa ảnh
     */
    private void deleteImage(String imageUrl) {
        try {
            if (imageUrl != null && !imageUrl.isEmpty()) {
                String fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);
                String fullPath = UPLOAD_DIR + "/images/" + fileName;
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
}