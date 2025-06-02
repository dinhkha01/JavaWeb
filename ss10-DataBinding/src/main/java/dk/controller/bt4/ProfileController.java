package dk.controller.bt4;

import dk.model.entity.bt4.UserProfile;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

@Controller
public class ProfileController {

    @GetMapping("/profile")
    public String showProfilePage(Model model) {
        model.addAttribute("profile", new UserProfile());
        return "bt4";
    }

    @PostMapping("/profile")
    public String submit(@ModelAttribute UserProfile profile, Model model,
                         @RequestParam("file") MultipartFile file,
                         HttpServletRequest request) throws IOException {

        if (!file.isEmpty()) {
            // Lấy đường dẫn thực của webapp
            ServletContext context = request.getServletContext();
            String uploadPath = context.getRealPath("/") + "static/img/";

            // Tạo thư mục nếu chưa tồn tại
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Lưu file
            String fileName = file.getOriginalFilename();
            file.transferTo(new File(uploadPath + fileName));
            profile.setAvatar(fileName);
        } else {
            model.addAttribute("message", "Vui lòng chọn file.");
        }

        model.addAttribute("profile", profile);
        return "bt4";
    }
}