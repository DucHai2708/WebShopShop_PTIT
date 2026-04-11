package com.shopshop.dao;

import com.shopshop.context.DBContext;
import com.shopshop.model.CartItem;
import java.sql.*;
import java.util.*;

public class CartDAO extends DBContext {

    //1. Hàm kiểm tra xem 1 biển thể (variant_id) đã có trong giỏ hàng của user chưa
    public CartItem checkCartItemExist(int userId, int variantId) {
        String sql = "SELECT * FROM CartItem WHERE user_id = ? AND variant_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, variantId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new CartItem(
                            rs.getInt("id"),
                            rs.getInt("user_id"),
                            rs.getInt("variant_id"),
                            rs.getInt("quantity")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //2. Hàm thêm vào giỏ hàng (xử lý chèn mới hoặc cộng dồn)
    public void addToCart(int userId, int variantId, int quantity) {
        // Gọi hàm số 1 để kiểm tra trước
        CartItem existItem = checkCartItemExist(userId, variantId);

        if (existItem != null) {
            // Trường hợp 1: Đã có sẵn -> UPDATE cộng dồn số lượng
            String sqlUpdate = "UPDATE CartItem SET quantity = quantity + ? WHERE id = ?";
            try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sqlUpdate)) {

                ps.setInt(1, quantity);
                ps.setInt(2, existItem.getId()); // Cập nhật đúng dòng id đó
                ps.executeUpdate();
                System.out.println("-> Đã cộng dồn thêm " + quantity + " sản phẩm vào giỏ hàng.");

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            // Trường hợp 2: Chưa có -> INSERT mới hoàn toàn
            String sqlInsert = "INSERT INTO CartItem (user_id, variant_id, quantity) VALUES (?, ?, ?)";
            try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sqlInsert)) {

                ps.setInt(1, userId);
                ps.setInt(2, variantId);
                ps.setInt(3, quantity);
                ps.executeUpdate();
                System.out.println("-> Đã thêm sản phẩm mới vào giỏ hàng.");

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    //Hàm lấy ra các món hàng được chọn cho việc thanh toán
    public List<CartItem> getSelectedCartItems(String[] cartItemIds) {
        List<CartItem> list = new ArrayList<>();
        if (cartItemIds == null || cartItemIds.length == 0) {
            return list;
        }

        // Mẹo tạo chuỗi "?, ?, ?" tương ứng với số lượng ID khách chọn
        String placeholders = String.join(",", Collections.nCopies(cartItemIds.length, "?"));

        // Câu lệnh JOIN 3 bảng
        String sql = "SELECT c.id, c.user_id, c.variant_id, c.quantity, "
                + "p.name, v.color, v.size, p.price, p.image "
                + "FROM CartItem c "
                + "JOIN ProductVariant v ON c.variant_id = v.id "
                + "JOIN Product p ON v.product_id = p.id "
                + "WHERE c.id IN (" + placeholders + ")";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            // Gán giá trị cho từng dấu hỏi chấm
            for (int i = 0; i < cartItemIds.length; i++) {
                ps.setInt(i + 1, Integer.parseInt(cartItemIds[i]));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem(
                            rs.getInt("id"), rs.getInt("user_id"),
                            rs.getInt("variant_id"), rs.getInt("quantity")
                    );
                    // Gán thêm các thông tin phụ để mang lên giao diện
                    item.setProductName(rs.getString("name"));
                    item.setColor(rs.getString("color"));
                    item.setSize(rs.getString("size"));
                    item.setPrice(rs.getDouble("price"));
                    item.setImage(rs.getString("image"));

                    list.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Hàm lấy toàn bộ sản phẩm trong giỏ hàng của 1 User để hiển thị
    public List<CartItem> getCartByUserId(int userId) {
        List<CartItem> list = new ArrayList<>();
        // JOIN 3 bảng để lấy đầy đủ Tên, Ảnh, Giá, Màu, Size
        String sql = "SELECT c.id, c.user_id, c.variant_id, c.quantity, "
                + "p.name, p.image, v.color, v.size, p.price "
                + "FROM CartItem c "
                + "JOIN ProductVariant v ON c.variant_id = v.id "
                + "JOIN Product p ON v.product_id = p.id "
                + "WHERE c.user_id = ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem(
                            rs.getInt("id"), rs.getInt("user_id"),
                            rs.getInt("variant_id"), rs.getInt("quantity")
                    );
                    item.setProductName(rs.getString("name"));
                    item.setImage(rs.getString("image"));
                    item.setColor(rs.getString("color"));
                    item.setSize(rs.getString("size"));
                    item.setPrice(rs.getDouble("price"));

                    list.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //Hàm xóa các món đã mua ra khỏi Giỏ hàng
    public void removeCartItems(String[] cartItemIds) {
        if (cartItemIds == null || cartItemIds.length == 0) {
            return;
        }

        String placeholders = String.join(",", Collections.nCopies(cartItemIds.length, "?"));
        String sql = "DELETE FROM CartItem WHERE id IN (" + placeholders + ")";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            for (int i = 0; i < cartItemIds.length; i++) {
                ps.setInt(i + 1, Integer.parseInt(cartItemIds[i]));
            }
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //Xóa một sản phẩm cụ thể khỏi giỏ hàng
    public void deleteCartItem(int cartItemId) {
        String sql = "DELETE FROM cartitem WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cartItemId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //Cập nhật số lượng (+ / -)
    public void updateQuantity(int cartItemId, int quantity) {
        // Nếu giảm số lượng về 0 hoặc âm thì xóa luôn sản phẩm đó
        if (quantity <= 0) {
            deleteCartItem(cartItemId);
            return;
        }
        String sql = "UPDATE cartitem SET quantity = ? WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, cartItemId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Hàm Lấy thông tin chính xác từ ID được tích chọn
    public CartItem getCartItemById(int cartItemId) {
        String sql = "SELECT c.id, c.user_id, c.variant_id, c.quantity, "
                + "p.name, v.color, v.size, p.price, p.image "
                + "FROM cartitem c "
                + "JOIN productvariant v ON c.variant_id = v.id "
                + "JOIN product p ON v.product_id = p.id "
                + "WHERE c.id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cartItemId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    CartItem item = new CartItem(
                            rs.getInt("id"), rs.getInt("user_id"),
                            rs.getInt("variant_id"), rs.getInt("quantity")
                    );
                    item.setProductName(rs.getString("name"));
                    item.setColor(rs.getString("color"));
                    item.setSize(rs.getString("size"));
                    item.setPrice(rs.getDouble("price"));
                    item.setImage(rs.getString("image"));
                    return item;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //Hàm đếm tổng số lượng sản phẩm trong giỏ của User
    public int getCartCount(int userId) {
        String sql = "SELECT SUM(quantity) FROM cartitem WHERE user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static void main(String[] args) {

    }
}
