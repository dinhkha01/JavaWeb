package Controller.bt3;

import Model.bt2.Sv;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/confirmbt3")
public class Confirm extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/Views/bt3/form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<String> errors = new ArrayList<>();
        Sv sv = new Sv();

        try {

            String name = req.getParameter("svName");
            if (name == null || name.trim().isEmpty()) {
                errors.add("Tên không được để trống");
            } else if (name.trim().length() < 2) {
                errors.add("Tên phải có ít nhất 2 ký tự");
            } else {
                sv.setName(name.trim());
            }
            String ageStr = req.getParameter("svAge");
            if (ageStr == null || ageStr.trim().isEmpty()) {
                errors.add("Tuổi không được để trống");
            } else {
                try {
                    int age = Integer.parseInt(ageStr.trim());
                    if (age < 0 || age > 100) {
                        errors.add("Tuổi phải từ 0 đến 100");
                    } else {
                        sv.setAge(age);
                    }
                } catch (NumberFormatException e) {
                    errors.add("Tuổi phải là số nguyên hợp lệ");
                }
            }
            String address = req.getParameter("svAddress");
            if (address == null || address.trim().isEmpty()) {
                errors.add("Địa chỉ không được để trống");
            } else if (address.trim().length() < 5) {
                errors.add("Địa chỉ phải có ít nhất 5 ký tự");
            } else {
                sv.setAddress(address.trim());
            }


            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
                req.getRequestDispatcher("/Views/bt3/form.jsp").forward(req, resp);
                return;
            }
            req.setAttribute("sv", sv);
            req.getRequestDispatcher("/Views/bt3/confirm.jsp").forward(req, resp);
        } catch (Exception e) {
            errors.add("Đã xảy ra lỗi trong quá trình xử lý dữ liệu");
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/Views/bt3/form.jsp").forward(req, resp);
        }
    }
}