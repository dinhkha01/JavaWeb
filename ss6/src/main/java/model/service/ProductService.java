package model.service;

import model.dao.bt3.IProductDao;
import model.dao.bt3.ProductDaoImpl;
import model.entity.Product;
import java.util.List;

public class ProductService {
    private IProductDao productDao;

    public ProductService() {
        this.productDao = new ProductDaoImpl();
    }

    /**
     * Lấy tất cả sản phẩm
     */
    public List<Product> getAllProducts() {
        return productDao.findAll();
    }

    /**
     * Lấy sản phẩm theo ID
     */
    public Product getProductById(int id) {
        if (id <= 0) {
            return null;
        }
        return productDao.findById(id);
    }

    /**
     * Thêm sản phẩm mới
     */
    public boolean addProduct(Product product) {
        if (product == null || product.getName() == null || product.getName().trim().isEmpty()) {
            return false;
        }
        if (product.getPrice() < 0) {
            return false;
        }

        try {
            // Đặt id = 0 để báo hiệu đây là thêm mới
            product.setId(0);
            productDao.save(product);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Cập nhật thông tin sản phẩm
     */
    public boolean updateProduct(Product product) {
        if (product == null || product.getId() <= 0) {
            return false;
        }
        if (product.getName() == null || product.getName().trim().isEmpty()) {
            return false;
        }
        if (product.getPrice() < 0) {
            return false;
        }

        try {
            productDao.save(product);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Xóa sản phẩm
     */
    public boolean deleteProduct(int id) {
        if (id <= 0) {
            return false;
        }

        try {
            productDao.deleteById(id);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Kiểm tra sản phẩm có tồn tại không
     */
    public boolean isProductExists(int id) {
        return getProductById(id) != null;
    }

    /**
     * Tìm kiếm sản phẩm theo tên
     */
    public List<Product> searchProductsByName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return getAllProducts();
        }

        List<Product> allProducts = getAllProducts();
        return allProducts.stream()
                .filter(product -> product.getName().toLowerCase().contains(name.toLowerCase()))
                .collect(java.util.stream.Collectors.toList());
    }

    /**
     * Lấy sản phẩm theo khoảng giá
     */
    public List<Product> getProductsByPriceRange(double minPrice, double maxPrice) {
        if (minPrice < 0 || maxPrice < 0 || minPrice > maxPrice) {
            return getAllProducts();
        }

        List<Product> allProducts = getAllProducts();
        return allProducts.stream()
                .filter(product -> product.getPrice() >= minPrice && product.getPrice() <= maxPrice)
                .collect(java.util.stream.Collectors.toList());
    }
}