<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    com.shopshop.model.Users adminUser = (com.shopshop.model.Users) session.getAttribute("user");
    if (adminUser == null || adminUser.getRole() != 1) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    int totalProducts = (int) request.getAttribute("totalProducts");
    int totalCategories = (int) request.getAttribute("totalCategories");
    int totalUsers = (int) request.getAttribute("totalUsers");
%>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Dashboard — Atino</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/admin.css">
</head>
<body>
<div class="admin-wrapper">

    <%-- SIDEBAR --%>
    <aside class="admin-sidebar">
        <div class="sidebar-logo">
            <img src="../assets/images/logo.jpg" alt="Logo">
            <div>
                <span>Atino</span><br>
                <span class="admin-badge">Admin</span>
            </div>
        </div>
        <nav>
            <a href="dashboard" class="active"><i class="fa-solid fa-chart-pie"></i> Tổng quan</a>
            <a href="products"><i class="fa-solid fa-shirt"></i> Sản phẩm</a>
            <a href="categories"><i class="fa-solid fa-tags"></i> Danh mục</a>
            <a href="users"><i class="fa-solid fa-users"></i> Người dùng</a>
        </nav>
        <div class="sidebar-footer">
            <a href="../home"><i class="fa-solid fa-store"></i> Xem trang web</a>
            <br><br>
            <a href="../logout"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
        </div>
    </aside>

    <%-- NỘI DUNG CHÍNH --%>
    <div class="admin-content">
        <div class="admin-topbar">
            <h1 class="page-title">Tổng quan</h1>
            <div class="topbar-user">
                <div class="avatar"><%= adminUser.getFullName().substring(0,1).toUpperCase() %></div>
                <span><%= adminUser.getFullName() %></span>
            </div>
        </div>

        <div class="admin-main">
            <%-- Stat Cards --%>
            <div class="stat-cards">
                <div class="stat-card products">
                    <div class="stat-icon"><i class="fa-solid fa-shirt"></i></div>
                    <div class="stat-info">
                        <div class="stat-number"><%= totalProducts %></div>
                        <div class="stat-label">Sản phẩm</div>
                    </div>
                </div>
                <div class="stat-card categories">
                    <div class="stat-icon"><i class="fa-solid fa-tags"></i></div>
                    <div class="stat-info">
                        <div class="stat-number"><%= totalCategories %></div>
                        <div class="stat-label">Danh mục</div>
                    </div>
                </div>
                <div class="stat-card users">
                    <div class="stat-icon"><i class="fa-solid fa-users"></i></div>
                    <div class="stat-info">
                        <div class="stat-number"><%= totalUsers %></div>
                        <div class="stat-label">Người dùng</div>
                    </div>
                </div>
            </div>

            <%-- Quick links --%>
            <div class="admin-card">
                <div class="card-header">
                    <h2>Truy cập nhanh</h2>
                </div>
                <div class="card-body" style="padding: 24px;">
                    <a href="products?action=add" class="btn-admin btn-admin-primary mr-3">
                        <i class="fa-solid fa-plus"></i> Thêm sản phẩm
                    </a>
                    <a href="categories?action=add" class="btn-admin btn-admin-primary mr-3">
                        <i class="fa-solid fa-plus"></i> Thêm danh mục
                    </a>
                    <a href="products" class="btn-admin btn-admin-secondary mr-3">
                        <i class="fa-solid fa-list"></i> Xem tất cả sản phẩm
                    </a>
                    <a href="users" class="btn-admin btn-admin-secondary">
                        <i class="fa-solid fa-users"></i> Quản lý người dùng
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
