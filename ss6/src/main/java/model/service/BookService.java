package model.service.bt1;

import model.dao.bt1.BookDaoImpl;
import model.dao.bt1.IBookDao;
import model.entity.Book;
import java.util.List;

public class BookService {
    private IBookDao bookDao;

    public BookService() {
        this.bookDao = new BookDaoImpl();
    }

    public List<Book> getAllBooks() {
        return bookDao.findAll();
    }

    public Book getBookByCode(String bookCode) {
        return bookDao.findById(bookCode);
    }

    public void addBook(Book book) {
        bookDao.save(book);
    }

    public void updateBook(Book book) {
        bookDao.save(book);
    }

    public void deleteBook(String bookCode) {
        bookDao.deleteById(bookCode);
    }

    public List<Book> searchBooksByTitle(String title) {
        if (title == null || title.trim().isEmpty()) {
            return getAllBooks();
        }
        return bookDao.searchByTitle(title);
    }

    public List<Book> searchBooksByCode(String code) {
        if (code == null || code.trim().isEmpty()) {
            return getAllBooks();
        }
        return bookDao.searchByCode(code);
    }

    public boolean isBookCodeExists(String bookCode) {
        return bookDao.findById(bookCode) != null;
    }

    public boolean validateBook(Book book) {
        return book != null &&
                book.getBookCode() != null && !book.getBookCode().trim().isEmpty() &&
                book.getTitle() != null && !book.getTitle().trim().isEmpty() &&
                book.getAuthor() != null && !book.getAuthor().trim().isEmpty() &&
                book.getGenre() != null && !book.getGenre().trim().isEmpty() &&
                book.getQuantity() >= 0;
    }
}