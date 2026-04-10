package com.shopshop.controller;

import com.shopshop.dao.CartDAO;
import com.shopshop.dao.ProductDAO;
import com.shopshop.model.ProductVariant;
import com.shopshop.model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AddToCartServlet", urlPatterns = {"/add-to-cart"})
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Kiểm tra xem người dùng đã đăng nhập chưa
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        
        if (user == null) {
            // Chưa đăng nhập thì bắt quay về trang đăng nhập
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Lấy thông tin từ giao diện (product.jsp) gửi lên
        String productIdRaw = request.getParameter("productId");
        String color = request.getParameter("color");
        String size = request.getParameter("size");
        String quantityRaw = request.getParameter("quantity");

        try {
            int productId = Integer.parseInt(productIdRaw);
            int quantity = Integer.parseInt(quantityRaw);

            // 3. Dùng hàm team bạn vừa viết để chốt xem khách lấy Biến thể nào
            ProductDAO productDAO = new ProductDAO();
            ProductVariant variant = productDAO.getVariantByColorAndSize(productId, color, size);

            if (variant != null) {
                // 4. Nếu có hàng -> Ném vào Giỏ hàng
                CartDAO cartDAO = new CartDAO();
                cartDAO.addToCart(user.getId(), variant.getId(), quantity);

                // 5. Quay lại trang sản phẩm và báo thành công trên URL (?success=1)
                response.sendRedirect("product?id=" + productId + "&success=1");
            } else {
                // Trường hợp khách cố tình chọn tổ hợp màu/size không tồn tại
                response.sendRedirect("product?id=" + productId + "&error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("home");
        }
    }
}