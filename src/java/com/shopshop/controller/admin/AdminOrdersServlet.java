package com.shopshop.controller.admin;

import com.shopshop.dao.OrdersDAO;
import com.shopshop.model.Orders;
import com.shopshop.model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminOrdersServlet", urlPatterns = {"/admin/orders"})
public class AdminOrdersServlet extends HttpServlet {

    private boolean isAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Users user = (Users) request.getSession().getAttribute("user");
        if (user == null || user.getRole() != 1) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        return true;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) return;

        OrdersDAO ordersDAO = new OrdersDAO();
        List<Orders> orderList = ordersDAO.getAllOrders();
        request.setAttribute("orderList", orderList);
        request.getRequestDispatcher("/admin-orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) return;

        String action = request.getParameter("action");
        OrdersDAO ordersDAO = new OrdersDAO();

        if ("updateStatus".equals(action)) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            int newStatus = Integer.parseInt(request.getParameter("status"));
            
            ordersDAO.updateOrderStatus(orderId, newStatus);
            response.sendRedirect(request.getContextPath() + "/admin/orders?success=update");
            return;
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
}
