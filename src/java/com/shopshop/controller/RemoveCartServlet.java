package com.shopshop.controller;

import com.shopshop.dao.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RemoveCartServlet", urlPatterns = {"/remove-cart"})
public class RemoveCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy ID của CartItem (món hàng trong giỏ) mà khách muốn xóa
        String cartItemId = request.getParameter("id");

        if (cartItemId != null && !cartItemId.isEmpty()) {
            CartDAO cartDAO = new CartDAO();
            // Hàm của nhóm bạn yêu cầu truyền vào 1 mảng String
            String[] idsToRemove = { cartItemId }; 
            cartDAO.removeCartItems(idsToRemove);
        }

        // Xóa xong thì tự động load lại trang Giỏ hàng để cập nhật số tiền
        response.sendRedirect("cart");
    }
}