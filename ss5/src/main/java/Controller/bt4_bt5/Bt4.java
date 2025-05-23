package Controller.bt4_bt5;

import Model.bt4_bt5.Sv;
import dao.Bt4DAO;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/bt4")
public class Bt4 extends HttpServlet {
    private Bt4DAO studentDAO;

    @Override
    public void init() throws ServletException {
        studentDAO = new Bt4DAO();
    }

    // Kiểm tra xem người dùng đã đăng nhập chưa
    private boolean isUserLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && Boolean.TRUE.equals(session.getAttribute("isLoggedIn"));
    }

    // Chuyển hướng đến trang đăng nhập nếu chưa đăng nhập
    private void redirectToLogin(HttpServletResponse response) throws IOException {
        response.sendRedirect("login");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Kiểm tra đăng nhập cho tất cả các action GET (trừ logout được xử lý ở LoginServlet)
        if (!isUserLoggedIn(request)) {
            redirectToLogin(response);
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listStudents(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteStudent(request, response);
                break;
            case "logout":
                logout(request, response);
                break;
            default:
                listStudents(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Kiểm tra đăng nhập trước khi thực hiện thao tác POST
        if (!isUserLoggedIn(request)) {
            redirectToLogin(response);
            return;
        }

        String action = request.getParameter("action");

        if ("update".equals(action)) {
            updateStudent(request, response);
        } else {
            // Redirect về list nếu action không hợp lệ
            response.sendRedirect("bt4?action=list");
        }
    }

    private void listStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Sv> students = studentDAO.getAllStudents();
        request.setAttribute("students", students);

        // Lấy thông tin user để hiển thị trên header
        HttpSession session = request.getSession(false);
        if (session != null) {
            String username = (String) session.getAttribute("username");
            request.setAttribute("currentUser", username);
        }

        request.getRequestDispatcher("/Views/bt4_bt5/student-list.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Sv student = studentDAO.getStudentById(id);

            if (student != null) {
                request.setAttribute("student", student);
                request.getRequestDispatcher("/Views/bt4_bt5/student-edit.jsp").forward(request, response);
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Không tìm thấy sinh viên với ID: " + id);
                response.sendRedirect("bt4?action=list");
            }
        } catch (NumberFormatException e) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "ID sinh viên không hợp lệ!");
            response.sendRedirect("bt4?action=list");
        }
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set encoding for Vietnamese characters
        request.setCharacterEncoding("UTF-8");

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            int age = Integer.parseInt(request.getParameter("age"));
            String address = request.getParameter("address");

            // Validate input
            if (name == null || name.trim().isEmpty()) {
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Tên sinh viên không được để trống!");
                response.sendRedirect("bt4?action=edit&id=" + id);
                return;
            }

            if (age < 1 || age > 100) {
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Tuổi phải từ 1 đến 100!");
                response.sendRedirect("bt4?action=edit&id=" + id);
                return;
            }

            if (address == null || address.trim().isEmpty()) {
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Địa chỉ không được để trống!");
                response.sendRedirect("bt4?action=edit&id=" + id);
                return;
            }

            Sv student = new Sv(id, name.trim(), age, address.trim());
            boolean updated = studentDAO.updateStudent(student);

            HttpSession session = request.getSession();
            if (updated) {
                session.setAttribute("successMessage", "Cập nhật thông tin sinh viên thành công!");
            } else {
                session.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật thông tin!");
            }

        } catch (NumberFormatException e) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Dữ liệu đầu vào không hợp lệ!");
        }

        response.sendRedirect("bt4?action=list");
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            // Kiểm tra xem sinh viên có tồn tại không
            Sv student = studentDAO.getStudentById(id);
            if (student == null) {
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Không tìm thấy sinh viên cần xóa!");
                response.sendRedirect("bt4?action=list");
                return;
            }

            boolean deleted = studentDAO.deleteStudent(id);
            HttpSession session = request.getSession();

            if (deleted) {
                session.setAttribute("successMessage", "Xóa sinh viên '" + student.getName() + "' thành công!");
            } else {
                session.setAttribute("errorMessage", "Có lỗi xảy ra khi xóa sinh viên!");
            }

        } catch (NumberFormatException e) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "ID sinh viên không hợp lệ!");
        }

        response.sendRedirect("bt4?action=list");
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("login");
    }
}