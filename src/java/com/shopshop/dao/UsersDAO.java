package com.shopshop.dao;

import com.shopshop.context.DBContext;
import com.shopshop.model.Users;
import java.sql.*;

public class UsersDAO extends DBContext {

    public Users login(String user, String pass) {
        String sql = "SELECT * FROM Users WHERE username = ? AND password = ?";
        try (
                Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setString(1, user);
            ps.setString(2, pass);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Users(rs.getInt("id"), rs.getString("username"), rs.getString("password"), rs.getString("fullName"), rs.getString("email"), rs.getString("phone"), rs.getString("address"), rs.getInt("role"));
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    //Kiểm tra tên đăng nhập xem có tồn tại hay không?
    public boolean checkUserExist(String username) {
        String sql = "SELECT * FROM Users WHERE username = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                // Nếu rs.next() là true nghĩa là đã tìm thấy user trùng tên
                if (rs.next()) {
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkEmailExist(String email) {
        String sql = "SELECT * FROM Users WHERE email = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                // Nếu rs.next() là true nghĩa là đã tìm thấy user trùng tên
                if (rs.next()) {
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean checkPhoneExist(String phone) {
        String sql = "SELECT * FROM Users WHERE phone = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, phone);
            try (ResultSet rs = ps.executeQuery()) {
                // Nếu rs.next() là true nghĩa là đã tìm thấy user trùng tên
                if (rs.next()) {
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public void register(String username, String password, String fullName, String email, String phone, String address) {
        String sql = "INSERT INTO Users(username, password, fullName, email, phone, address) VALUES (?,?,?,?,?,?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, fullName);
            ps.setString(4, email);
            ps.setString(5, phone);
            ps.setString(6, address);

            ps.executeUpdate();
            System.out.println("Dang ky thanh cong tai khoan: " + username);

        } catch (Exception e) {
            System.out.println("Loi dang ky");
            e.printStackTrace();
        }
    }

    // Lấy toàn bộ danh sách user (dùng cho trang Admin)
    public java.util.List<Users> getAllUsers() {
        java.util.List<Users> list = new java.util.ArrayList<>();
        String sql = "SELECT * FROM Users ORDER BY id DESC";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Users(
                    rs.getInt("id"), rs.getString("username"), rs.getString("password"),
                    rs.getString("fullName"), rs.getString("email"),
                    rs.getString("phone"), rs.getString("address"), rs.getInt("role")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Xóa user theo ID (dùng cho trang Admin)
    // Trả về: 1 = xóa thành công, -1 = lỗi
    public int deleteUser(int id) {
        // CÁC CÂU LỆNH XÓA DÂY CHUYỀN (CASCADE DELETE)
        
        // 1. Xóa chi tiết đơn hàng (OrderDetail) - phải xóa trước vì nó tham chiếu đến Orders
        String sqlOrderDetail = "DELETE FROM OrderDetail WHERE order_id IN (SELECT id FROM Orders WHERE user_id = ?)";
        
        // 2. Xóa đơn hàng (Orders) - tham chiếu đến Users
        String sqlOrders = "DELETE FROM Orders WHERE user_id = ?";
        
        // 3. Xóa giỏ hàng (cartitem) - tham chiếu đến Users
        String sqlCart = "DELETE FROM cartitem WHERE user_id = ?";
        
        // 4. Xóa chính người dùng
        String sqlUser = "DELETE FROM Users WHERE id = ?";
        
        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false); // Bắt đầu Transaction
            
            try (PreparedStatement psOD = conn.prepareStatement(sqlOrderDetail);
                 PreparedStatement psO = conn.prepareStatement(sqlOrders);
                 PreparedStatement psC = conn.prepareStatement(sqlCart);
                 PreparedStatement psU = conn.prepareStatement(sqlUser)) {
                
                // Set ID cho tất cả các câu lệnh
                psOD.setInt(1, id);
                psO.setInt(1, id);
                psC.setInt(1, id);
                psU.setInt(1, id);
                
                // Thực thi theo đúng thứ tự ràng buộc khóa ngoại
                psOD.executeUpdate();
                psO.executeUpdate();
                psC.executeUpdate();
                int affectedRows = psU.executeUpdate();
                
                conn.commit(); // Thành công hết thì mới lưu xuống DB
                return affectedRows > 0 ? 1 : -1;
                
            } catch (Exception e) {
                conn.rollback(); // Nếu bất kỳ bước nào lỗi, khôi phục lại trạng thái ban đầu
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Lấy 1 user theo ID (dùng cho admin edit)
    public Users getUserById(int id) {
        String sql = "SELECT * FROM Users WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Users(rs.getInt("id"), rs.getString("username"), rs.getString("password"),
                        rs.getString("fullName"), rs.getString("email"),
                        rs.getString("phone"), rs.getString("address"), rs.getInt("role"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        UsersDAO dao = new UsersDAO();
        dao.register("haicake", "111", "N D Hai", "abc@gmail.com", "0912345678", "TP HCM");
        Users u = dao.login("haicake", "111");
        if (u != null) {
            System.out.println("Login thanh cong! xin chao: " + u.getFullName());
        } else {
            System.out.println("Sai tai khoan hoac mat khau");
        }
    }
}
