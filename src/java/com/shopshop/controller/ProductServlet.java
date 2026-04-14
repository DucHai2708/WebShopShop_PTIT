package com.shopshop.controller;

import com.shopshop.dao.ProductDAO;
import com.shopshop.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ProductServlet", urlPatterns = { "/product" })
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        // Nếu không có id thì redirect về trang chủ
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("home");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            ProductDAO dao = new ProductDAO();
            Product product = dao.getProductById(id);

            // Nếu không tìm thấy sản phẩm thì redirect về trang chủ
            if (product == null) {
                response.sendRedirect("home");
                return;
            }

            // Đẩy sản phẩm vào request
            request.setAttribute("product", product);

            // Gửi dữ liệu cho thanh Menu
            com.shopshop.dao.CategoryDAO categoryDAOMenu = new com.shopshop.dao.CategoryDAO();
            request.setAttribute("winter", categoryDAOMenu.getChildCategories(1));
            request.setAttribute("summer", categoryDAOMenu.getChildCategories(2));
            request.setAttribute("pant", categoryDAOMenu.getChildCategories(3));
            request.setAttribute("accessories", categoryDAOMenu.getChildCategories(4));

            // Forward sang product.jsp
            request.getRequestDispatcher("product.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            // id không phải số hợp lệ
            response.sendRedirect("home");
        }
    }
}