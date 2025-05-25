package controller.bt1;

import model.entity.Book;
import model.service.bt1.BookService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/books")
public class BookController extends HttpServlet {
    private BookService bookService;

    @Override
    public void init() throws ServletException {
        super.init();
        bookService = new BookService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listBooks(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "search":
                searchBooks(request, response);
                break;
            default:
                listBooks(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("books");
            return;
        }

        switch (action) {
            case "create":
                createBook(request, response);
                break;
            case "update":
                updateBook(request, response);
                break;
            case "delete":
                deleteBook(request, response);
                break;
            default:
                response.sendRedirect("books");
                break;
        }
    }

    private void listBooks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Book> books = bookService.getAllBooks();
        request.setAttribute("books", books);
        request.getRequestDispatcher("/Views/bt1/listBook.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Views/bt1/formAdd.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookCode = request.getParameter("bookCode");

        if (bookCode != null && !bookCode.trim().isEmpty()) {
            Book book = bookService.getBookByCode(bookCode);
            if (book != null) {
                request.setAttribute("book", book);
                request.getRequestDispatcher("/Views/bt1/formEdit.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Không tìm thấy sách với mã: " + bookCode);
                listBooks(request, response);
            }
        } else {
            response.sendRedirect("books");
        }
    }

    private void createBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookCode = request.getParameter("bookCode");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String genre = request.getParameter("genre");
        String quantityStr = request.getParameter("quantity");

        try {
            int quantity = Integer.parseInt(quantityStr);
            Book book = new Book(bookCode, title, author, genre, quantity);

            if (!bookService.validateBook(book)) {
                request.setAttribute("error", "Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.");
                request.setAttribute("book", book);
                request.getRequestDispatcher("/Views/bt1/formAdd.jsp").forward(request, response);
                return;
            }

            if (bookService.isBookCodeExists(bookCode)) {
                request.setAttribute("error", "Mã sách đã tồn tại. Vui lòng chọn mã khác.");
                request.setAttribute("book", book);
                request.getRequestDispatcher("/Views/bt1/formAdd.jsp").forward(request, response);
                return;
            }

            bookService.addBook(book);
            response.sendRedirect("books?success=add");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Số lượng phải là một số nguyên hợp lệ.");
            request.setAttribute("book", new Book(bookCode, title, author, genre, 0));
            request.getRequestDispatcher("/Views/bt1/formAdd.jsp").forward(request, response);
        }
    }

    private void updateBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookCode = request.getParameter("bookCode");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String genre = request.getParameter("genre");
        String quantityStr = request.getParameter("quantity");

        try {
            int quantity = Integer.parseInt(quantityStr);
            Book book = new Book(bookCode, title, author, genre, quantity);

            if (!bookService.validateBook(book)) {
                request.setAttribute("error", "Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.");
                request.setAttribute("book", book);
                request.getRequestDispatcher("/Views/bt1/formEdit.jsp").forward(request, response);
                return;
            }

            bookService.updateBook(book);
            response.sendRedirect("books?success=update");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Số lượng phải là một số nguyên hợp lệ.");
            request.setAttribute("book", new Book(bookCode, title, author, genre, 0));
            request.getRequestDispatcher("/Views/bt1/formEdit.jsp").forward(request, response);
        }
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookCode = request.getParameter("bookCode");

        if (bookCode != null && !bookCode.trim().isEmpty()) {
            bookService.deleteBook(bookCode);
            response.sendRedirect("books?success=delete");
        } else {
            response.sendRedirect("books?error=invalid_code");
        }
    }

    private void searchBooks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchType = request.getParameter("searchType");
        String searchValue = request.getParameter("searchValue");

        List<Book> books;

        if (searchValue == null || searchValue.trim().isEmpty()) {
            books = bookService.getAllBooks();
        } else {
            if ("title".equals(searchType)) {
                books = bookService.searchBooksByTitle(searchValue);
            } else if ("code".equals(searchType)) {
                books = bookService.searchBooksByCode(searchValue);
            } else {
                books = bookService.getAllBooks();
            }
        }

        request.setAttribute("books", books);
        request.setAttribute("searchType", searchType);
        request.setAttribute("searchValue", searchValue);
        request.getRequestDispatcher("/Views/bt1/listBook.jsp").forward(request, response);
    }
}