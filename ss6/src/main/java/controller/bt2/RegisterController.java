package controller.bt2;

import model.entity.User;
import model.service.bt2.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        super.init();
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hiển thị trang register.jsp
        request.getRequestDispatcher("/Views/bt2/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý thông tin đăng ký
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        // Kiểm tra email đã tồn tại
        if (userService.isEmailExists(email)) {
            request.setAttribute("error", "Email đã tồn tại! Vui lòng sử dụng email khác.");
            request.setAttribute("userName", userName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/Views/bt2/register.jsp").forward(request, response);
            return;
        }

        // Tạo user mới
        User newUser = new User();
        newUser.setUserName(userName);
        newUser.setPassword(password);
        newUser.setEmail(email);
        newUser.setPhone(phone);

        // Đăng ký user
        if (userService.registerUser(newUser)) {
            request.setAttribute("success", "Đăng ký thành công! Bạn có thể đăng nhập ngay bây giờ.");
            request.getRequestDispatcher("/Views/bt2/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Đăng ký thất bại! Vui lòng thử lại.");
            request.setAttribute("userName", userName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/Views/bt2/register.jsp").forward(request, response);
        }
    }
}