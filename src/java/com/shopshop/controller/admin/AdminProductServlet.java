package com.shopshop.controller.admin;

import com.shopshop.dao.CategoryDAO;
import com.shopshop.dao.ProductDAO;
import com.shopshop.model.Category;
import com.shopshop.model.Product;
import com.shopshop.model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminProductServlet", urlPatterns = {"/admin/products"})
public class AdminProductServlet extends HttpServlet {

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

        String action = request.getParameter("action");
        if (action == null) action = "list";

        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        switch (action) {
            case "add":
                // Hiển thị form thêm sản phẩm
                List<Category> categories = categoryDAO.getAll();
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("/admin-product-form.jsp").forward(request, response);
                break;

            case "edit":
                // Hiển thị form sửa sản phẩm
                int editId = Integer.parseInt(request.getParameter("id"));
                Product editProduct = productDAO.getProductById(editId);
                List<Category> catsForEdit = categoryDAO.getAll();
                request.setAttribute("product", editProduct);
                request.setAttribute("categories", catsForEdit);
                request.setAttribute("editMode", true);
                request.getRequestDispatcher("/admin-product-form.jsp").forward(request, response);
                break;

            default: // list
                List<Product> products = productDAO.getAll();
                request.setAttribute("products", products);
                request.getRequestDispatcher("/admin-products.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) return;
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        ProductDAO productDAO = new ProductDAO();

        switch (action) {
            case "add": {
                String name = request.getParameter("name");
                String image = request.getParameter("image");
                double price = Double.parseDouble(request.getParameter("price"));
                String description = request.getParameter("description");
                int categoryId = Integer.parseInt(request.getParameter("category_id"));
                // quantity ban đầu = 0, sẽ tự cập nhật sau khi lưu biến thể
                Product p = new Product(0, name, image, price, description, categoryId, 0);

                int newProductId = productDAO.insertProduct(p);
                if (newProductId > 0) {
                    String[] sizes = request.getParameterValues("sizes");
                    String[] colors = request.getParameterValues("colors");
                    String[] stockQtys = request.getParameterValues("stockQtys"); // số lượng kho từng biến thể
                    if (sizes != null && colors != null) {
                        int idx = 0;
                        for (String size : sizes) {
                            for (String color : colors) {
                                int variantStock = (stockQtys != null && idx < stockQtys.length)
                                        ? Integer.parseInt(stockQtys[idx++]) : 0;
                                com.shopshop.model.ProductVariant pv = new com.shopshop.model.ProductVariant(
                                        0, newProductId, color, size, variantStock);
                                productDAO.insertVariant(pv);
                            }
                        }
                    }
                    // Đồng bộ lại quantity của Product = Tổng biến thể
                    productDAO.syncProductQuantity(newProductId);
                }
                response.sendRedirect(request.getContextPath() + "/admin/products?success=add");
                break;
            }
            case "edit": {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String image = request.getParameter("image");
                double price = Double.parseDouble(request.getParameter("price"));
                String description = request.getParameter("description");
                int categoryId = Integer.parseInt(request.getParameter("category_id"));
                // quantity sẽ được tự đồng bộ, không cần lấy từ form
                Product p = new Product(id, name, image, price, description, categoryId, 0);

                if (productDAO.updateProduct(p)) {
                    productDAO.deleteVariantsByProductId(id);
                    String[] sizes = request.getParameterValues("sizes");
                    String[] colors = request.getParameterValues("colors");
                    String[] stockQtys = request.getParameterValues("stockQtys");
                    if (sizes != null && colors != null) {
                        int idx = 0;
                        for (String size : sizes) {
                            for (String color : colors) {
                                int variantStock = (stockQtys != null && idx < stockQtys.length)
                                        ? Integer.parseInt(stockQtys[idx++]) : 0;
                                com.shopshop.model.ProductVariant pv = new com.shopshop.model.ProductVariant(
                                        0, id, color, size, variantStock);
                                productDAO.insertVariant(pv);
                            }
                        }
                    }
                    // Đồng bộ lại quantity của Product = Tổng biến thể
                    productDAO.syncProductQuantity(id);
                }
                response.sendRedirect(request.getContextPath() + "/admin/products?success=edit");
                break;
            }
            case "delete": {
                int id = Integer.parseInt(request.getParameter("id"));
                productDAO.deleteProduct(id);
                response.sendRedirect(request.getContextPath() + "/admin/products?success=delete");
                break;
            }
            default:
                response.sendRedirect(request.getContextPath() + "/admin/products");
        }
    }
}
