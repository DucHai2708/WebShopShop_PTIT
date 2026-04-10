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
            
            CartDAO dao = new CartDAO();
            // 2. Add vào database
            dao.addToCart(user.getId(), variantId, quantity);
            
            // 3. Đếm lại tổng số lượng và lưu vào SESSION
            int total = dao.getCartCount(user.getId());
            session.setAttribute("cartCount", total);

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