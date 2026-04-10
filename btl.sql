USE shopshop;

-- ===========================
-- 1. THÊM DANH MỤC (Category)
-- ===========================
INSERT INTO Category (name, description, status, parent_id) VALUES
('Áo Thu Đông', 'Các loại áo mùa thu đông', 1, NULL),
('Áo Xuân Hè', 'Các loại áo mùa xuân hè', 1, NULL),
('Quần', 'Các loại qcategoryuần', 1, NULL),
('Phụ kiện', 'Các loại phụ kiện thời trang', 1, NULL);

-- ===========================
-- 2. THÊM SẢN PHẨM (Product)
-- Cột image: dùng đúng tên file trong thư mục assets/images/
-- ===========================
INSERT INTO Product (name, image, price, description, category_id, quantity) VALUES
('Áo Nỉ Fitted L.2.7812', './assets/images/product1.jpeg', 89000, 'Áo nỉ chất liệu cao cấp, form fitted', 1, 50),
('Áo Hoodie Oversize H.3.1234', './assets/images/product2.jpeg', 149000, 'Áo hoodie form oversize, chất nỉ bông', 1, 30),
('Áo Thun Basic T.1.5678', './assets/images/product1.jpeg', 59000, 'Áo thun basic 100% cotton', 2, 100),
('Áo Khoác Dù K.4.9012', './assets/images/product2.jpeg', 259000, 'Áo khoác dù chống nước, có mũ', 1, 20);

-- ===========================
-- 3. THÊM BIẾN THỂ (ProductVariant - Màu sắc & Size)
-- product_id: phải khớp với id sản phẩm vừa thêm ở trên
-- ===========================

-- Biến thể cho sản phẩm 1 (Áo Nỉ Fitted)
INSERT INTO ProductVariant (product_id, color, size, stock_quantity) VALUES
(1, 'Đen', 'S', 10),
(1, 'Đen', 'M', 15),
(1, 'Đen', 'L', 15),
(1, 'Đen', 'XL', 10),
(1, 'Xám', 'S', 5),
(1, 'Xám', 'M', 10),
(1, 'Xám', 'L', 5);

-- Biến thể cho sản phẩm 2 (Áo Hoodie)
INSERT INTO ProductVariant (product_id, color, size, stock_quantity) VALUES
(2, 'Trắng', 'M', 10),
(2, 'Trắng', 'L', 10),
(2, 'Trắng', 'XL', 5),
(2, 'Navy', 'M', 5);

-- Biến thể cho sản phẩm 3 (Áo Thun Basic)
INSERT INTO ProductVariant (product_id, color, size, stock_quantity) VALUES
(3, 'Trắng', 'S', 20),
(3, 'Trắng', 'M', 30),
(3, 'Trắng', 'L', 30),
(3, 'Trắng', 'XL', 20),
(3, 'Đen', 'S', 15),
(3, 'Đen', 'M', 15);

-- Biến thể cho sản phẩm 4 (Áo Khoác Dù)
INSERT INTO ProductVariant (product_id, color, size, stock_quantity) VALUES
(4, 'Xanh Rêu', 'M', 5),
(4, 'Xanh Rêu', 'L', 8),
(4, 'Đen', 'M', 7);
