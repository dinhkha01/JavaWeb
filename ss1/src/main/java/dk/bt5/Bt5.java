package dk.bt5;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "bt4", value = "/b1")
public class Bt5 extends HttpServlet {
    public void switchErro(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
       try{
            int b = 1/0;

       } catch (ArithmeticException e) {
           response.sendRedirect("erro.jsp");
       }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        switchErro(request, response);
    }
}
