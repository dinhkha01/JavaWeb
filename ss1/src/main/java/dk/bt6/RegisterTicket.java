package dk.bt6;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
@WebServlet(name = "RegisterTicket", value = "/bt6/bt6")
public class RegisterTicket  extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       String name = req.getParameter("name");
        String classs = req.getParameter("class");
        String type = req.getParameter("type");
        String licensePlate = req.getParameter("licensePlate");
        req.setAttribute("name", name);
        req.setAttribute("class", classs);
        req.setAttribute("type", type);
        req.setAttribute("licensePlate", licensePlate);
        handleRegister(req,resp);
    }
    public static void handleRegister(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/bt6/resultRegister.jsp").forward(req, resp);
    }
}
