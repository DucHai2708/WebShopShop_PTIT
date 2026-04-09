<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.shopshop.model.Product"%>
<%@page import="java.util.List"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%
    com.shopshop.model.Users adminUser = (com.shopshop.model.Users) session.getAttribute("user");
    if (adminUser == null || adminUser.getRole() != 1) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    List<Product> products = (List<Product>) request.getAttribute("products");
    NumberFormat nf = NumberFormat.getNumberInstance(new Locale("vi", "VN"));
    String success = request.getParameter("success");
%>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý Sản phẩm — Atino Admin</title>
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
            <div><span>Atino</span><br><span class="admin-badge">Admin</span></div>
        </div>
        <nav>
            <a href="dashboard"><i class="fa-solid fa-chart-pie"></i> Tổng quan</a>
            <a href="products" class="active"><i class="fa-solid fa-shirt"></i> Sản phẩm</a>
            <a href="categories"><i class="fa-solid fa-tags"></i> Danh mục</a>
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
            <h1 class="page-title">Quản lý Sản phẩm</h1>
            <div class="topbar-user">
                <div class="avatar"><%= adminUser.getFullName().substring(0,1).toUpperCase() %></div>
                <span><%= adminUser.getFullName() %></span>
            </div>
        </div>

        <div class="admin-main">
            <% if ("add".equals(success)) { %>
            <div class="admin-alert admin-alert-success"><i class="fa-solid fa-circle-check"></i> Thêm sản phẩm thành công!</div>
            <% } else if ("edit".equals(success)) { %>
            <div class="admin-alert admin-alert-success"><i class="fa-solid fa-circle-check"></i> Cập nhật sản phẩm thành công!</div>
            <% } else if ("delete".equals(success)) { %>
            <div class="admin-alert admin-alert-success"><i class="fa-solid fa-circle-check"></i> Xóa sản phẩm thành công!</div>
            <% } %>

            <div class="admin-card">
                <div class="card-header">
                    <h2><i class="fa-solid fa-shirt mr-2"></i>Danh sách sản phẩm (<%= products != null ? products.size() : 0 %>)</h2>
                    <a href="products?action=add" class="btn-admin btn-admin-primary">
                        <i class="fa-solid fa-plus"></i> Thêm sản phẩm
                    </a>
                </div>
                <div class="card-body">
                    <% if (products == null || products.isEmpty()) { %>
                    <div class="empty-state">
                        <i class="fa-solid fa-box-open"></i>
                        <p>Chưa có sản phẩm nào.</p>
                    </div>
                    <% } else { %>
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Ảnh</th>
                                <th>Tên sản phẩm</th>
                                <th>Giá</th>
                                <th>SL</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Product p : products) { %>
                            <tr>
                                <td>#<%= p.getId() %></td>
                                <td>
                                    <img src="../<%= p.getImage() %>" alt="<%= p.getName() %>" class="product-img-thumb"
                                         onerror="this.src='../assets/images/product1.jpeg'">
                                </td>
                                <td style="font-weight:600; max-width:220px;"><%= p.getName() %></td>
                                <td style="color:#e74c3c; font-weight:700;"><%= nf.format((long)p.getPrice()) %>₫</td>
                                <td><%= p.getQuantity() %></td>
                                <td>
                                    <a href="products?action=edit&id=<%= p.getId() %>" class="btn-admin btn-admin-edit mr-1">
                                        <i class="fa-solid fa-pen"></i> Sửa
                                    </a>
                                    <form method="POST" action="products" style="display:inline;"
                                          onsubmit="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="<%= p.getId() %>">
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
