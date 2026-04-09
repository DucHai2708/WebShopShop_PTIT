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
    
    public static void main(String[] args) {
        CartDAO dao = new CartDAO();
        // Giả sử User ID = 1 thêm Variant ID = 15 với số lượng 2
        // Cậu chạy thử 2 lần sẽ thấy lần 1 nó báo "thêm mới", lần 2 báo "cộng dồn"
        dao.addToCart(1, 15, 2); 
    }
}
