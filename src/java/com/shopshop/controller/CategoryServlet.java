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
        int cid = 1; // Mặc định là danh mục 1 nếu không có tham số
        try {
            if (cid_raw != null && !cid_raw.isEmpty()) {
                cid = Integer.parseInt(cid_raw);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        // Đọc các tham số lọc giá, kích cỡ, màu sắc
        String[] priceRanges = request.getParameterValues("price");
        String[] sizes = request.getParameterValues("size");
        String[] colors = request.getParameterValues("color");

        ProductDAO productDao = new ProductDAO();
        List<Product> list;

        // Nếu có filter → dùng method lọc tổng hợp, ngược lại lấy hết
        if ((priceRanges != null && priceRanges.length > 0) || 
            (sizes != null && sizes.length > 0) || 
            (colors != null && colors.length > 0)) {
            list = productDao.getProductByCategoryIdWithFilter(cid, priceRanges, sizes, colors);
        } else {
            list = productDao.getProductByCategoryId(cid);
        }

        // Lấy thông tin category
        com.shopshop.dao.CategoryDAO categoryDao = new com.shopshop.dao.CategoryDAO();
        com.shopshop.model.Category category = categoryDao.getCategoryById(cid);

        request.setAttribute("productList", list);
        request.setAttribute("categoryId", cid);
        request.setAttribute("category", category);
        request.setAttribute("priceRanges", priceRanges); // Truyền lại để giữ trạng thái
        request.setAttribute("sizes", sizes);
        request.setAttribute("colors", colors);

        // Forward sang category.jsp để hiển thị
        request.getRequestDispatcher("category.jsp").forward(request, response);
    }
}
