package dk.bt7;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "bt7", value = "/bt7/bt7")
public class bt7 extends HttpServlet {
    private static final List<Ticket> listTicket = new ArrayList<>();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Ticket ticket = new Ticket();
        ticket.setName(req.getParameter("name"));
        ticket.setClasss(req.getParameter("class"));
        ticket.setType(req.getParameter("type"));
        ticket.setLicensePlate(req.getParameter("licensePlate"));
        listTicket.add(ticket);
        req.setAttribute("tickets", listTicket);
        req.getRequestDispatcher("/bt7/listTicket.jsp").forward(req, resp);
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("tickets", listTicket);
        req.getRequestDispatcher("/bt7/listTicket.jsp").forward(req, resp);
    }
}