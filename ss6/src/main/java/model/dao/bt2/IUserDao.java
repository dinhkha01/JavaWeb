package model.dao.bt2;

import model.dao.IGenericDao;
import model.entity.User;

public interface IUserDao<T, E> extends IGenericDao<T, E> {
    User findByEmailAndPassword(String email, String password);
    boolean isEmailExists(String email);
}