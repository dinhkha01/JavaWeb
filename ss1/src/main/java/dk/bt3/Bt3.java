package dk.bt3;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "bt3", value = "/bt3")
public class Bt3 extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");
        Student stu = new Student();
        stu.setName("kha");
        stu.setAge(21);
        request.setAttribute("stu",stu);
        request.getRequestDispatcher("bt3.jsp").forward(request,response);
    }


}
