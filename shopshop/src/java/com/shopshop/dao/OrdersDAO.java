package com.shopshop.dao;

import com.shopshop.context.DBContext;
import com.shopshop.model.Orders;
import com.shopshop.model.OrderDetail;
import java.sql.*;
import java.util.*;

public class OrdersDAO extends DBContext {

    //Ham tao don hang moi va tra ve id cua don hang vua dat 
    public int insertOrder(Orders order) {
        String sql = "INSERT INTO Orders (user_id, totalPrice, shipName, shipAddress, shipPhone, status, note) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, order.getUser_id());
            ps.setDouble(2, order.getTotalPrice());
            ps.setString(3, order.getShipName());
            ps.setString(4, order.getShipAddress());
            ps.setString(5, order.getShipPhone());
            ps.setInt(6, order.getStatus());
            ps.setString(7, order.getNote());

            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    //Ham tao chi tiet don hang - lay cai id tu ham 1 de cho vao order_id
    public void insertOrderDetail(int order_id, int variant_id, int quantity, double price) {
        String sql = "INSERT INTO OrderDetail(order_id, variant_id, quantity, price) "
                + "VALUES(?,?,?,?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, order_id);
            ps.setInt(2, variant_id);
            ps.setInt(3, quantity);
            ps.setDouble(4, price);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //Ham cap nhat kho hang sau khi chot don thanh cong
    public void updateStock(int variant_id, int quantityBought) {
        String sql = "UPDATE ProductVariant SET stock_quantity = stock_quantity - ? WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantityBought);
            ps.setInt(2, variant_id);

            ps.executeUpdate();
//            System.out.println("Da cap nhat lai kho hang");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //Ham lay lich su mua hang dua tren user_id
    public List<Orders> getOrdersByUserId(int user_id) {
        List<Orders> list = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE user_id = ? ORDER BY orderDate DESC";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user_id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Orders(
                            rs.getInt("id"),
                            rs.getInt("user_id"),
                            rs.getDouble("totalPrice"),
                            rs.getString("shipName"),
                            rs.getString("shipAddress"),
                            rs.getString("shipPhone"),
                            rs.getTimestamp("orderDate"),
                            rs.getInt("status"),
                            rs.getString("note")
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

    //Ham huy don hang
    public void cancelOrder(int order_id) {
        String sqlUpdateOrder = "UPDATE Orders SET status = -1 WHERE id = ?";
        String sqlGetDetail = "SELECT variant_id, quantity FROM OrderDetail WHERE order_id = ?";
        try (Connection conn = getConnection();) {
            conn.setAutoCommit(false); // Tắt auto commit để tạm hủy đơn

            try (PreparedStatement psUpdateOrder = conn.prepareStatement(sqlUpdateOrder); PreparedStatement psGetDetail = conn.prepareStatement(sqlGetDetail)) {
                // step1: huy don
                psUpdateOrder.setInt(1, order_id);
                psUpdateOrder.executeUpdate();

                //step2: lay chi tiet don hang de tra kho
                psGetDetail.setInt(1, order_id);
                try (ResultSet rs = psGetDetail.executeQuery()) {
                    while (rs.next()) {
                        int variant_id = rs.getInt("variant_id");
                        int quantity = rs.getInt("quantity");
                        updateStock(variant_id, -quantity);
                    }
                }
                //commit
                conn.commit();
                System.out.println("Đã hủy đơn hàng " + order_id + " và hoàn trả kho thành công");

            } catch (Exception e) {
                //Nếu lỗi hủy thì rollback lại
                conn.rollback();
                e.printStackTrace();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //Ham cap nhat trang thai giao hang
    public void updateOrderStatus(int order_id, int newStatus) {
        String sql = "UPDATE Orders SET status = ? WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, newStatus);
            ps.setInt(2, order_id);

            ps.executeUpdate();
            System.out.println("Đã cập nhật trạng thái thành công");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //Ham hien thi don hang cua khach da dat
    public List<OrderDetail> getOrderDetailByOrderId(int order_id) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "SELECT od.*, p.name AS productName, pv.color, pv.size "
                + "FROM OrderDetail od "
                + "JOIN ProductVariant pv ON od.variant_id = pv.id "
                + "JOIN Product p ON pv.product_id = p.id "
                + "WHERE od.order_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, order_id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail detail = new OrderDetail(
                            rs.getInt("id"),
                            rs.getInt("order_id"),
                            rs.getInt("variant_id"),
                            rs.getInt("quantity"),
                            rs.getDouble("price")
                    );
                    //Setter cho các biến hiển thị vì nó k có trong database nên không dùng rs
                    detail.setProductName(rs.getString("productName"));
                    detail.setColor(rs.getString("color"));
                    detail.setSize(rs.getString("size"));
                    list.add(detail);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        OrdersDAO dao = new OrdersDAO();
        int userId = 1; // ID của Hải đã nạp trong SQL mẫu

        System.out.println("======= BẮT ĐẦU TEST TOÀN QUY TRÌNH SHOP SHOP =======");

        // BƯỚC 1: TẠO ĐƠN HÀNG MỚI (Lấy lại bước này để có dữ liệu test)
        Orders newOrder = new Orders();
        newOrder.setUser_id(userId);
        newOrder.setTotalPrice(650000.0);
        newOrder.setShipName("Nguyễn Đức Hải - Leader");
        newOrder.setShipAddress("Hà Nội");
        newOrder.setShipPhone("0912345678");
        newOrder.setStatus(0);
        newOrder.setNote("Giao gấp cho tớ nhé!");

        int idVuaTao = dao.insertOrder(newOrder);

        if (idVuaTao != -1) {
            System.out.println("✅ 1. Tạo đơn hàng thành công! ID mới là: " + idVuaTao);

            // BƯỚC 2: THÊM CHI TIẾT (Mua 1 áo len Đen L - Variant ID 1)
            dao.insertOrderDetail(idVuaTao, 1, 1, 650000.0);
            dao.updateStock(1, 1);
            System.out.println("✅ 2. Đã thêm món hàng và trừ kho.");

            // BƯỚC 3: XEM CHI TIẾT ĐƠN HÀNG (Test JOIN 3 bảng)
            System.out.println("\n--- THÔNG TIN CHI TIẾT ĐƠN " + idVuaTao + " ---");
            List<OrderDetail> details = dao.getOrderDetailByOrderId(idVuaTao);
            for (OrderDetail d : details) {
                System.out.println(" + Sản phẩm: " + d.getProductName() + " | Màu: " + d.getColor() + " | Size: " + d.getSize());
            }

            // BƯỚC 4: ADMIN DUYỆT ĐƠN (Chuyển sang trạng thái 1)
            System.out.println("\n--- ADMIN THỰC HIỆN DUYỆT ĐƠN ---");
            dao.updateOrderStatus(idVuaTao, 1);

            // BƯỚC 5: KHÁCH HÀNG HỦY ĐƠN (Hoàn kho)
            System.out.println("\n--- KHÁCH HÀNG BẤM HỦY ĐƠN ---");
            dao.cancelOrder(idVuaTao);

            // BƯỚC 6: KIỂM TRA LẠI LỊCH SỬ
            System.out.println("\n--- KIỂM TRA LỊCH SỬ MUA HÀNG CUỐI CÙNG ---");
            List<Orders> history = dao.getOrdersByUserId(userId);
            for (Orders o : history) {
                String tinhTrang = (o.getStatus() == -1) ? "Đã hủy" : "Đang xử lý";
                System.out.println("Mã đơn: " + o.getId() + " | Trạng thái: " + tinhTrang + " | Tổng tiền: " + o.getTotalPrice());
            }

        } else {
            System.out.println("❌ Thất bại ngay từ bước tạo đơn. Hải nhớ chạy file SQL nạp User/Product trước nhé!");
        }
    }
}
