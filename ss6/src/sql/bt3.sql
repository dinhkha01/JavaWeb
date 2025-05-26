-- Tạo database
CREATE DATABASE IF NOT EXISTS ss6_bt3;
USE ss6_bt3;

-- Tạo bảng products
CREATE TABLE IF NOT EXISTS products (
                                        id INT AUTO_INCREMENT PRIMARY KEY,
                                        name VARCHAR(255) NOT NULL,
    price DOUBLE NOT NULL,
    imageUrl VARCHAR(500)
    );

-- Tạo bảng productCarts
CREATE TABLE IF NOT EXISTS productCarts (
                                            id INT AUTO_INCREMENT PRIMARY KEY,
                                            userId INT NOT NULL,
                                            productId INT NOT NULL,
                                            quantity INT NOT NULL DEFAULT 1,
                                            FOREIGN KEY (productId) REFERENCES products(id) ON DELETE CASCADE
    );

-- Insert dữ liệu mẫu cho products
INSERT INTO products (name, price, imageUrl) VALUES
                                                 ('iPhone 15 Pro Max', 1299.99, 'https://example.com/iphone15.jpg'),
                                                 ('Samsung Galaxy S24', 999.99, 'https://example.com/galaxy-s24.jpg'),
                                                 ('MacBook Pro M3', 2499.99, 'https://example.com/macbook-pro.jpg'),
                                                 ('iPad Air', 799.99, 'https://example.com/ipad-air.jpg'),
                                                 ('AirPods Pro', 249.99, 'https://example.com/airpods-pro.jpg'),
                                                 ('Dell XPS 13', 1199.99, 'https://example.com/dell-xps13.jpg'),
                                                 ('Sony WH-1000XM5', 399.99, 'https://example.com/sony-headphones.jpg'),
                                                 ('Nintendo Switch', 299.99, 'https://example.com/nintendo-switch.jpg'),
                                                 ('Apple Watch Series 9', 429.99, 'https://example.com/apple-watch.jpg'),
                                                 ('Google Pixel 8', 699.99, 'https://example.com/pixel-8.jpg');

-- Stored Procedures cho Products

-- Lấy tất cả sản phẩm
DELIMITER //
CREATE PROCEDURE GetAllProducts()
BEGIN
SELECT * FROM products ORDER BY id;
END //
DELIMITER ;

-- Lấy sản phẩm theo ID
DELIMITER //
CREATE PROCEDURE GetProductById(IN p_id INT)
BEGIN
SELECT * FROM products WHERE id = p_id;
END //
DELIMITER ;

-- Thêm sản phẩm mới
DELIMITER //
CREATE PROCEDURE AddProduct(
    IN p_name VARCHAR(255),
    IN p_price DOUBLE,
    IN p_imageUrl VARCHAR(500)
)
BEGIN
INSERT INTO products (name, price, imageUrl) VALUES (p_name, p_price, p_imageUrl);
SELECT LAST_INSERT_ID() as id;
END //
DELIMITER ;

-- Cập nhật sản phẩm
DELIMITER //
CREATE PROCEDURE UpdateProduct(
    IN p_id INT,
    IN p_name VARCHAR(255),
    IN p_price DOUBLE,
    IN p_imageUrl VARCHAR(500)
)
BEGIN
UPDATE products
SET name = p_name, price = p_price, imageUrl = p_imageUrl
WHERE id = p_id;
END //
DELIMITER ;

-- Xóa sản phẩm
DELIMITER //
CREATE PROCEDURE DeleteProduct(IN p_id INT)
BEGIN
DELETE FROM products WHERE id = p_id;
END //
DELIMITER ;

-- Stored Procedures cho ProductCarts

-- Lấy tất cả items trong giỏ hàng của user
DELIMITER //
CREATE PROCEDURE GetCartByUserId(IN p_userId INT)
BEGIN
SELECT
    pc.id,
    pc.userId,
    pc.productId,
    pc.quantity,
    p.name,
    p.price,
    p.imageUrl,
    (pc.quantity * p.price) as totalPrice
FROM productCarts pc
         JOIN products p ON pc.productId = p.id
WHERE pc.userId = p_userId;
END //
DELIMITER ;

-- Thêm sản phẩm vào giỏ hàng
DELIMITER //
CREATE PROCEDURE AddToCart(
    IN p_userId INT,
    IN p_productId INT,
    IN p_quantity INT
)
BEGIN
    DECLARE existing_quantity INT DEFAULT 0;

    -- Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
SELECT quantity INTO existing_quantity
FROM productCarts
WHERE userId = p_userId AND productId = p_productId;

IF existing_quantity > 0 THEN
        -- Nếu đã có thì cập nhật số lượng
UPDATE productCarts
SET quantity = quantity + p_quantity
WHERE userId = p_userId AND productId = p_productId;
ELSE
        -- Nếu chưa có thì thêm mới
        INSERT INTO productCarts (userId, productId, quantity)
        VALUES (p_userId, p_productId, p_quantity);
END IF;
END //
DELIMITER ;

-- Cập nhật số lượng sản phẩm trong giỏ hàng
DELIMITER //
CREATE PROCEDURE UpdateCartQuantity(
    IN p_id INT,
    IN p_quantity INT
)
BEGIN
UPDATE productCarts
SET quantity = p_quantity
WHERE id = p_id;
END //
DELIMITER ;

-- Xóa sản phẩm khỏi giỏ hàng
DELIMITER //
CREATE PROCEDURE RemoveFromCart(IN p_id INT)
BEGIN
DELETE FROM productCarts WHERE id = p_id;
END //
DELIMITER ;

-- Xóa tất cả sản phẩm của user khỏi giỏ hàng
DELIMITER //
CREATE PROCEDURE ClearCart(IN p_userId INT)
BEGIN
DELETE FROM productCarts WHERE userId = p_userId;
END //
DELIMITER ;

-- Lấy tổng tiền giỏ hàng
DELIMITER //
CREATE PROCEDURE GetCartTotal(IN p_userId INT)
BEGIN
SELECT
    COALESCE(SUM(pc.quantity * p.price), 0) as totalAmount,
    COUNT(*) as totalItems
FROM productCarts pc
         JOIN products p ON pc.productId = p.id
WHERE pc.userId = p_userId;
END //
DELIMITER ;

-- Kiểm tra sản phẩm có trong giỏ hàng không
DELIMITER //
CREATE PROCEDURE CheckProductInCart(
    IN p_userId INT,
    IN p_productId INT
)
BEGIN
SELECT * FROM productCarts
WHERE userId = p_userId AND productId = p_productId;
END //
DELIMITER ;