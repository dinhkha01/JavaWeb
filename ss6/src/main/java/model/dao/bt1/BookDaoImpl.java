package model.dao.bt1;

import configs.ConnectionDB;
import model.entity.Book;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDaoImpl implements IBookDao {

    @Override
    public List<Book> findAll() {
        List<Book> books = new ArrayList<>();
        Connection conn = null;
        CallableStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionDB.openConnection();
            stmt = conn.prepareCall("{CALL sp_GetAllBooks()}");
            rs = stmt.executeQuery();

            while (rs.next()) {
                Book book = new Book();
                book.setBookCode(rs.getString("book_code"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setGenre(rs.getString("genre"));
                book.setQuantity(rs.getInt("quantity"));
                books.add(book);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách sách: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }

        return books;
    }

    @Override
    public Book findById(String bookCode) {
        Book book = null;
        Connection conn = null;
        CallableStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionDB.openConnection();
            stmt = conn.prepareCall("{CALL sp_GetBookByCode(?)}");
            stmt.setString(1, bookCode);
            rs = stmt.executeQuery();

            if (rs.next()) {
                book = new Book();
                book.setBookCode(rs.getString("book_code"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setGenre(rs.getString("genre"));
                book.setQuantity(rs.getInt("quantity"));
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm sách theo mã: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }

        return book;
    }

    @Override
    public void save(Book book) {
        Connection conn = null;
        CallableStatement stmt = null;

        try {
            conn = ConnectionDB.openConnection();

            // Kiểm tra xem sách đã tồn tại chưa
            Book existingBook = findById(book.getBookCode());

            if (existingBook == null) {
                // Thêm mới
                stmt = conn.prepareCall("{CALL sp_AddBook(?, ?, ?, ?, ?)}");
            } else {
                // Cập nhật
                stmt = conn.prepareCall("{CALL sp_UpdateBook(?, ?, ?, ?, ?)}");
            }

            stmt.setString(1, book.getBookCode());
            stmt.setString(2, book.getTitle());
            stmt.setString(3, book.getAuthor());
            stmt.setString(4, book.getGenre());
            stmt.setInt(5, book.getQuantity());

            stmt.executeUpdate();

        } catch (SQLException e) {
            System.err.println("Lỗi khi lưu sách: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Không thể lưu sách", e);
        } finally {
            closeResources(conn, stmt, null);
        }
    }

    @Override
    public void deleteById(String bookCode) {
        Connection conn = null;
        CallableStatement stmt = null;

        try {
            conn = ConnectionDB.openConnection();
            stmt = conn.prepareCall("{CALL sp_DeleteBook(?)}");
            stmt.setString(1, bookCode);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected == 0) {
                throw new RuntimeException("Không tìm thấy sách với mã: " + bookCode);
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa sách: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Không thể xóa sách", e);
        } finally {
            closeResources(conn, stmt, null);
        }
    }

    @Override
    public List<Book> searchByTitle(String title) {
        List<Book> books = new ArrayList<>();
        Connection conn = null;
        CallableStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionDB.openConnection();
            stmt = conn.prepareCall("{CALL sp_SearchBooksByTitle(?)}");
            stmt.setString(1, "%" + title + "%");
            rs = stmt.executeQuery();

            while (rs.next()) {
                Book book = new Book();
                book.setBookCode(rs.getString("book_code"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setGenre(rs.getString("genre"));
                book.setQuantity(rs.getInt("quantity"));
                books.add(book);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm kiếm sách theo tiêu đề: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }

        return books;
    }

    @Override
    public List<Book> searchByCode(String code) {
        List<Book> books = new ArrayList<>();
        Connection conn = null;
        CallableStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionDB.openConnection();
            stmt = conn.prepareCall("{CALL sp_SearchBooksByCode(?)}");
            stmt.setString(1, "%" + code + "%");
            rs = stmt.executeQuery();

            while (rs.next()) {
                Book book = new Book();
                book.setBookCode(rs.getString("book_code"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setGenre(rs.getString("genre"));
                book.setQuantity(rs.getInt("quantity"));
                books.add(book);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm kiếm sách theo mã: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }

        return books;
    }

    /**
     * Đóng các tài nguyên database
     */
    private void closeResources(Connection conn, Statement stmt, ResultSet rs) {
        try {
            if (rs != null && !rs.isClosed()) {
                rs.close();
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi đóng ResultSet: " + e.getMessage());
        }

        try {
            if (stmt != null && !stmt.isClosed()) {
                stmt.close();
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi đóng Statement: " + e.getMessage());
        }

        ConnectionDB.closeConnection(conn);
    }

    /**
     * Kiểm tra sách có tồn tại không
     */
    public boolean existsByCode(String bookCode) {
        return findById(bookCode) != null;
    }

    /**
     * Đếm tổng số sách
     */
    public int countBooks() {
        int count = 0;
        Connection conn = null;
        CallableStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionDB.openConnection();
            stmt = conn.prepareCall("{CALL sp_CountBooks()}");
            rs = stmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi đếm số sách: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }

        return count;
    }

    /**
     * Lấy danh sách sách hết hàng
     */
    public List<Book> getOutOfStockBooks() {
        List<Book> books = new ArrayList<>();
        Connection conn = null;
        CallableStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionDB.openConnection();
            stmt = conn.prepareCall("{CALL sp_GetOutOfStockBooks()}");
            rs = stmt.executeQuery();

            while (rs.next()) {
                Book book = new Book();
                book.setBookCode(rs.getString("book_code"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setGenre(rs.getString("genre"));
                book.setQuantity(rs.getInt("quantity"));
                books.add(book);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách sách hết hàng: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }

        return books;
    }
}