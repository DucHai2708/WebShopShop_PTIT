package com.shopshop.dao;

import com.shopshop.context.DBContext;
import com.shopshop.model.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

public class CategoryDAO extends DBContext {

    // Hàm lấy tất cả các danh mục đang hoạt động
    public List<Category> getAll() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM Category WHERE status = 1";
        try (
                Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                list.add(new Category(rs.getInt("id"), rs.getString("name"), rs.getString("description"),
                        rs.getInt("status"), rs.getInt("parent_id")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Hàm lấy TẤT CẢ danh mục kể cả ẩn — dùng cho trang Admin
    public List<Category> getAllForAdmin() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM Category ORDER BY id ASC";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Category(rs.getInt("id"), rs.getString("name"), rs.getString("description"),
                        rs.getInt("status"), rs.getInt("parent_id")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Hàm lấy các danh mục GỐC (parent_id IS NULL hoặc = 0) — dùng cho header nav
    public List<Category> getRootCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM Category WHERE (parent_id IS NULL OR parent_id = 0) AND status = 1";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Category(rs.getInt("id"), rs.getString("name"), rs.getString("description"),
                        rs.getInt("status"), rs.getInt("parent_id")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Hàm hiển thị các danh mục con của danh mục cha đã chọn
    public List<Category> getChildCategories(int parentId) {
        List<Category> list = new ArrayList<>();
        // Câu lệnh SQL: Lấy các danh mục có parent_id khớp và đang ở trạng thái hoạt
        // động (status = 1)
        String sql = "SELECT * FROM Category WHERE parent_id = ? AND status = 1";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, parentId); // Truyền ID của danh mục cha vào

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Ánh xạ dữ liệu từ Database sang đối tượng Java Category
                    list.add(new Category(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("description"),
                            rs.getInt("status"),
                            rs.getInt("parent_id")));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Hàm lấy chi tiết 1 Danh mục theo ID
    public Category getCategoryById(int id) {
        String sql = "SELECT * FROM Category WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Category(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("description"),
                            rs.getInt("status"),
                            rs.getInt("parent_id"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        CategoryDAO dao = new CategoryDAO();

        // Giả sử ID 1 là "Đồ Nam" hoặc "Áo thu đông" mà cậu đã nạp trong DB
        int parentIdTest = 4;

        System.out.println("--- ĐANG TEST LẤY DANH MỤC CON THEO PARENT_ID ---");
        System.out.println("Đang tìm các danh mục con của ID: " + parentIdTest);

        List<Category> children = dao.getChildCategories(parentIdTest);

        if (children.isEmpty()) {
            System.out.println("=> Kết quả: Trống rỗng!");
            System.out.println("Hải check lại trong Database xem cột parent_id của các mục con");
            System.out.println("đã điền số " + parentIdTest + " chưa, và status có bằng 1 không nhé.");
        } else {
            System.out.println("=> Tìm thấy " + children.size() + " danh mục con:");
            for (Category c : children) {
                System.out.println("+ ID: " + c.getId());
                System.out.println("  - Tên danh mục: " + c.getName());
                System.out.println("  - Parent ID: " + c.getParent_id());
                System.out.println("----------------------------");
            }
            System.out.println("TEST NGON LÀNH! Giờ Hải có thể dùng danh sách này làm Menu đổ xuống rồi.");
        }
    }
}
