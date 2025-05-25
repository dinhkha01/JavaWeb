package controller.bt5;

import java.io.IOException;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/GameServlet")
public class GameServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/Views/bt5/game.jsp").forward(req,resp);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy lựa chọn của người dùng
        String userChoice = request.getParameter("userChoice");

        // Tạo lựa chọn ngẫu nhiên
        String[] choices = {"rock", "paper", "scissors"};
        Random random = new Random();
        String computerChoice = choices[random.nextInt(3)];

        // Xác định người thắng
        String result = determineWinner(userChoice, computerChoice);

        // Chuyển đổi lựa chọn thành tiếng Việt
        String userChoiceVN = translateChoice(userChoice);
        String computerChoiceVN = translateChoice(computerChoice);

        // Gửi kết quả đến JSP
        request.setAttribute("userChoice", userChoiceVN);
        request.setAttribute("computerChoice", computerChoiceVN);
        request.setAttribute("result", result);

        request.getRequestDispatcher("/Views/bt5/result.jsp").forward(request, response);
    }

    private String determineWinner(String userChoice, String computerChoice) {
        if (userChoice.equals(computerChoice)) {
            return "Hòa!";
        }

        if ((userChoice.equals("rock") && computerChoice.equals("scissors")) ||
                (userChoice.equals("paper") && computerChoice.equals("rock")) ||
                (userChoice.equals("scissors") && computerChoice.equals("paper"))) {
            return "Bạn thắng!";
        } else {
            return "Máy tính thắng!";
        }
    }

    private String translateChoice(String choice) {
        switch (choice) {
            case "rock": return "Búa";
            case "paper": return "Lá";
            case "scissors": return "Kéo";
            default: return choice;
        }
    }
}