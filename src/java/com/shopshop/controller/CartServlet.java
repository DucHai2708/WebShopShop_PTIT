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
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Kiểm tra đăng nhập
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        CartDAO cartDAO = new CartDAO();
        String action = request.getParameter("action");
        if (action != null) {
            String cartItemIdStr = request.getParameter("id");
            if (cartItemIdStr != null) {
                int cartItemId = Integer.parseInt(cartItemIdStr);
                if (action.equals("delete")) {
                    cartDAO.deleteCartItem(cartItemId);
                } else if (action.equals("update")) {
                    String qtyStr = request.getParameter("qty");
                    if(qtyStr != null) {
                        int quantity = Integer.parseInt(qtyStr);
                        cartDAO.updateQuantity(cartItemId, quantity);
                    }
                }
            }
            // Xử lý xong thì redirect lại trang giỏ hàng để tránh lỗi F5 gửi lại form
            response.sendRedirect("cart");
            return;
        }

        // 2. Lấy danh sách Giỏ hàng của người dùng này
        
        List<CartItem> cartItems = cartDAO.getCartByUserId(user.getId());
        
        // 3. Tính Tổng tiền tạm tính
        double totalMoney = 0;
        for (CartItem item : cartItems) {
            totalMoney += item.getPrice() * item.getQuantity();
        }

        // 4. Gửi dữ liệu sang JSP
        request.setAttribute("cartList", cartItems);
        request.setAttribute("totalMoney", totalMoney);
        
        // (Bắt buộc) Gửi dữ liệu cho thanh Menu Động
        com.shopshop.dao.CategoryDAO categoryDAOMenu = new com.shopshop.dao.CategoryDAO();
        request.setAttribute("winter", categoryDAOMenu.getChildCategories(1));
        request.setAttribute("summer", categoryDAOMenu.getChildCategories(2));
        request.setAttribute("pant", categoryDAOMenu.getChildCategories(3));
        request.setAttribute("accessories", categoryDAOMenu.getChildCategories(4));

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