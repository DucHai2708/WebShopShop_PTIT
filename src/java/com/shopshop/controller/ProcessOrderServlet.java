package com.shopshop.controller;

import com.shopshop.dao.CartDAO;
import com.shopshop.dao.OrdersDAO;
import com.shopshop.model.CartItem;
import com.shopshop.model.Orders;
import com.shopshop.model.Users;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class ProcessOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");

        // 1. Check đăng nhập
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        // 2. Lấy thông tin khách điền trên form checkout.jsp
        String name = request.getParameter("customerName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String note = request.getParameter("note");
        String[] cartItemIds = request.getParameterValues("cartItemIds");

        // Nếu không có sản phẩm nào thì bắt quay lại giỏ hàng
        if (cartItemIds == null || cartItemIds.length == 0) {
            response.sendRedirect("cart");
            return;
        }

        CartDAO cartDAO = new CartDAO();
        OrdersDAO ordersDAO = new OrdersDAO();
        List<CartItem> itemsToBuy = new ArrayList<>();
        double totalItemPrice = 0;

        try {
            // 3. Tính toán tổng tiền trước khi tạo Order
            for (String idStr : cartItemIds) {
                try {
                    int cartId = Integer.parseInt(idStr);
                    CartItem item = cartDAO.getCartItemById(cartId);
                    if (item != null) {
                        itemsToBuy.add(item);
                        totalItemPrice += (item.getPrice() * item.getQuantity());
                    }
                } catch (NumberFormatException ex) {
                    System.out.println("Lỗi ID giỏ hàng không hợp lệ: " + idStr);
                }
            }

            // Nếu danh sách mua hàng rỗng (do lỗi ID) thì quay về
            if (itemsToBuy.isEmpty()) {
                response.sendRedirect("cart");
                return;
            }

            // ===== KIỂM TRA TỒN KHO TRƯỚC KHI ĐẶT ĐƠN =====
            for (CartItem item : itemsToBuy) {
                // Lấy số lượng tồn kho thực tế từ DB
                int stockQty = cartDAO.getStockQuantityByVariantId(item.getVariant_id());
                if (item.getQuantity() > stockQty) {
                    // Thiếu hàng: trả về trang checkout với thông báo lỗi
                    String errorMsg = "Sản phẩm \"" + item.getProductName()
                            + "\" (" + item.getColor() + " - " + item.getSize() + ")"
                            + " chỉ còn " + stockQty + " sản phẩm trong kho. Vui lòng giảm số lượng.";
                    request.setAttribute("errorMessage", errorMsg);
                    // Load lại dữ liệu cần thiết cho trang checkout
                    String[] selectedIds = request.getParameterValues("cartItemIds");
                    request.setAttribute("checkoutList", cartDAO.getSelectedCartItems(selectedIds));
                    com.shopshop.dao.CategoryDAO catDAO = new com.shopshop.dao.CategoryDAO();
                    request.setAttribute("winter", catDAO.getChildCategories(1));
                    request.setAttribute("summer", catDAO.getChildCategories(2));
                    request.setAttribute("pant", catDAO.getChildCategories(3));
                    request.setAttribute("accessories", catDAO.getChildCategories(4));
                    request.getRequestDispatcher("checkout.jsp").forward(request, response);
                    return;
                }
            }

            // 4. TẠO ORDER 
            Orders order = new Orders();
            // Lưu ý: Cậu kiểm tra trong class Orders, nếu hàm setter là setUserId thì đổi lại cho đúng nhé
            order.setUser_id(user.getId()); 
            order.setTotalPrice(totalItemPrice + 20000); // Tiền hàng + Phí ship 20k
            order.setShipName(name);
            order.setShipAddress(address);
            order.setShipPhone(phone);
            order.setStatus(0); // 0: Chờ xử lý
            order.setNote(note);

            int orderId = ordersDAO.insertOrder(order);

            if (orderId > 0) {
                // 5. LƯU CHI TIẾT, TRỪ KHO VÀ XÓA GIỎ HÀNG
                for (CartItem item : itemsToBuy) {
                    ordersDAO.insertOrderDetail(orderId, item.getVariant_id(), item.getQuantity(), item.getPrice());
                    ordersDAO.updateStock(item.getVariant_id(), item.getQuantity());
                    cartDAO.deleteCartItem(item.getId()); // Xóa món hàng khỏi giỏ
                }

                // 6. Cập nhật lại số lượng trên Icon Giỏ Hàng ở Header
                session.setAttribute("cartCount", cartDAO.getCartCount(user.getId()));

                // 7. Truyền dữ liệu sang trang order-success.jsp để hiển thị
                request.setAttribute("orderId", orderId);
                request.setAttribute("shipName", name);
                request.setAttribute("shipPhone", phone);
                request.setAttribute("shipAddress", address);
                
                // (Bắt buộc) Gửi dữ liệu cho thanh Menu Động
                com.shopshop.dao.CategoryDAO categoryDAOMenu = new com.shopshop.dao.CategoryDAO();
                request.setAttribute("winter", categoryDAOMenu.getChildCategories(1));
                request.setAttribute("summer", categoryDAOMenu.getChildCategories(2));
                request.setAttribute("pant", categoryDAOMenu.getChildCategories(3));
                request.setAttribute("accessories", categoryDAOMenu.getChildCategories(4));

                request.getRequestDispatcher("order-success.jsp").forward(request, response);
            } else {
                response.sendRedirect("cart");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("cart");
        }
    }

    // Bắt lỗi nếu khách vô tình dùng phương thức GET (gõ thẳng URL)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("cart");
    }
}