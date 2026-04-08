package com.shopshop.controller;

import com.shopshop.dao.ProductDAO;
import com.shopshop.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");

        if (keyword != null) {
            ProductDAO pDao = new ProductDAO();
            List<Product> listProducts = pDao.searchByName(keyword);
            
            request.setAttribute("productList", listProducts);
            request.setAttribute("keyword", keyword);
            
            request.getRequestDispatcher("search.jsp").forward(request, response);
        } else {
            response.sendRedirect("home");
        }
    }
}
