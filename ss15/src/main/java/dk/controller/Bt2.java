package dk.controller;

import dk.model.entity.bt2.Student;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Arrays;
import java.util.List;

@Controller
public class Bt2 {
    @GetMapping("/students")
    public String showList(Model model) {
        List<Student> students = Arrays.asList(
                new Student("Alice", 20, "a@vn.com", "123 Main St", "1234567890"),
                new Student("Bob", 22, "a2@vn.com", "456 Elm St", "0987654321"),
                new Student("Charlie", 21, "a3@vn.com", "789 Oak St", "1122334455")
                );
        model.addAttribute("students", students);
        return "bt2/listStudent";
    }
}
