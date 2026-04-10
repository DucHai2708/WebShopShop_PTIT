package com.shopshop.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.shopshop.dao.CartDAO;
import com.shopshop.model.CartItem;
import java.util.List;
import java.util.ArrayList;

//@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Lấy mảng ID từ các checkbox "selectedItems" được gửi lên
        String[] selectedIds = request.getParameterValues("selectedItems");
        
        // Nếu khách chưa chọn món nào mà bấm thanh toán -> Đuổi về giỏ hàng
        if (selectedIds == null || selectedIds.length == 0) { 
            response.sendRedirect("cart"); 
            return; 
        }

        CartDAO dao = new CartDAO();
        List<CartItem> checkoutList = new ArrayList<>();
        double subTotal = 0;

        // 2. Dùng try-catch bọc lại để phòng trường hợp bị lỗi ép kiểu (NumberFormatException)
        try {
            for (String id : selectedIds) {
                CartItem item = dao.getCartItemById(Integer.parseInt(id));
                if (item != null) {
                    checkoutList.add(item);
                    subTotal += (item.getPrice() * item.getQuantity());
                }
            }
        } catch (NumberFormatException e) {
            // Đề phòng ai đó sửa HTML, truyền chữ thay vì số ID
            e.printStackTrace();
            response.sendRedirect("cart");
            return;
        }

        // 3. Đẩy dữ liệu sang file checkout.jsp
        request.setAttribute("checkoutList", checkoutList);
        request.setAttribute("totalPrice", subTotal);
        request.setAttribute("shipFee", 20000); // Gắn mặc định 20k phí ship
        
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    // =====================================================================
    // 4. CHỐNG LỖI 405 (Method Not Allowed)
    // Nếu người dùng vô tình gõ trực tiếp url "localhost:8080/.../checkout" 
    // lên trình duyệt, nó sẽ vào doGet. Ta đuổi họ về lại trang cart.
    // =====================================================================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("cart");
    }
}