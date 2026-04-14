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

@WebServlet(name = "SearchServlet", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");

        if (keyword != null) {
            String[] sizes = request.getParameterValues("size");
            String[] colors = request.getParameterValues("color");
            String[] prices = request.getParameterValues("price");

            ProductDAO pDao = new ProductDAO();
            List<Product> listProducts;
            if (sizes == null && colors == null && prices == null) {
                listProducts = pDao.searchByName(keyword);
            } else {
                listProducts = pDao.searchByNameWithFilter(keyword, prices, sizes, colors);
            }
            
            request.setAttribute("productList", listProducts);
            request.setAttribute("keyword", keyword);
            request.setAttribute("sizes", sizes);
            request.setAttribute("colors", colors);
            request.setAttribute("priceRanges", prices);
            
            // GỬI DỮ LIỆU CHO MENU
            com.shopshop.dao.CategoryDAO categoryDAOMenu = new com.shopshop.dao.CategoryDAO();
            request.setAttribute("winter", categoryDAOMenu.getChildCategories(1));
            request.setAttribute("summer", categoryDAOMenu.getChildCategories(2));
            request.setAttribute("pant", categoryDAOMenu.getChildCategories(3));
            request.setAttribute("accessories", categoryDAOMenu.getChildCategories(4));

            request.getRequestDispatcher("search.jsp").forward(request, response);
        } else {
            response.sendRedirect("home");
        }
    }
}