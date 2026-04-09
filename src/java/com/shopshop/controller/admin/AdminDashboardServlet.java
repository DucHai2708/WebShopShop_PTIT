package com.shopshop.controller.admin;

import com.shopshop.dao.CategoryDAO;
import com.shopshop.dao.ProductDAO;
import com.shopshop.dao.UsersDAO;
import com.shopshop.model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Users user = (Users) request.getSession().getAttribute("user");
        if (user == null || user.getRole() != 1) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Thống kê tổng quan
        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        UsersDAO usersDAO = new UsersDAO();

        int totalProducts = productDAO.getAll().size();
        int totalCategories = categoryDAO.getAll().size();
        int totalUsers = usersDAO.getAllUsers().size();

        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalCategories", totalCategories);
        request.setAttribute("totalUsers", totalUsers);

        request.getRequestDispatcher("/admin-dashboard.jsp").forward(request, response);
    }
}
