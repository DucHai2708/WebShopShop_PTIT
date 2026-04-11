<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.shopshop.model.Users"%>
<%@page import="java.util.List"%>
<%
    Users adminUser = (Users) session.getAttribute("user");
    if (adminUser == null || adminUser.getRole() != 1) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    List<Users> userList = (List<Users>) request.getAttribute("userList");
    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý Người dùng — Atino Admin</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/admin.css">
</head>
<body>
<div class="admin-wrapper">
    <aside class="admin-sidebar">
        <div class="sidebar-logo">
            <img src="../assets/images/logo.jpg" alt="Logo">
            <div><span>Atino</span><br><span class="admin-badge">Admin</span></div>
        </div>
        <nav>
            <a href="dashboard"><i class="fa-solid fa-chart-pie"></i> Tổng quan</a>
            <a href="products"><i class="fa-solid fa-shirt"></i> Sản phẩm</a>
            <a href="categories"><i class="fa-solid fa-tags"></i> Danh mục</a>
            <a href="users" class="active"><i class="fa-solid fa-users"></i> Người dùng</a>
            <a href="orders"><i class="fa-solid fa-cart-shopping"></i> Đơn hàng</a>
        </nav>
        <div class="sidebar-footer">
            <a href="../home"><i class="fa-solid fa-store"></i> Xem trang web</a>
            <br><br>
            <a href="../logout"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
        </div>
    </aside>

    <div class="admin-content">
        <div class="admin-topbar">
            <h1 class="page-title">Quản lý Người dùng</h1>
            <div class="topbar-user">
                <div class="avatar"><%= adminUser.getFullName().substring(0,1).toUpperCase() %></div>
                <span><%= adminUser.getFullName() %></span>
            </div>
        </div>

        <div class="admin-main">
            <% if ("delete".equals(success)) { %>
            <div class="admin-alert admin-alert-success">
                <i class="fa-solid fa-circle-check"></i> Xóa tài khoản thành công!
            </div>
            <% } else if ("self".equals(error)) { %>
            <div class="admin-alert admin-alert-warning" style="background:#fff3cd; color:#856404; border-left:4px solid #ffc107;">
                <i class="fa-solid fa-triangle-exclamation"></i>
                Không thể xóa tài khoản của chính bạn!
            </div>
            <% } else if ("unknown".equals(error)) { %>
            <div class="admin-alert admin-alert-warning" style="background:#f8d7da; color:#721c24; border-left:4px solid #f5c6cb;">
                <i class="fa-solid fa-circle-xmark"></i>
                Xóa tài khoản thất bại! Vui lòng thử lại.
            </div>
            <% } %>

            <div class="admin-card">
                <div class="card-header">
                    <h2><i class="fa-solid fa-users mr-2"></i>Danh sách người dùng (<%= userList != null ? userList.size() : 0 %>)</h2>
                </div>
                <div class="card-body">
                    <% if (userList == null || userList.isEmpty()) { %>
                    <div class="empty-state">
                        <i class="fa-solid fa-users"></i>
                        <p>Chưa có người dùng nào.</p>
                    </div>
                    <% } else { %>
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Username</th>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>Số điện thoại</th>
                                <th>Role</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Users u : userList) { %>
                            <tr>
                                <td>#<%= u.getId() %></td>
                                <td style="font-weight:600;">
                                    <div style="display:flex; align-items:center; gap:8px;">
                                        <div style="width:30px; height:30px; border-radius:50%; background:linear-gradient(135deg,#667eea,#764ba2);
                                                    color:#fff; display:flex; align-items:center; justify-content:center;
                                                    font-size:12px; font-weight:700; flex-shrink:0;">
                                            <%= u.getFullName() != null && !u.getFullName().isEmpty()
                                                ? u.getFullName().substring(0,1).toUpperCase() : "?" %>
                                        </div>
                                        <%= u.getUsername() %>
                                    </div>
                                </td>
                                <td><%= u.getFullName() != null ? u.getFullName() : "—" %></td>
                                <td style="color:#888;"><%= u.getEmail() != null ? u.getEmail() : "—" %></td>
                                <td style="color:#888;"><%= u.getPhone() != null ? u.getPhone() : "—" %></td>
                                <td>
                                    <% if (u.getRole() == 1) { %>
                                    <span class="badge-role badge-admin">Admin</span>
                                    <% } else { %>
                                    <span class="badge-role badge-user">User</span>
                                    <% } %>
                                </td>
                                <td>
                                    <% if (u.getId() != adminUser.getId()) { %>
                                    <form method="POST" action="users" style="display:inline;"
                                          onsubmit="return confirm('Bạn có chắc muốn xóa tài khoản @<%= u.getUsername() %>?')">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="<%= u.getId() %>">
                                        <button type="submit" class="btn-admin btn-admin-delete">
                                            <i class="fa-solid fa-trash"></i> Xóa
                                        </button>
                                    </form>
                                    <% } else { %>
                                    <span style="font-size:12px; color:#aaa; font-style:italic;">Tài khoản của bạn</span>
                                    <% } %>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
