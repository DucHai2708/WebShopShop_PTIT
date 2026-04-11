package com.shopshop.controller;

import com.shopshop.dao.CartDAO;
import com.shopshop.model.CartItem;
import com.shopshop.model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AddToCartServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");

        // 1. Nếu chưa đăng nhập thì bắt đi đăng nhập
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int variantId = Integer.parseInt(request.getParameter("variantId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String productUrl = request.getHeader("Referer"); // URL để quay về trang sản phẩm khi lỗi

            CartDAO dao = new CartDAO();

            // === KIỂM TRA TỒN KHO NGAY KHI THÊM VÀO GIỎ ===
            int stockQty = dao.getStockQuantityByVariantId(variantId);
            // Tính tổng số lượng: đã có trong giỏ + số lượng muốn thêm
            CartItem existItem = dao.checkCartItemExist(user.getId(), variantId);
            int currentQtyInCart = (existItem != null) ? existItem.getQuantity() : 0;
            int totalAfterAdd = currentQtyInCart + quantity;

            if (totalAfterAdd > stockQty) {
                int canAdd = stockQty - currentQtyInCart;
                String msg = canAdd <= 0
                        ? "Sản phẩm này đã đạt giới hạn tồn kho (" + stockQty + " sản phẩm) trong giỏ hàng của bạn!"
                        : "Chỉ có thể thêm tối đa " + canAdd + " sản phẩm nữa (tồn kho: " + stockQty + ").";
                session.setAttribute("cartError", msg);
                response.sendRedirect(productUrl != null ? productUrl : "home");
                return;
            }

            // 2. Add vào database
            dao.addToCart(user.getId(), variantId, quantity);

            // 3. Đếm lại tổng số lượng và lưu vào SESSION
            int total = dao.getCartCount(user.getId());
            session.setAttribute("cartCount", total);
            session.removeAttribute("cartError"); // Xóa lỗi cũ nếu thêm thành công

            // 4. Kiểm tra xem khách bấm nút nào (Mua ngay hay Thêm giỏ)
            String buyNow = request.getParameter("buyNow");
            if ("true".equals(buyNow)) {
                // MUA NGAY: Lấy ID của món hàng vừa đưa vào giỏ để gửi đi thanh toán
                CartItem item = dao.checkCartItemExist(user.getId(), variantId);
                if (item != null) {
                    response.sendRedirect("checkout?selectedItems=" + item.getId());
                } else {
                    response.sendRedirect("cart");
                }
            } else {
                // THÊM VÀO GIỎ: Mặc định về trang cart
                response.sendRedirect("cart");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("home");
        }
    }

    // Thêm hàm doGet để bắt lỗi nếu request bị chuyển thành GET
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}