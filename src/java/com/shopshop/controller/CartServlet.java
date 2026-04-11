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
import com.shopshop.dao.OrdersDAO;
import com.shopshop.model.Orders;
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
            String idStr = request.getParameter("id");
            if (idStr != null) {
                int id = Integer.parseInt(idStr);
                if (action.equals("delete")) {
                    cartDAO.deleteCartItem(id);
                } else if (action.equals("cancelOrder")) {
                    OrdersDAO ordersDAO = new OrdersDAO();
                    ordersDAO.cancelOrder(id);
                } else if (action.equals("update")) {
                    String qtyStr = request.getParameter("qty");
                    if (qtyStr != null) {
                        int quantity = Integer.parseInt(qtyStr);
                        boolean updated = cartDAO.updateQuantity(id, quantity);
                        if (!updated) {
                            int stock = cartDAO.getStockQuantityByVariantId(
                                    cartDAO.getCartItemById(id).getVariant_id());
                            session.setAttribute("cartError",
                                    "Số lượng vượt quá tồn kho! Sản phẩm này chỉ còn " + stock + " cái.");
                        } else {
                            session.removeAttribute("cartError");
                        }
                    }
                }
            }
            // Gán lại cartCount vào session
            session.setAttribute("cartCount", cartDAO.getCartCount(user.getId()));
            
            // Nếu là hành động hủy đơn, redirect về tab order
            if ("cancelOrder".equals(action)) {
                response.sendRedirect("cart?tab=order");
            } else {
                response.sendRedirect("cart");
            }
            return;
        }

        // 2. Lấy danh sách Giỏ hàng của người dùng này
        
        List<CartItem> cartItems = cartDAO.getCartByUserId(user.getId());
        
        // 3. Tính Tổng tiền tạm tính
        double totalMoney = 0;
        for (CartItem item : cartItems) {
            totalMoney += item.getPrice() * item.getQuantity();
            item.setColor(item.getColor().toUpperCase());
            item.setSize(item.getSize().toUpperCase());
        }

        // 4. Lấy danh sách Đơn hàng của người dùng
        OrdersDAO ordersDAO = new OrdersDAO();
        List<Orders> orderList = ordersDAO.getOrdersByUserId(user.getId());

        // 5. Gửi dữ liệu sang JSP
        request.setAttribute("cartList", cartItems);
        request.setAttribute("totalMoney", totalMoney);
        request.setAttribute("orderList", orderList);
        
        // (Bắt buộc) Gửi dữ liệu cho thanh Menu Động
        com.shopshop.dao.CategoryDAO categoryDAOMenu = new com.shopshop.dao.CategoryDAO();
        request.setAttribute("winter", categoryDAOMenu.getChildCategories(1));
        request.setAttribute("summer", categoryDAOMenu.getChildCategories(2));
        request.setAttribute("pant", categoryDAOMenu.getChildCategories(3));
        request.setAttribute("accessories", categoryDAOMenu.getChildCategories(4));

        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }
}