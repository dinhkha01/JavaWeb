package Controller.bt4_bt5;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            // Xử lý đăng xuất
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("login?message=Đăng xuất thành công!");
        } else {
            // Kiểm tra nếu đã đăng nhập thì redirect đến trang quản lý
            if (isUserLoggedIn(request)) {
                response.sendRedirect("bt4?action=list");
                return;
            }

            // Hiển thị trang đăng nhập
        request.getRequestDispatcher("/Views/bt4_bt5/login.jsp").forward(request, response);

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Kiểm tra thông tin đăng nhập
        if (isValidUser(username, password)) {
            // Đăng nhập thành công
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("isLoggedIn", true);

            // Chuyển hướng đến trang quản lý sinh viên (sửa từ "student" thành "bt4")
            response.sendRedirect("bt4?action=list");
        } else {
            // Đăng nhập thất bại
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/Views/bt4_bt5/login.jsp").forward(request, response);
        }
    }

    // Kiểm tra xem người dùng đã đăng nhập chưa
    private boolean isUserLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && Boolean.TRUE.equals(session.getAttribute("isLoggedIn"));
    }

    private boolean isValidUser(String username, String password) {
        // Kiểm tra thông tin đăng nhập cố định
        return "admin".equals(username) && "123456789".equals(password);
    }
}