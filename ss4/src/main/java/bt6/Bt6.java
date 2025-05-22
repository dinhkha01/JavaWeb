package bt6;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/bt6")
public class Bt6 extends HttpServlet {
    private static final List<User> listUser= new ArrayList<>();

    public void init() {
            listUser.add(new User("1","kha",22,8.0));
        listUser.add(new User("2","ha",20,9.0));
        listUser.add(new User("3","khai",25,5.0));
        listUser.add(new User("4","khao",10,1.0));
        listUser.add(new User("5","khayy",2,4.0));
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            req.setAttribute("users",listUser);
            req.getRequestDispatcher("/Views/bt6/bt6.jsp").forward(req,resp);
    }


}
