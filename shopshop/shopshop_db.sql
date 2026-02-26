CREATE DATABASE IF NOT EXISTS shopshop;
USE shopshop;

-- 1. Bảng Danh mục
CREATE TABLE Category (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    status INT DEFAULT 1
);

-- 2. Bảng Người dùng
CREATE TABLE Users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    fullName VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255),
    role INT DEFAULT 0
);

-- 3. Bảng Sản phẩm (Chứa thông tin chung)
CREATE TABLE Product (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    image VARCHAR(255),
    price DOUBLE NOT NULL,
    description TEXT,
    category_id INT,
    quantity INT DEFAULT 0,
    FOREIGN KEY (category_id) REFERENCES Category(id)
);

-- 4. Bảng Biến thể (Màu sắc/Size)
CREATE TABLE ProductVariant (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    color VARCHAR(50),
    size VARCHAR(10),
    stock_quantity INT DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES Product(id)
);

-- 5. Bảng Đơn hàng
CREATE TABLE Orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    totalPrice DOUBLE,
    shipName VARCHAR(255),
    shipAddress VARCHAR(255),
    shipPhone VARCHAR(20),
    orderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    status INT DEFAULT 0,
    note text,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

-- 6. Bảng Chi tiết đơn hàng (Tham chiếu thẳng đến Biến thể)
CREATE TABLE OrderDetail (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    variant_id INT,
    quantity INT,
    price DOUBLE,
    FOREIGN KEY (order_id) REFERENCES Orders(id),
    FOREIGN KEY (variant_id) REFERENCES ProductVariant(id)
);