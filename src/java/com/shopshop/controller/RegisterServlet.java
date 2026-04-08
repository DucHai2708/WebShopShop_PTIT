package com.shopshop.controller;

import com.shopshop.dao.UsersDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    // GET: Hiển thị trang đăng ký (chuyển về login.jsp tab register)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    // POST: Xử lý dữ liệu form đăng ký
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String phone    = request.getParameter("phone");
        String email    = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // --- 1. Validate: Kiểm tra các trường bắt buộc ---
        if (fullName == null || fullName.trim().isEmpty() ||
            username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {

            request.setAttribute("registerError", "Vui lòng điền đầy đủ thông tin bắt buộc.");
            request.setAttribute("showRegister", true);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // --- 2. Validate: Kiểm tra mật khẩu khớp ---
        if (!password.equals(confirmPassword)) {
            request.setAttribute("registerError", "Mật khẩu xác nhận không khớp.");
            request.setAttribute("showRegister", true);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // --- 3. Validate: Kiểm tra username đã tồn tại chưa ---
        UsersDAO dao = new UsersDAO();
        if (dao.checkUserExist(username.trim())) {
            request.setAttribute("registerError", "Tên đăng nhập \"" + username + "\" đã tồn tại. Vui lòng chọn tên khác.");
            request.setAttribute("showRegister", true);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // --- 4. Tất cả hợp lệ: Thực hiện đăng ký ---
        dao.register(
            username.trim(),
            password,
            fullName.trim(),
            email != null ? email.trim() : "",
            phone != null ? phone.trim() : "",
            "" // address để trống, user cập nhật sau
        );

        // --- 5. Đăng ký thành công: Chuyển về trang đăng nhập với thông báo ---
        response.sendRedirect("login?registerSuccess=true");
    }
}
