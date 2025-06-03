-- Tạo database
CREATE DATABASE IF NOT EXISTS de2;
USE de2;

-- Tạo bảng Department
CREATE TABLE IF NOT EXISTS department (
                                          department_id INT PRIMARY KEY AUTO_INCREMENT,
                                          department_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    status BIT DEFAULT 1
    );

-- Tạo bảng Employee
CREATE TABLE IF NOT EXISTS employee (
                                        employee_id INT PRIMARY KEY AUTO_INCREMENT,
                                        full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(20) NOT NULL UNIQUE,
    avatar_url VARCHAR(255),
    status BIT DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES department(department_id)
    );

-- ===== STORED PROCEDURES CHO DEPARTMENT =====

-- 1. Lấy danh sách tất cả phòng ban (theo thứ tự thêm mới nhất)
DELIMITER //
CREATE PROCEDURE sp_GetAllDepartments()
BEGIN
SELECT department_id, department_name, description, status
FROM department
ORDER BY department_id DESC;
END //
DELIMITER ;

-- 2. Thêm mới phòng ban
DELIMITER //
CREATE PROCEDURE sp_AddDepartment(
    IN p_department_name VARCHAR(50),
    IN p_description TEXT
)
BEGIN
    DECLARE department_exists INT DEFAULT 0;

    -- Kiểm tra tên phòng ban đã tồn tại chưa
SELECT COUNT(*) INTO department_exists
FROM department
WHERE department_name = p_department_name;

IF department_exists > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tên phòng ban đã tồn tại!';
ELSE
        INSERT INTO department (department_name, description)
        VALUES (p_department_name, p_description);
END IF;
END //
DELIMITER ;

-- 3. Lấy thông tin phòng ban theo ID
DELIMITER //
CREATE PROCEDURE sp_GetDepartmentById(
    IN p_department_id INT
)
BEGIN
SELECT department_id, department_name, description, status
FROM department
WHERE department_id = p_department_id;
END //
DELIMITER ;

-- 4. Cập nhật thông tin phòng ban
DELIMITER //
CREATE PROCEDURE sp_UpdateDepartment(
    IN p_department_id INT,
    IN p_department_name VARCHAR(50),
    IN p_description TEXT,
    IN p_status BIT
)
BEGIN
    DECLARE department_exists INT DEFAULT 0;
    DECLARE current_name VARCHAR(50);

    -- Lấy tên hiện tại của phòng ban
SELECT department_name INTO current_name
FROM department
WHERE department_id = p_department_id;

-- Kiểm tra nếu tên mới khác tên hiện tại thì kiểm tra trùng lặp
IF current_name != p_department_name THEN
SELECT COUNT(*) INTO department_exists
FROM department
WHERE department_name = p_department_name AND department_id != p_department_id;

IF department_exists > 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tên phòng ban đã tồn tại!';
END IF;
END IF;

UPDATE department
SET department_name = p_department_name,
    description = p_description,
    status = p_status
WHERE department_id = p_department_id;
END //
DELIMITER ;

-- 5. Tìm kiếm phòng ban theo tên
DELIMITER //
CREATE PROCEDURE sp_SearchDepartmentsByName(
    IN p_search_name VARCHAR(50)
)
BEGIN
SELECT department_id, department_name, description, status
FROM department
WHERE department_name LIKE CONCAT('%', p_search_name, '%')
ORDER BY department_id DESC;
END //
DELIMITER ;

-- 6. Xóa phòng ban
DELIMITER //
CREATE PROCEDURE sp_DeleteDepartment(
    IN p_department_id INT
)
BEGIN
    DECLARE employee_count INT DEFAULT 0;

    -- Kiểm tra có nhân viên nào thuộc phòng ban này không
SELECT COUNT(*) INTO employee_count
FROM employee
WHERE department_id = p_department_id;

IF employee_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Không thể xóa phòng ban đang có nhân viên!';
ELSE
DELETE FROM department WHERE department_id = p_department_id;
END IF;
END //
DELIMITER ;

-- ===== STORED PROCEDURES CHO EMPLOYEE =====

-- 7. Lấy danh sách tất cả nhân viên với thông tin phòng ban
DELIMITER //
CREATE PROCEDURE sp_GetAllEmployees()
BEGIN
SELECT e.employee_id, e.full_name, e.email, e.phone_number,
       e.avatar_url, e.status, e.created_at, e.department_id,
       d.department_name
FROM employee e
         JOIN department d ON e.department_id = d.department_id
ORDER BY e.created_at DESC;
END //
DELIMITER ;

-- 8. Lấy danh sách nhân viên với phân trang
DELIMITER //
CREATE PROCEDURE sp_GetEmployeesWithPaging(
    IN p_page INT,
    IN p_size INT
)
BEGIN
    DECLARE v_offset INT;
    SET v_offset = (p_page - 1) * p_size;

SELECT e.employee_id, e.full_name, e.email, e.phone_number,
       e.avatar_url, e.status, e.created_at, e.department_id,
       d.department_name
FROM employee e
         JOIN department d ON e.department_id = d.department_id
ORDER BY e.created_at DESC
    LIMIT p_size OFFSET v_offset;
END //
DELIMITER ;

-- 9. Đếm tổng số nhân viên (để tính phân trang)
DELIMITER //
CREATE PROCEDURE sp_CountAllEmployees()
BEGIN
SELECT COUNT(*) as total_employees FROM employee;
END //
DELIMITER ;

-- 10. Thêm mới nhân viên
DELIMITER //
CREATE PROCEDURE sp_AddEmployee(
    IN p_full_name VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_phone_number VARCHAR(20),
    IN p_avatar_url VARCHAR(255),
    IN p_department_id INT
)
BEGIN
    DECLARE department_exists INT DEFAULT 0;
    DECLARE email_exists INT DEFAULT 0;
    DECLARE phone_exists INT DEFAULT 0;

    -- Kiểm tra phòng ban có tồn tại không
SELECT COUNT(*) INTO department_exists
FROM department
WHERE department_id = p_department_id;

IF department_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Phòng ban không tồn tại!';
END IF;

    -- Kiểm tra email đã tồn tại chưa
SELECT COUNT(*) INTO email_exists
FROM employee
WHERE email = p_email;

IF email_exists > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email đã tồn tại!';
END IF;

    -- Kiểm tra số điện thoại đã tồn tại chưa
SELECT COUNT(*) INTO phone_exists
FROM employee
WHERE phone_number = p_phone_number;

IF phone_exists > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Số điện thoại đã tồn tại!';
END IF;

INSERT INTO employee (full_name, email, phone_number, avatar_url, department_id)
VALUES (p_full_name, p_email, p_phone_number, p_avatar_url, p_department_id);
END //
DELIMITER ;

-- 11. Lấy thông tin nhân viên theo ID
DELIMITER //
CREATE PROCEDURE sp_GetEmployeeById(
    IN p_employee_id INT
)
BEGIN
SELECT e.employee_id, e.full_name, e.email, e.phone_number,
       e.avatar_url, e.status, e.created_at, e.department_id,
       d.department_name
FROM employee e
         JOIN department d ON e.department_id = d.department_id
WHERE e.employee_id = p_employee_id;
END //
DELIMITER ;

-- 12. Cập nhật thông tin nhân viên
DELIMITER //
CREATE PROCEDURE sp_UpdateEmployee(
    IN p_employee_id INT,
    IN p_full_name VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_phone_number VARCHAR(20),
    IN p_avatar_url VARCHAR(255),
    IN p_status BIT,
    IN p_department_id INT
)
BEGIN
    DECLARE department_exists INT DEFAULT 0;
    DECLARE email_exists INT DEFAULT 0;
    DECLARE phone_exists INT DEFAULT 0;
    DECLARE current_email VARCHAR(100);
    DECLARE current_phone VARCHAR(20);

    -- Kiểm tra phòng ban có tồn tại không
SELECT COUNT(*) INTO department_exists
FROM department
WHERE department_id = p_department_id;

IF department_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Phòng ban không tồn tại!';
END IF;

    -- Lấy email và phone hiện tại
SELECT email, phone_number INTO current_email, current_phone
FROM employee
WHERE employee_id = p_employee_id;

-- Kiểm tra email nếu khác với email hiện tại
IF current_email != p_email THEN
SELECT COUNT(*) INTO email_exists
FROM employee
WHERE email = p_email AND employee_id != p_employee_id;

IF email_exists > 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email đã tồn tại!';
END IF;
END IF;

    -- Kiểm tra phone nếu khác với phone hiện tại
    IF current_phone != p_phone_number THEN
SELECT COUNT(*) INTO phone_exists
FROM employee
WHERE phone_number = p_phone_number AND employee_id != p_employee_id;

IF phone_exists > 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Số điện thoại đã tồn tại!';
END IF;
END IF;

UPDATE employee
SET full_name = p_full_name,
    email = p_email,
    phone_number = p_phone_number,
    avatar_url = p_avatar_url,
    status = p_status,
    department_id = p_department_id
WHERE employee_id = p_employee_id;
END //
DELIMITER ;

-- 13. Tìm kiếm nhân viên theo tên
DELIMITER //
CREATE PROCEDURE sp_SearchEmployeesByName(
    IN p_search_name VARCHAR(100)
)
BEGIN
SELECT e.employee_id, e.full_name, e.email, e.phone_number,
       e.avatar_url, e.status, e.created_at, e.department_id,
       d.department_name
FROM employee e
         JOIN department d ON e.department_id = d.department_id
WHERE e.full_name LIKE CONCAT('%', p_search_name, '%')
ORDER BY e.created_at DESC;
END //
DELIMITER ;

-- 14. Tìm kiếm nhân viên theo tên với phân trang
DELIMITER //
CREATE PROCEDURE sp_SearchEmployeesByNameWithPaging(
    IN p_search_name VARCHAR(100),
    IN p_page INT,
    IN p_size INT
)
BEGIN
    DECLARE v_offset INT;
    SET v_offset = (p_page - 1) * p_size;

SELECT e.employee_id, e.full_name, e.email, e.phone_number,
       e.avatar_url, e.status, e.created_at, e.department_id,
       d.department_name
FROM employee e
         JOIN department d ON e.department_id = d.department_id
WHERE e.full_name LIKE CONCAT('%', p_search_name, '%')
ORDER BY e.created_at DESC
    LIMIT p_size OFFSET v_offset;
END //
DELIMITER ;

-- 15. Đếm số nhân viên tìm được theo tên
DELIMITER //
CREATE PROCEDURE sp_CountSearchEmployees(
    IN p_search_name VARCHAR(100)
)
BEGIN
SELECT COUNT(*) as total_employees
FROM employee
WHERE full_name LIKE CONCAT('%', p_search_name, '%');
END //
DELIMITER ;

-- 16. Xóa nhân viên
DELIMITER //
CREATE PROCEDURE sp_DeleteEmployee(
    IN p_employee_id INT
)
BEGIN
DELETE FROM employee WHERE employee_id = p_employee_id;
END //
DELIMITER ;

-- 17. Lấy danh sách phòng ban active (để hiển thị trong dropdown)
DELIMITER //
CREATE PROCEDURE sp_GetActiveDepartments()
BEGIN
SELECT department_id, department_name
FROM department
WHERE status = 1
ORDER BY department_name;
END //
DELIMITER ;

-- Thêm dữ liệu mẫu cho department
INSERT INTO department (department_name, description) VALUES
                                                          ('Phòng Nhân sự', 'Quản lý nhân sự, tuyển dụng và đào tạo'),
                                                          ('Phòng Kế toán', 'Quản lý tài chính, kế toán công ty'),
                                                          ('Phòng IT', 'Phát triển và bảo trì hệ thống công nghệ thông tin'),
                                                          ('Phòng Marketing', 'Tiếp thị, quảng bá sản phẩm và dịch vụ'),
                                                          ('Phòng Kinh doanh', 'Bán hàng và chăm sóc khách hàng');

-- Thêm dữ liệu mẫu cho employee
INSERT INTO employee (full_name, email, phone_number, avatar_url, department_id) VALUES
                                                                                     ('Nguyễn Văn An', 'nguyenvanan@company.com', '0901234567', 'avatar1.jpg', 1),
                                                                                     ('Trần Thị Bình', 'tranthibinh@company.com', '0902345678', 'avatar2.jpg', 2),
                                                                                     ('Lê Văn Cường', 'levancuong@company.com', '0903456789', 'avatar3.jpg', 3),
                                                                                     ('Phạm Thị Dung', 'phamthidung@company.com', '0904567890', 'avatar4.jpg', 4),
                                                                                     ('Hoàng Văn Em', 'hoangvanem@company.com', '0905678901', 'avatar5.jpg', 5),
                                                                                     ('Vũ Thị Phương', 'vuthiphuong@company.com', '0906789012', 'avatar6.jpg', 1),
                                                                                     ('Đỗ Văn Giang', 'dovangiang@company.com', '0907890123', 'avatar7.jpg', 2),
                                                                                     ('Ngô Thị Hoa', 'ngothihoa@company.com', '0908901234', 'avatar8.jpg', 3),
                                                                                     ('Bùi Văn Inh', 'buivaninh@company.com', '0909012345', 'avatar9.jpg', 4),
                                                                                     ('Lý Thị Kim', 'lythikim@company.com', '0910123456', 'avatar10.jpg', 5),
                                                                                     ('Trương Văn Long', 'truongvanlong@company.com', '0911234567', 'avatar11.jpg', 1),
                                                                                     ('Cao Thị Mai', 'caothimai@company.com', '0912345678', 'avatar12.jpg', 2);