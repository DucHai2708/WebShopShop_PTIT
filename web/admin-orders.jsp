<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="com.shopshop.model.Users"%>
<%@page import="com.shopshop.model.Orders"%>
<%@page import="java.util.List"%>
<%
    Users adminUser = (Users) session.getAttribute("user");
    if (adminUser == null || adminUser.getRole() != 1) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    List<Orders> orderList = (List<Orders>) request.getAttribute("orderList");
    String success = request.getParameter("success");
%>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý Đơn hàng — Atino Admin</title>
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
            <a href="users"><i class="fa-solid fa-users"></i> Người dùng</a>
            <a href="orders" class="active"><i class="fa-solid fa-cart-shopping"></i> Đơn hàng</a>
        </nav>
        <div class="sidebar-footer">
            <a href="../home"><i class="fa-solid fa-store"></i> Xem trang web</a>
            <br><br>
            <a href="../logout"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
        </div>
    </aside>

    <div class="admin-content">
        <div class="admin-topbar">
            <h1 class="page-title">Quản lý Đơn hàng</h1>
            <div class="topbar-user">
                <div class="avatar"><%= adminUser.getFullName().substring(0,1).toUpperCase() %></div>
                <span><%= adminUser.getFullName() %></span>
            </div>
        </div>

        <div class="admin-main">
            <% if ("update".equals(success)) { %>
            <div class="admin-alert admin-alert-success">
                <i class="fa-solid fa-circle-check"></i> Cập nhật trạng thái thành công!
            </div>
            <% } %>

            <div class="admin-card">
                <div class="card-header">
                    <h2><i class="fa-solid fa-list-check mr-2"></i>Danh sách đơn hàng (<%= orderList != null ? orderList.size() : 0 %>)</h2>
                </div>
                <div class="card-body">
                    <% if (orderList == null || orderList.isEmpty()) { %>
                    <div class="empty-state">
                        <i class="fa-solid fa-box-open"></i>
                        <p>Chưa có đơn hàng nào.</p>
                    </div>
                    <% } else { %>
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>Mã đơn</th>
                                <th>Khách hàng</th>
                                <th>Ngày đặt</th>
                                <th>Tổng tiền</th>
                                <th>Trạng thái hiện tại</th>
                                <th>Cập nhật trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${orderList}" var="o">
                            <tr>
                                <td class="font-weight-bold">#${o.id}</td>
                                <td>
                                    <div class="small"><b>${o.userFullName}</b></div>
                                    <div class="text-muted small">${o.shipPhone}</div>
                                </td>
                                <td class="small text-muted">
                                    <fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </td>
                                <td class="text-danger font-weight-bold">
                                    <fmt:formatNumber value="${o.totalPrice}" pattern="#,###"/>đ
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${o.status == 0}"><span class="badge badge-warning">Chờ duyệt</span></c:when>
                                        <c:when test="${o.status == 1}"><span class="badge badge-info">Xác nhận</span></c:when>
                                        <c:when test="${o.status == 2}"><span class="badge badge-primary">Đang giao</span></c:when>
                                        <c:when test="${o.status == 3}"><span class="badge badge-success">Thành công</span></c:when>
                                        <c:when test="${o.status == -1}"><span class="badge badge-secondary">Đã hủy</span></c:when>
                                    </c:choose>
                                </td>
                                <td>
                                    <form method="POST" action="orders" class="form-inline">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="orderId" value="${o.id}">
                                        <select name="status" class="form-control form-control-sm mr-2" style="font-size: 12px; height: 32px;">
                                            <option value="0" ${o.status == 0 ? 'selected' : ''}>Chờ duyệt</option>
                                            <option value="1" ${o.status == 1 ? 'selected' : ''}>Xác nhận</option>
                                            <option value="2" ${o.status == 2 ? 'selected' : ''}>Đang giao</option>
                                            <option value="3" ${o.status == 3 ? 'selected' : ''}>Thành công</option>
                                            <option value="-1" ${o.status == -1 ? 'selected' : ''}>Đã hủy</option>
                                        </select>
                                        <button type="submit" class="btn-admin btn-admin-primary px-3 py-1" style="font-size: 12px;">Lưu</button>
                                    </form>
                                </td>
                            </tr>
                            </c:forEach>
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
