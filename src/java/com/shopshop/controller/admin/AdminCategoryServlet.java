package com.shopshop.controller.admin;

import com.shopshop.dao.CategoryDAO;
import com.shopshop.model.Category;
import com.shopshop.model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminCategoryServlet", urlPatterns = {"/admin/categories"})
public class AdminCategoryServlet extends HttpServlet {

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

        CategoryDAO categoryDAO = new CategoryDAO();

        switch (action) {
            case "add":
                // Chuyển đến form thêm — lấy danh sách danh mục gốc để chọn parent
                List<Category> tmp = categoryDAO.getAll();
                List<Category> parents = tmp.subList(0, 4);
                request.setAttribute("categories", parents);
                request.getRequestDispatcher("/admin-category-form.jsp").forward(request, response);
                break;

            case "edit":
                int editId = Integer.parseInt(request.getParameter("id"));
                Category editCat = categoryDAO.getCategoryById(editId);
                List<Category> temp = categoryDAO.getAll();
                List<Category> allCats = temp.subList(0, 4);
                request.setAttribute("category", editCat);
                request.setAttribute("categories", allCats);
                request.setAttribute("editMode", true);
                request.getRequestDispatcher("/admin-category-form.jsp").forward(request, response);
                break;

            default: // list
                List<Category> list = categoryDAO.getAllForAdmin();
                request.setAttribute("categoryList", list);
                request.getRequestDispatcher("/admin-categories.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) return;
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        // 
        String sql_add    = "INSERT INTO Category (name, description, status, parent_id) VALUES (?,?,?,?)";
        String sql_edit   = "UPDATE Category SET name=?, description=?, status=?, parent_id=? WHERE id=?";
        String sql_delete = "DELETE FROM Category WHERE id=?";

        try (java.sql.Connection conn = new com.shopshop.context.DBContext().getConnection()) {
            switch (action) {
                case "add": {
                    String name = request.getParameter("name");
                    String desc = request.getParameter("description");
                    int status = Integer.parseInt(request.getParameter("status"));
                    String parentRaw = request.getParameter("parent_id");
                    Integer parentId = (parentRaw == null || parentRaw.isEmpty()) ? null : Integer.parseInt(parentRaw);
                    java.sql.PreparedStatement ps = conn.prepareStatement(sql_add);
                    ps.setString(1, name);
                    ps.setString(2, desc);
                    ps.setInt(3, status);
                    if (parentId == null) ps.setNull(4, java.sql.Types.INTEGER);
                    else ps.setInt(4, parentId);
                    ps.executeUpdate();
                    break;
                }
                case "edit": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    String name = request.getParameter("name");
                    String desc = request.getParameter("description");
                    int status = Integer.parseInt(request.getParameter("status"));
                    String parentRaw = request.getParameter("parent_id");
                    Integer parentId = (parentRaw == null || parentRaw.isEmpty()) ? null : Integer.parseInt(parentRaw);
                    java.sql.PreparedStatement ps = conn.prepareStatement(sql_edit);
                    ps.setString(1, name);
                    ps.setString(2, desc);
                    ps.setInt(3, status);
                    if (parentId == null) ps.setNull(4, java.sql.Types.INTEGER);
                    else ps.setInt(4, parentId);
                    ps.setInt(5, id);
                    ps.executeUpdate();
                    break;
                }
                case "delete": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    java.sql.PreparedStatement ps = conn.prepareStatement(sql_delete);
                    ps.setInt(1, id);
                    ps.executeUpdate();
                    break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin/categories?success=" + action);
    }
}
