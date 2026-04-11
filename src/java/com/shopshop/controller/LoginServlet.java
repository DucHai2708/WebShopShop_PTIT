package com.shopshop.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.shopshop.dao.UsersDAO;
import com.shopshop.model.Users;
import java.util.Map;

@WebServlet(name = "LoginServlet", urlPatterns = { "/login" })
public class LoginServlet extends HttpServlet {

    // GET: Hiển thị trang đăng nhập
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
        
    }
    
    // POST: Xử lý đăng nhập
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String username = request.getParameter("username");
   //     System.out.println(username);
        String password = request.getParameter("password");
   //     System.out.println(password);    
        
//        StringBuilder url = new StringBuilder(request.getRequestURL());
//
//        Map<String,String[]> params = request.getParameterMap();
//
//        if(!params.isEmpty())
//        {
//            url.append("?");
//
//            params.forEach((k,v)->
//                url.append(k)
//                   .append("=")
//                   .append(v[0])
//                   .append("&")
//            );
//
//            url.deleteCharAt(url.length()-1);
//        }
//
//        System.out.println(url.toString());
//        
        
        UsersDAO dao = new UsersDAO();
        Users user = dao.login(username, password);

        if (user != null) {
            // Đăng nhập thành công → Lưu user vào Session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Chuyển hướng theo role
            if (user.getRole() == 1) {
                response.sendRedirect("admin/dashboard");
            } else {
                response.sendRedirect("home");
            }
        } else {
            // Đăng nhập thất bại → Quay lại login.jsp kèm thông báo lỗi
            request.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
