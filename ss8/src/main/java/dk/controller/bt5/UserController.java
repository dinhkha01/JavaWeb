package dk.controller.bt5;

import dk.model.entity.bt5.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Arrays;
import java.util.List;

@Controller
public class UserController {

    @GetMapping("/users")
    public String showUserList(Model model) {
        User user1 =  new User("Nguyen Van A", " a@vn.com", "0123456789", "1990-01-01", 33);
        User user2 =  new User("Nguyen Van B", "b@vn.com", "0987654321", "1992-02-02", 31);
        User user3 =  new User("Nguyen Van C", "c@vn.com", "0123456789", "1995-03-03", 28);
        List<User> userList = Arrays.asList(user1, user2, user3);
        model.addAttribute("userList", userList);
        return "bt5/userList";
    }
}

