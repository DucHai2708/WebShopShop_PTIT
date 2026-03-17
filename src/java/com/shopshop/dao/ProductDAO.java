package com.shopshop.dao;

import com.shopshop.context.DBContext;
import com.shopshop.model.Product;
import com.shopshop.model.ProductVariant;
import java.sql.*;
import java.util.*;

public class ProductDAO extends DBContext {

    //Ham lay danh sach cac bien the cua 1 san pham
    public List<ProductVariant> getVariantProductId(int productId) {
        List<ProductVariant> list = new ArrayList<>();
        String sql = "SELECT * FROM ProductVariant WHERE product_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new ProductVariant(
                            rs.getInt("id"),
                            rs.getInt("product_id"),
                            rs.getString("color"),
                            rs.getString("size"),
                            rs.getInt("stock_quantity")
                    ));
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //Ham lay tat ca cac san pham va nap luon cac bien the vao doi tuong san pham do
    public List<Product> getAll() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Product";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getDouble("price"),
                        rs.getString("description"),
                        rs.getInt("category_id"),
                        rs.getInt("quantity")
                );
                p.setVariants(this.getVariantProductId(p.getId()));
                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Ham lay danh sach san pham dua tren id
    public Product getProductById(int id) {
        String sql = "SELECT * FROM Product WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id); // Truyền ID khách muốn xem vào đây

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) { // Dùng if vì chỉ có 1 sản phẩm duy nhất
                    Product p = new Product(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("image"),
                            rs.getDouble("price"),
                            rs.getString("description"),
                            rs.getInt("category_id"),
                            rs.getInt("quantity")
                    );

                    p.setVariants(this.getVariantProductId(p.getId()));
                    return p;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Ham loc san pham dua tren danh muc (vi du: chi hien ao khoac)
    public List<Product> getProductByCategoryId(int cid) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE category_id = ? "
                + "OR category_id IN (SELECT id FROM Category WHERE parent_id = ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cid);
            ps.setInt(2, cid);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("image"),
                            rs.getDouble("price"),
                            rs.getString("description"),
                            rs.getInt("category_id"),
                            rs.getInt("quantity")
                    );
                    p.setVariants(this.getVariantProductId(p.getId()));
                    list.add(p);
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //Ham tim kiem san pham
    public List<Product> searchByName(String txtSearch) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE name LIKE ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + txtSearch + "%"); // tim kiem tuong doi : %
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("image"),
                            rs.getDouble("price"),
                            rs.getString("description"),
                            rs.getInt("category_id"),
                            rs.getInt("quantity")
                    );
                    p.setVariants(this.getVariantProductId(p.getId()));
                    list.add(p);
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Hàm lọc sản phẩm theo khoảng giá tiền
    public List<Product> getProductByPrice(double min, double max) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE price BETWEEN ? AND ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, min);
            ps.setDouble(2, max);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("image"),
                            rs.getDouble("price"),
                            rs.getString("description"),
                            rs.getInt("category_id"),
                            rs.getInt("quantity")
                    );
                    p.setVariants(this.getVariantProductId(p.getId()));
                    list.add(p);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //Các hàm CRUD 
    // 1. Hàm THÊM sản phẩm mới (Trả về ID vừa tạo)
    public int insertProduct(Product p) {
        String sql = "INSERT INTO Product (name, image, price, description, category_id, quantity) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, p.getName());
            ps.setString(2, p.getImage());
            ps.setDouble(3, p.getPrice());
            ps.setString(4, p.getDescription());
            ps.setInt(5, p.getCategory_id());
            ps.setInt(6, p.getQuantity());

            ps.executeUpdate();

            // Lấy ID vừa tự động tạo để sau này thêm Size/Màu cho đúng ID này
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // cột số 1
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Hàm thêm một biến thể (Size/Màu) cho sản phẩm
    public boolean insertVariant(ProductVariant pv) {
        String sql = "INSERT INTO ProductVariant (product_id, color, size, stock_quantity) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, pv.getProduct_id()); // ID của sản phẩm vừa tạo ở bước 1
            ps.setString(2, pv.getColor());
            ps.setString(3, pv.getSize());
            ps.setInt(4, pv.getStock_quantity());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

// 2. Hàm CẬP NHẬT thông tin sản phẩm
    public boolean updateProduct(Product p) {
        String sql = "UPDATE Product SET name=?, image=?, price=?, description=?, category_id=?, quantity=? WHERE id=?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getName());
            ps.setString(2, p.getImage());
            ps.setDouble(3, p.getPrice());
            ps.setString(4, p.getDescription());
            ps.setInt(5, p.getCategory_id());
            ps.setInt(6, p.getQuantity());
            ps.setInt(7, p.getId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

// 3. Hàm XÓA sản phẩm 
    public boolean deleteProduct(int id) {
        //Xóa hết các Size/Màu của sản phẩm đó trong bảng ProductVariant trước
        String sqlVariant = "DELETE FROM ProductVariant WHERE product_id = ?";
        //Xóa sản phẩm chính trong bảng Product
        String sqlProduct = "DELETE FROM Product WHERE id = ?";

        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement psV = conn.prepareStatement(sqlVariant); PreparedStatement psP = conn.prepareStatement(sqlProduct)) {

                psV.setInt(1, id);
                psV.executeUpdate();

                psP.setInt(1, id);
                int rows = psP.executeUpdate();

                conn.commit();
                return rows > 0; // Nếu cập nhật được
            } catch (Exception e) {
                conn.rollback(); // Lỗi 1 cái là trả lại hết
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();
        // Thử tìm các sản phẩm có giá từ 100k đến 400k
        List<Product> list = dao.getProductByPrice(100000, 400000);

        System.out.println("--- KẾT QUẢ LỌC THEO GIÁ ---");
        for (Product p : list) {
            System.out.println(p.getName() + " - " + p.getPrice() + " VNĐ");
        }
    }

}
