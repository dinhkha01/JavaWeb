package Controller.bt2;

import Model.bt2.Sv;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/confirm")
public class Confirm extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/Views/bt2/form.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Sv sv = new Sv();
        sv.setName(req.getParameter("svName"));
        sv.setAge(Integer.parseInt(req.getParameter("svAge")));
        sv.setAddress(req.getParameter("svAddress"));

        req.setAttribute("sv",sv);
        req.getRequestDispatcher("/Views/bt2/confirm.jsp").forward(req,resp);


    }
}
