-- Tạo database
CREATE DATABASE IF NOT EXISTS de1;
USE de1;

-- Tạo bảng Category
CREATE TABLE IF NOT EXISTS category (
                                        category_id INT PRIMARY KEY AUTO_INCREMENT,
                                        category_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    status BIT DEFAULT 1
    );

-- Tạo bảng Product
CREATE TABLE IF NOT EXISTS product (
                                       product_id INT PRIMARY KEY AUTO_INCREMENT,
                                       product_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DOUBLE NOT NULL CHECK(price > 0),
    image_url VARCHAR(255),
    status BIT DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES category(category_id)
    );

-- ===== STORED PROCEDURES CHO CATEGORY =====

-- 1. Lấy danh sách tất cả danh mục (theo thứ tự thêm mới nhất)
DELIMITER //
CREATE PROCEDURE sp_GetAllCategories()
BEGIN
SELECT category_id, category_name, description, status
FROM category
ORDER BY category_id DESC;
END //
DELIMITER ;

-- 2. Thêm mới danh mục
DELIMITER //
CREATE PROCEDURE sp_AddCategory(
    IN p_category_name VARCHAR(50),
    IN p_description TEXT
)
BEGIN
    DECLARE category_exists INT DEFAULT 0;

    -- Kiểm tra tên danh mục đã tồn tại chưa
SELECT COUNT(*) INTO category_exists
FROM category
WHERE category_name = p_category_name;

IF category_exists > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tên danh mục đã tồn tại!';
ELSE
        INSERT INTO category (category_name, description)
        VALUES (p_category_name, p_description);
END IF;
END //
DELIMITER ;

-- 3. Lấy thông tin danh mục theo ID
DELIMITER //
CREATE PROCEDURE sp_GetCategoryById(
    IN p_category_id INT
)
BEGIN
SELECT category_id, category_name, description, status
FROM category
WHERE category_id = p_category_id;
END //
DELIMITER ;

-- 4. Cập nhật thông tin danh mục
DELIMITER //
CREATE PROCEDURE sp_UpdateCategory(
    IN p_category_id INT,
    IN p_category_name VARCHAR(50),
    IN p_description TEXT,
    IN p_status BIT
)
BEGIN
    DECLARE category_exists INT DEFAULT 0;
    DECLARE current_name VARCHAR(50);

    -- Lấy tên hiện tại của danh mục
SELECT category_name INTO current_name
FROM category
WHERE category_id = p_category_id;

-- Kiểm tra nếu tên mới khác tên hiện tại thì kiểm tra trùng lặp
IF current_name != p_category_name THEN
SELECT COUNT(*) INTO category_exists
FROM category
WHERE category_name = p_category_name AND category_id != p_category_id;

IF category_exists > 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tên danh mục đã tồn tại!';
END IF;
END IF;

UPDATE category
SET category_name = p_category_name,
    description = p_description,
    status = p_status
WHERE category_id = p_category_id;
END //
DELIMITER ;

-- 5. Tìm kiếm danh mục theo tên
DELIMITER //
CREATE PROCEDURE sp_SearchCategoriesByName(
    IN p_search_name VARCHAR(50)
)
BEGIN
SELECT category_id, category_name, description, status
FROM category
WHERE category_name LIKE CONCAT('%', p_search_name, '%')
ORDER BY category_id DESC;
END //
DELIMITER ;

-- 6. Xóa danh mục
DELIMITER //
CREATE PROCEDURE sp_DeleteCategory(
    IN p_category_id INT
)
BEGIN
    DECLARE product_count INT DEFAULT 0;

    -- Kiểm tra có sản phẩm nào thuộc danh mục này không
SELECT COUNT(*) INTO product_count
FROM product
WHERE category_id = p_category_id;

IF product_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Không thể xóa danh mục đang có sản phẩm!';
ELSE
DELETE FROM category WHERE category_id = p_category_id;
END IF;
END //
DELIMITER ;

-- ===== STORED PROCEDURES CHO PRODUCT =====

-- 7. Lấy danh sách tất cả sản phẩm với thông tin danh mục
DELIMITER //
CREATE PROCEDURE sp_GetAllProducts()
BEGIN
SELECT p.product_id, p.product_name, p.description, p.price,
       p.image_url, p.status, p.created_at, p.category_id,
       c.category_name
FROM product p
         JOIN category c ON p.category_id = c.category_id
ORDER BY p.created_at DESC;
END //
DELIMITER ;

-- 8. Lấy danh sách sản phẩm với phân trang
DELIMITER //
CREATE PROCEDURE sp_GetProductsWithPaging(
    IN p_page INT,
    IN p_size INT
)
BEGIN
    DECLARE v_offset INT;
    SET v_offset = (p_page - 1) * p_size;

SELECT p.product_id, p.product_name, p.description, p.price,
       p.image_url, p.status, p.created_at, p.category_id,
       c.category_name
FROM product p
         JOIN category c ON p.category_id = c.category_id
ORDER BY p.created_at DESC
    LIMIT p_size OFFSET v_offset;
END //
DELIMITER ;

-- 9. Đếm tổng số sản phẩm (để tính phân trang)
DELIMITER //
CREATE PROCEDURE sp_CountAllProducts()
BEGIN
SELECT COUNT(*) as total_products FROM product;
END //
DELIMITER ;

-- 10. Thêm mới sản phẩm
DELIMITER //
CREATE PROCEDURE sp_AddProduct(
    IN p_product_name VARCHAR(100),
    IN p_description TEXT,
    IN p_price DOUBLE,
    IN p_image_url VARCHAR(255),
    IN p_category_id INT
)
BEGIN
    DECLARE category_exists INT DEFAULT 0;

    -- Kiểm tra danh mục có tồn tại không
SELECT COUNT(*) INTO category_exists
FROM category
WHERE category_id = p_category_id;

IF category_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Danh mục không tồn tại!';
ELSE
        INSERT INTO product (product_name, description, price, image_url, category_id)
        VALUES (p_product_name, p_description, p_price, p_image_url, p_category_id);
END IF;
END //
DELIMITER ;

-- 11. Lấy thông tin sản phẩm theo ID
DELIMITER //
CREATE PROCEDURE sp_GetProductById(
    IN p_product_id INT
)
BEGIN
SELECT p.product_id, p.product_name, p.description, p.price,
       p.image_url, p.status, p.created_at, p.category_id,
       c.category_name
FROM product p
         JOIN category c ON p.category_id = c.category_id
WHERE p.product_id = p_product_id;
END //
DELIMITER ;

-- 12. Cập nhật thông tin sản phẩm
DELIMITER //
CREATE PROCEDURE sp_UpdateProduct(
    IN p_product_id INT,
    IN p_product_name VARCHAR(100),
    IN p_description TEXT,
    IN p_price DOUBLE,
    IN p_image_url VARCHAR(255),
    IN p_status BIT,
    IN p_category_id INT
)
BEGIN
    DECLARE category_exists INT DEFAULT 0;

    -- Kiểm tra danh mục có tồn tại không
SELECT COUNT(*) INTO category_exists
FROM category
WHERE category_id = p_category_id;

IF category_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Danh mục không tồn tại!';
ELSE
UPDATE product
SET product_name = p_product_name,
    description = p_description,
    price = p_price,
    image_url = p_image_url,
    status = p_status,
    category_id = p_category_id
WHERE product_id = p_product_id;
END IF;
END //
DELIMITER ;

-- 13. Tìm kiếm sản phẩm theo tên
DELIMITER //
CREATE PROCEDURE sp_SearchProductsByName(
    IN p_search_name VARCHAR(100)
)
BEGIN
SELECT p.product_id, p.product_name, p.description, p.price,
       p.image_url, p.status, p.created_at, p.category_id,
       c.category_name
FROM product p
         JOIN category c ON p.category_id = c.category_id
WHERE p.product_name LIKE CONCAT('%', p_search_name, '%')
ORDER BY p.created_at DESC;
END //
DELIMITER ;

-- 14. Tìm kiếm sản phẩm theo tên với phân trang
DELIMITER //
CREATE PROCEDURE sp_SearchProductsByNameWithPaging(
    IN p_search_name VARCHAR(100),
    IN p_page INT,
    IN p_size INT
)
BEGIN
    DECLARE v_offset INT;
    SET v_offset = (p_page - 1) * p_size;

SELECT p.product_id, p.product_name, p.description, p.price,
       p.image_url, p.status, p.created_at, p.category_id,
       c.category_name
FROM product p
         JOIN category c ON p.category_id = c.category_id
WHERE p.product_name LIKE CONCAT('%', p_search_name, '%')
ORDER BY p.created_at DESC
    LIMIT p_size OFFSET v_offset;
END //
DELIMITER ;

-- 15. Đếm số sản phẩm tìm được theo tên
DELIMITER //
CREATE PROCEDURE sp_CountSearchProducts(
    IN p_search_name VARCHAR(100)
)
BEGIN
SELECT COUNT(*) as total_products
FROM product
WHERE product_name LIKE CONCAT('%', p_search_name, '%');
END //
DELIMITER ;

-- 16. Xóa sản phẩm
DELIMITER //
CREATE PROCEDURE sp_DeleteProduct(
    IN p_product_id INT
)
BEGIN
DELETE FROM product WHERE product_id = p_product_id;
END //
DELIMITER ;

-- 17. Lấy danh sách danh mục active (để hiển thị trong dropdown)
DELIMITER //
CREATE PROCEDURE sp_GetActiveCategories()
BEGIN
SELECT category_id, category_name
FROM category
WHERE status = 1
ORDER BY category_name;
END //
DELIMITER ;


-- Thêm dữ liệu mẫu cho category
INSERT INTO category (category_name, description) VALUES
                                                      ('Sách văn học', 'Các loại sách văn học trong và ngoài nước'),
                                                      ('Sách khoa học', 'Sách về khoa học, công nghệ, toán học'),
                                                      ('Sách thiếu nhi', 'Sách dành cho trẻ em và thiếu nhi'),
                                                      ('Sách kinh tế', 'Sách về kinh tế, quản trị, kinh doanh'),
                                                      ('Sách ngoại ngữ', 'Sách học ngoại ngữ các loại');

-- Thêm dữ liệu mẫu cho product
INSERT INTO product (product_name, description, price, image_url, category_id) VALUES
                                                                                   ('Đắc nhân tâm', 'Cuốn sách kinh điển về nghệ thuật giao tiếp', 89000, 'dac-nhan-tam.jpg', 1),
                                                                                   ('Toán cao cấp A1', 'Giáo trình toán cao cấp cho sinh viên', 120000, 'toan-cao-cap.jpg', 2),
                                                                                   ('Truyện Kiều', 'Tác phẩm bất hủ của Nguyễn Du', 65000, 'truyen-kieu.jpg', 1),
                                                                                   ('Doraemon tập 1', 'Truyện tranh Doraemon cho thiếu nhi', 25000, 'doraemon-1.jpg', 3),
                                                                                   ('Quản trị học', 'Giáo trình quản trị học cơ bản', 150000, 'quan-tri-hoc.jpg', 4),
                                                                                   ('English Grammar', 'Sách ngữ pháp tiếng Anh cơ bản', 95000, 'english-grammar.jpg', 5),
                                                                                   ('Vật lý đại cương', 'Giáo trình vật lý cho sinh viên', 180000, 'vat-ly-dai-cuong.jpg', 2),
                                                                                   ('Truyện cổ tích', 'Tuyển tập truyện cổ tích Việt Nam', 45000, 'truyen-co-tich.jpg', 3),
                                                                                   ('Marketing căn bản', 'Sách về marketing và bán hàng', 135000, 'marketing-can-ban.jpg', 4),
                                                                                   ('TOEIC 600+', 'Sách luyện thi TOEIC đạt 600 điểm', 110000, 'toeic-600.jpg', 5),
                                                                                   ('Lập trình Java', 'Hướng dẫn lập trình Java từ cơ bản', 200000, 'lap-trinh-java.jpg', 2),
                                                                                   ('Thơ Xuân Diệu', 'Tuyển tập thơ của nhà thơ Xuân Diệu', 75000, 'tho-xuan-dieu.jpg', 1);
