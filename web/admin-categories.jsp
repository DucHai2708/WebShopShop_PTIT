<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.shopshop.model.Category"%>
<%@page import="java.util.List"%>
<%
    com.shopshop.model.Users adminUser = (com.shopshop.model.Users) session.getAttribute("user");
    if (adminUser == null || adminUser.getRole() != 1) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    List<Category> categoryList = (List<Category>) request.getAttribute("categoryList");
    String success = request.getParameter("success");
%>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý Danh mục — Atino Admin</title>
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
            <a href="categories" class="active"><i class="fa-solid fa-tags"></i> Danh mục</a>
            <a href="users"><i class="fa-solid fa-users"></i> Người dùng</a>
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
            <h1 class="page-title">Quản lý Danh mục</h1>
            <div class="topbar-user">
                <div class="avatar"><%= adminUser.getFullName().substring(0,1).toUpperCase() %></div>
                <span><%= adminUser.getFullName() %></span>
            </div>
        </div>

        <div class="admin-main">
            <% if (success != null) { %>
            <div class="admin-alert admin-alert-success">
                <i class="fa-solid fa-circle-check"></i>
                <% if ("add".equals(success)) { %>Thêm danh mục thành công!
                <% } else if ("edit".equals(success)) { %>Cập nhật danh mục thành công!
                <% } else if ("delete".equals(success)) { %>Xóa danh mục thành công!
                <% } %>
            </div>
            <% } %>

            <div class="admin-card">
                <div class="card-header">
                    <h2><i class="fa-solid fa-tags mr-2"></i>Danh sách danh mục (<%= categoryList != null ? categoryList.size() : 0 %>)</h2>
                    <a href="categories?action=add" class="btn-admin btn-admin-primary">
                        <i class="fa-solid fa-plus"></i> Thêm danh mục
                    </a>
                </div>
                <div class="card-body">
                    <% if (categoryList == null || categoryList.isEmpty()) { %>
                    <div class="empty-state">
                        <i class="fa-solid fa-folder-open"></i>
                        <p>Chưa có danh mục nào.</p>
                    </div>
                    <% } else { %>
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên danh mục</th>
                                <th>Mô tả</th>
                                <th>Trạng thái</th>
                                <th>Parent ID</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Category c : categoryList) { %>
                            <tr>
                                <td>#<%= c.getId() %></td>
                                <td style="font-weight:600;"><%= c.getName() %></td>
                                <td style="color:#888; max-width:200px;">
                                    <%= c.getDescription() != null ? c.getDescription() : "—" %>
                                </td>
                                <td>
                                    <% if (c.getStatus() == 1) { %>
                                    <span class="badge-role badge-active">Hiển thị</span>
                                    <% } else { %>
                                    <span class="badge-role badge-inactive">Ẩn</span>
                                    <% } %>
                                </td>
                                <td><%= c.getParent_id() == 0 ? "—" : "#" + c.getParent_id() %></td>
                                <td>
                                    <a href="categories?action=edit&id=<%= c.getId() %>" class="btn-admin btn-admin-edit mr-1">
                                        <i class="fa-solid fa-pen"></i> Sửa
                                    </a>
                                    <form method="POST" action="categories" style="display:inline;"
                                          onsubmit="return confirm('Xóa danh mục này? Cảnh báo: sản phẩm thuộc danh mục này sẽ mất liên kết!')">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="<%= c.getId() %>">
                                        <button type="submit" class="btn-admin btn-admin-delete">
                                            <i class="fa-solid fa-trash"></i> Xóa
                                        </button>
                                    </form>
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
