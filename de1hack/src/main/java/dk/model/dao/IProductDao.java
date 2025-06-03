package dk.model.dao;

import dk.model.entity.Product;
import java.util.List;

public interface IProductDao extends IGenericDao<Product, Integer> {
    List<Product> findAllWithPaging(int page, int size);
    List<Product> searchByName(String name);
    List<Product> searchByNameWithPaging(String name, int page, int size);
    int getTotalProducts();
    int getTotalSearchProducts(String name);
}