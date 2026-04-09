package com.shopshop.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// Import đầy đủ các class cần thiết
import com.shopshop.dao.CategoryDAO;
import com.shopshop.dao.ProductDAO;
import com.shopshop.model.Category;
import com.shopshop.model.Product;
import java.util.*;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Lấy dữ liệu cho các menu danh mục
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> winter = categoryDAO.getChildCategories(1);
        List<Category> summer = categoryDAO.getChildCategories(2);
        List<Category> pant = categoryDAO.getChildCategories(3);
        List<Category> accessories = categoryDAO.getChildCategories(4);
        
        request.setAttribute("winter", winter);
        request.setAttribute("summer", summer);
        request.setAttribute("pant", pant);
        request.setAttribute("accessories", accessories);

        // 2. Lấy dữ liệu sản phẩm hiển thị trên trang chủ (Ví dụ: Lấy đồ Thu Đông id = 1)
        ProductDAO productDAO = new ProductDAO();
        List<Product> productList = productDAO.getProductByCategoryId(1);
        
        // Đóng gói danh sách sản phẩm gửi sang JSP
        request.setAttribute("productList", productList);

        // 3. Chuyển hướng sang giao diện
        request.getRequestDispatcher("home.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}