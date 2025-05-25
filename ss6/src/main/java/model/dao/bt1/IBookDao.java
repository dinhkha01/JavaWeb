package model.dao.bt1;

import model.dao.IGenericDao;
import model.entity.Book;
import java.util.List;

public interface IBookDao extends IGenericDao<Book, String> {
    List<Book> searchByTitle(String title);
    List<Book> searchByCode(String code);
}