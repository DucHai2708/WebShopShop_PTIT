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
