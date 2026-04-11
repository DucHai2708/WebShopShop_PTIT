package com.shopshop.controller.admin;

import com.shopshop.dao.UsersDAO;
import com.shopshop.model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminUsersServlet", urlPatterns = {"/admin/users"})
public class AdminUsersServlet extends HttpServlet {

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

        UsersDAO usersDAO = new UsersDAO();
        List<Users> userList = usersDAO.getAllUsers();
        request.setAttribute("userList", userList);
        request.getRequestDispatcher("/admin-users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) return;

        String action = request.getParameter("action");
        UsersDAO usersDAO = new UsersDAO();

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            // Không cho phép admin xóa chính mình
            Users currentAdmin = (Users) request.getSession().getAttribute("user");
            if (currentAdmin.getId() != id) {
                usersDAO.deleteUser(id);
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/users?success=delete");
    }
}
