
package com.shopshop.controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.shopshop.dao.CategoryDAO;
import com.shopshop.model.Category;
import java.util.*;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> winter = categoryDAO.getChildCategories(1);
        List<Category> summer = categoryDAO.getChildCategories(2);
        List<Category> pant = categoryDAO.getChildCategories(3);
        List<Category> accessories = categoryDAO.getChildCategories(4);
        request.setAttribute("winter", winter);
        request.setAttribute("summer", summer);
        request.setAttribute("pant", pant);
        request.setAttribute("accessories", accessories);
        request.getRequestDispatcher("home.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
