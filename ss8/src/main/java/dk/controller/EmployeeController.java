package dk.controller;

import dk.model.entity.bt6.Employee;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
public class EmployeeController {
    public static List<Employee> employeeList = new ArrayList<Employee>() {{
        add(new Employee("Nguyen Van A", "a@vn.com", "Manager"));
        add(new Employee("Nguyen Van B", "b@vn.com", "Developer"));
        add(new Employee("Nguyen Van C", "c@cn.com", "Tester"));
    }};

    @GetMapping("/employees")
    public String getListEmployee(Model model) {

        model.addAttribute("employees", employeeList);
        return "bt6/listEmployee";
    }

    @GetMapping("/employees/add")
    public String getAddEmployee(Model model) {
        model.addAttribute("employee", new Employee());
        return "bt6/addEmployee";
    }

    @PostMapping("/employees")  // Fixed: Changed to match form action
    public String addEmployee(@ModelAttribute Employee employee) {
        employeeList.add(employee);
        return "redirect:/employees";
    }
}