package dk.model.dao.bt1;

import dk.model.entity.Customer;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Repository
public class CustomerImpl implements CustomerDAO {
    @Autowired
    private SessionFactory sessionFactory;

    @Override
    @Transactional
    public void saveUser(Customer customer) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(customer);
    }

    @Override
    @Transactional
    public Customer getUserById(Long id) {
        Session session = sessionFactory.getCurrentSession();
        return session.get(Customer.class, id);
    }

    @Override
    @Transactional
    public List<Customer> getAllUsers() {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("from Customer", Customer.class).list();
    }

    @Override
    @Transactional
    public void deleteUser(Long id) {
        Session session = sessionFactory.getCurrentSession();
        Customer user = session.byId(Customer.class).load(id);
        session.delete(user);
    }

    @Override
    @Transactional(readOnly = true)
    public Customer findByUsername(String username) {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM Customer c WHERE c.username = :username", Customer.class)
                .setParameter("username", username)
                .uniqueResult();
    }

    @Override
    @Transactional(readOnly = true)
    public Customer findByEmail(String email) {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM Customer c WHERE c.email = :email", Customer.class)
                .setParameter("email", email)
                .uniqueResult();
    }

    @Override
    @Transactional(readOnly = true)
    public boolean existsByUsername(String username) {
        return findByUsername(username) != null;
    }

    @Override
    @Transactional(readOnly = true)
    public boolean existsByEmail(String email) {
        return findByEmail(email) != null;
    }
}