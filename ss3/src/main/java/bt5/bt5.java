package bt5;
import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
@WebServlet("/bt5")
public class bt5 extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("bt5/bt5.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name= req.getParameter("name");
        String pass= req.getParameter("pass");
        String email= req.getParameter("email");
        req.setAttribute("name",name);
        req.setAttribute("pass",pass);
        req.setAttribute("email",email);
        req.getRequestDispatcher("bt5/bt5.jsp").forward(req,resp);


    }
}
