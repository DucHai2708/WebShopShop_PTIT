package com.shopshop.controller;

import com.shopshop.dao.ProductDAO;
import com.shopshop.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CategoryServlet", urlPatterns = { "/category" })
public class CategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cid_raw = request.getParameter("id");
        int cid = 1; // Mặc định là danh mục 1 (Áo Thu Đông) nếu không có tham số
        try {
            if (cid_raw != null && !cid_raw.isEmpty()) {
                cid = Integer.parseInt(cid_raw);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        ProductDAO productDao = new ProductDAO();
        List<Product> list = productDao.getProductByCategoryId(cid);

        // Fix: get category info
        com.shopshop.dao.CategoryDAO categoryDao = new com.shopshop.dao.CategoryDAO();
        com.shopshop.model.Category category = categoryDao.getCategoryById(cid);

        request.setAttribute("productList", list);
        request.setAttribute("categoryId", cid);
        request.setAttribute("category", category);

        // Forward (Chuyển tiếp) request sang category.jsp để hiển thị
        request.getRequestDispatcher("category.jsp").forward(request, response);
    }
}
