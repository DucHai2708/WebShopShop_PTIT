<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.shopshop.model.Category"%>
<%@page import="java.util.List"%>
<%
    com.shopshop.model.Users adminUser = (com.shopshop.model.Users) session.getAttribute("user");
    if (adminUser == null || adminUser.getRole() != 1) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    Category category = (Category) request.getAttribute("category");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    boolean editMode = Boolean.TRUE.equals(request.getAttribute("editMode"));
%>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><%= editMode ? "Sửa" : "Thêm" %> Danh mục — Atino Admin</title>
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
        </nav>
        <div class="sidebar-footer">
            <a href="../home"><i class="fa-solid fa-store"></i> Xem trang web</a>
            <br><br>
            <a href="../logout"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
        </div>
    </aside>

    <div class="admin-content">
        <div class="admin-topbar">
            <h1 class="page-title"><%= editMode ? "Sửa danh mục" : "Thêm danh mục mới" %></h1>
            <div class="topbar-user">
                <div class="avatar"><%= adminUser.getFullName().substring(0,1).toUpperCase() %></div>
                <span><%= adminUser.getFullName() %></span>
            </div>
        </div>

        <div class="admin-main">
            <div class="admin-form-card">
                <form method="POST" action="categories">
                    <input type="hidden" name="action" value="<%= editMode ? "edit" : "add" %>">
                    <% if (editMode) { %>
                    <input type="hidden" name="id" value="<%= category.getId() %>">
                    <% } %>

                    <div class="form-group">
                        <label>Tên danh mục <span style="color:#e74c3c">*</span></label>
                        <input type="text" name="name" class="form-control" required
                               value="<%= editMode ? category.getName() : "" %>"
                               placeholder="Vd: Áo Thun/Áo Nỉ">
                    </div>

                    <div class="form-group">
                        <label>Mô tả</label>
                        <textarea name="description" class="form-control" rows="3"
                                  placeholder="Mô tả danh mục..."><%= editMode && category.getDescription() != null ? category.getDescription() : "" %></textarea>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Trạng thái <span style="color:#e74c3c">*</span></label>
                                <select name="status" class="form-control">
                                    <option value="1" <%= (editMode && category.getStatus() == 1) ? "selected" : "" %>>
                                        Hiển thị trên menu
                                    </option>
                                    <option value="0" <%= (editMode && category.getStatus() == 0) ? "selected" : "" %>>
                                        Ẩn khỏi menu
                                    </option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Danh mục cha (nếu có)</label>
                                <select name="parent_id" class="form-control">
                                    <option value="">-- Không có (danh mục gốc) --</option>
                                    <% if (categories != null) { for (Category c : categories) {
                                        if (!editMode || c.getId() != category.getId()) { %>
                                    <option value="<%= c.getId() %>"
                                        <%= (editMode && category.getParent_id() == c.getId()) ? "selected" : "" %>>
                                        <%= c.getName() %>
                                    </option>
                                    <% } } } %>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div style="display:flex; gap:12px; margin-top:8px;">
                        <button type="submit" class="btn-admin btn-admin-primary">
                            <i class="fa-solid fa-<%= editMode ? "floppy-disk" : "plus" %>"></i>
                            <%= editMode ? "Lưu thay đổi" : "Thêm danh mục" %>
                        </button>
                        <a href="categories" class="btn-admin btn-admin-secondary">
                            <i class="fa-solid fa-xmark"></i> Hủy
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
