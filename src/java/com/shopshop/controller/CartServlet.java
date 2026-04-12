package com.shopshop.controller;

import com.shopshop.dao.CartDAO;
import com.shopshop.model.CartItem;
import com.shopshop.model.Users;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        Users user = (Users) request.getSession().getAttribute("user");
        if (user == null) { 
            response.sendRedirect("login.jsp"); 
            return; 
        }
        
        CartDAO dao = new CartDAO();
        String action = request.getParameter("action");

        // Xử lý Xóa hoặc Cập nhật số lượng
        if (action != null) {
            String cartItemIdStr = request.getParameter("id");
            if (cartItemIdStr != null) {
                int cartItemId = Integer.parseInt(cartItemIdStr);
                if (action.equals("delete")) {
                    // Cậu cần thêm hàm deleteCartItem vào CartDAO
                    dao.deleteCartItem(cartItemId);
                } else if (action.equals("update")) {
                    int quantity = Integer.parseInt(request.getParameter("qty"));
                    // Cậu cần thêm hàm updateQuantity vào CartDAO
                    dao.updateQuantity(cartItemId, quantity);
                }
            }
            // Sau khi xử lý xong, load lại trang giỏ hàng
            response.sendRedirect("cart");
            return;
        }

        // Lấy danh sách để hiển thị
        List<CartItem> list = dao.getCartByUserId(user.getId());
        request.setAttribute("cartList", list);
        request.getRequestDispatcher("cart.jsp").forward(request, response);
        // (Bắt buộc) Gửi dữ liệu cho thanh Menu Động
        com.shopshop.dao.CategoryDAO categoryDAOMenu = new com.shopshop.dao.CategoryDAO();
        request.setAttribute("winter", categoryDAOMenu.getChildCategories(1));
        request.setAttribute("summer", categoryDAOMenu.getChildCategories(2));
        request.setAttribute("pant", categoryDAOMenu.getChildCategories(3));
        request.setAttribute("accessories", categoryDAOMenu.getChildCategories(4));

        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }
}