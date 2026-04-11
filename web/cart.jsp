<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="com.shopshop.model.Category" %>
<%@page import="java.util.List" %>

<!doctype html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <title>Giỏ hàng - Atino</title>
        <link rel="stylesheet" href="./assets/css/style.css">
        <link rel="stylesheet" href="./assets/css/base.css">
        <link rel="stylesheet" href="./assets/css/reset.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;700&display=swap" rel="stylesheet">
    </head>

    <body>
        <div class="section-one">
            <div class="container-fluid">
                <div class="inner-wrap">
                    <div class="phone-wrap">
                        <i class="fa-solid fa-phone phone-icon"></i>
                        <p class="phone-number">096728.4444</p>
                    </div>
                    <div class="account-wrap">
                        <% com.shopshop.model.Users user = (com.shopshop.model.Users) session.getAttribute("user"); %>
                        <% if (user != null) {%>
                        <div class="account">
                            <i class="fa-solid fa-person account-icon"></i>
                            <p class="account-text"><%= user.getFullName()%></p>
                        </div>
                        <div class="logout" style="margin-right: 20px;">
                            <a href="logout" style="text-decoration: none; color: #5a5a5a;">
                                <p class="account-text" style="margin: 0;">Đăng xuất</p>
                            </a>
                        </div>
                        <% } else { %>
                        <div class="account">
                            <i class="fa-solid fa-person account-icon"></i>
                            <a href="login" class="account-link"><p class="account-text">Tài khoản</p></a>
                        </div>
                        <% } %>
                        <a href="cart" style="text-decoration: none; color: inherit;">
                            <div class="cart">
                                <i class="fa-solid fa-cart-arrow-down cart-icon"></i>
                                <p class="cart-text">Giỏ hàng(${sessionScope.cartCount != null ? sessionScope.cartCount : 0})</p>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <header class="header">
            <div class="container-fluid">
                <div class="row">
                    <div class="header-wrap">
                        <div class="col-xl-2">
                            <div class="logo-wrap">
                                <a href="home">
                                    <img src="./assets/images/logo.jpg" alt="" class="header-logo">
                                </a>
                            </div>
                        </div>
                        <div class="col-xl-7">
                            <div class="nav-wrap">
                                <div class="header-nav">
                                    <a href="home" class="header-item">Trang chủ</a>
                                    <div class="nav-item-has-dropdown">
                                        <a href="category?id=1" class="header-item">Áo Thu Đông</a>
                                        <div class="nav-dropdown">
                                            <%
                                                List<Category> listWinter = (List<Category>) request.getAttribute("winter");
                                                if (listWinter != null) {
                                                    for (Category c : listWinter) {
                                            %>
                                            <a href="category?id=<%= c.getId()%>"><%= c.getName()%></a>
                                            <%      }
                                                }
                                            %>
                                        </div>
                                    </div>

                                    <div class="nav-item-has-dropdown">
                                        <a href="category?id=2" class="header-item">Áo xuân hè</a>
                                        <div class="nav-dropdown">
                                            <%
                                                List<Category> listSummer = (List<Category>) request.getAttribute("summer");
                                                if (listSummer != null) {
                                                    for (Category c : listSummer) {
                                            %>
                                            <a href="category?id=<%= c.getId()%>"><%= c.getName()%></a>
                                            <%      }
                                                }
                                            %>
                                        </div>
                                    </div>

                                    <div class="nav-item-has-dropdown">
                                        <a href="category?id=3" class="header-item">Quần</a>
                                        <div class="nav-dropdown">
                                            <%
                                                List<Category> listPant = (List<Category>) request.getAttribute("pant");
                                                if (listPant != null) {
                                                    for (Category c : listPant) {
                                            %>
                                            <a href="category?id=<%= c.getId()%>"><%= c.getName()%></a>
                                            <%      }
                                                }
                                            %>
                                        </div>
                                    </div>

                                    <div class="nav-item-has-dropdown">
                                        <a href="category?id=4" class="header-item">Phụ kiện</a>
                                        <div class="nav-dropdown">
                                            <%
                                                List<Category> listAcc = (List<Category>) request.getAttribute("accessories");
                                                if (listAcc != null) {
                                                    for (Category c : listAcc) {
                                            %>
                                            <a href="category?id=<%= c.getId()%>"><%= c.getName()%></a>
                                            <%      }
                                                }
                                            %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3">
                            <form action="search" method="GET" class="search-wrap">
                                <input type="text" name="keyword" class="form-control search-bar"
                                       placeholder="Tìm kiếm" required>
                                <button type="submit" class="search-btn">
                                    <i class="fa-solid fa-magnifying-glass search-icon"></i>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <div class="container mt-5 mb-5" style="min-height: 600px;">
            <%-- Điều hướng Tab --%>
            <ul class="nav nav-tabs mb-4" id="cartTabs" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active font-weight-bold text-dark" id="cart-tab" data-toggle="tab" href="#cart-content" role="tab">
                        <i class="fa-solid fa-cart-shopping mr-2"></i>GIỎ HÀNG CỦA BẠN
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link font-weight-bold text-dark" id="order-tab" data-toggle="tab" href="#order-history" role="tab">
                        <i class="fa-solid fa-clock-rotate-left mr-2"></i>LỊCH SỬ ĐẶT HÀNG
                    </a>
                </li>
            </ul>

            <div class="tab-content" id="cartTabsContent">
                <%-- TAB 1: GIỎ HÀNG --%>
                <div class="tab-pane fade show active" id="cart-content" role="tabpanel">
                    <%-- Hiển thị lỗi tồn kho nếu có --%>
                    <c:if test="${not empty sessionScope.cartError}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-triangle-exclamation mr-2"></i>
                            ${sessionScope.cartError}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <% session.removeAttribute("cartError"); %>
                    </c:if>

                    <form action="checkout" method="POST" id="cartForm">
                        <div class="row">
                            <div class="col-md-8">
                                <c:if test="${empty cartList}">
                                    <div class="alert alert-light text-center py-5 border">
                                        <p class="mb-0 text-muted">Hiện chưa có sản phẩm nào trong giỏ hàng.</p>
                                    </div>
                                </c:if>

                                <c:forEach items="${cartList}" var="item">
                                    <div class="row border-bottom py-3 align-items-center bg-white cart-row">
                                        <div class="col-1">
                                            <input type="checkbox" name="selectedItems" value="${item.id}" class="item-checkbox">
                                        </div>
                                        <div class="col-2 text-center">
                                            <img src="${item.image}" class="img-fluid rounded border" style="max-height: 80px;">
                                        </div>
                                        <div class="col-4">
                                            <h6 class="mb-1 font-weight-bold">${item.productName}</h6>
                                            <p class="text-muted small mb-1">${item.color} / ${item.size}</p>
                                            <a href="cart?action=delete&id=${item.id}" class="text-danger small">Xóa</a>
                                        </div>
                                        <div class="col-2 text-center">
                                            <div class="d-flex border justify-content-between align-items-center px-2 py-1">
                                                <a href="cart?action=update&id=${item.id}&qty=${item.quantity - 1}" class="text-dark font-weight-bold">-</a>
                                                <span class="quantity-value">${item.quantity}</span>
                                                <a href="cart?action=update&id=${item.id}&qty=${item.quantity + 1}" class="text-dark font-weight-bold">+</a>
                                            </div>
                                        </div>
                                        <div class="col-3 text-right">
                                            <b class="item-price"><fmt:formatNumber value="${item.price}" pattern="#,###"/>đ</b>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <div class="col-md-4">
                                <div class="card p-4 bg-light border-0 shadow-sm">
                                    <h5 class="font-weight-bold mb-3">TÓM TẮT ĐƠN HÀNG</h5>
                                    <hr>
                                    <div class="d-flex justify-content-between mb-4">
                                        <span>Tổng tiền tạm tính:</span>
                                        <span class="font-weight-bold text-danger h5" id="totalPriceDisplay">0đ</span>
                                    </div>
                                    <button type="submit" class="btn btn-dark w-100 py-3 font-weight-bold" ${empty cartList ? 'disabled' : ''}>
                                        TIẾN HÀNH ĐẶT HÀNG
                                    </button>
                                    <a href="home" class="btn btn-outline-dark w-100 mt-2">TIẾP TỤC MUA SẮM</a>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

                <%-- TAB 2: LỊCH SỬ ĐƠN HÀNG --%>
                <div class="tab-pane fade" id="order-history" role="tabpanel">
                    <c:if test="${empty orderList}">
                        <div class="alert alert-light text-center py-5 border">
                            <p class="mb-0 text-muted">Bạn chưa có đơn hàng nào.</p>
                        </div>
                    </c:if>

                    <c:if test="${not empty orderList}">
                        <div class="table-responsive bg-white border">
                            <table class="table table-hover mb-0">
                                <thead class="thead-light">
                                    <tr>
                                        <th>Mã đơn</th>
                                        <th>Ngày đặt</th>
                                        <th>Tổng tiền</th>
                                        <th>Trạng thái</th>
                                        <th>Ghi chú</th>
                                        <th class="text-center">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${orderList}" var="o">
                                        <tr>
                                            <td class="font-weight-bold text-primary">#${o.id}</td>
                                            <td><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                            <td class="text-danger font-weight-bold">
                                                <fmt:formatNumber value="${o.totalPrice}" pattern="#,###"/>đ
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${o.status == 0}">
                                                        <span class="badge badge-warning p-2">Chờ duyệt</span>
                                                    </c:when>
                                                    <c:when test="${o.status == 1}">
                                                        <span class="badge badge-info p-2">Đã xác nhận</span>
                                                    </c:when>
                                                    <c:when test="${o.status == 2}">
                                                        <span class="badge badge-primary p-2">Đang giao hàng</span>
                                                    </c:when>
                                                    <c:when test="${o.status == 3}">
                                                        <span class="badge badge-success p-2">Giao thành công</span>
                                                    </c:when>
                                                    <c:when test="${o.status == -1}">
                                                        <span class="badge badge-secondary p-2">Đã hủy</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td class="small text-muted">${o.note}</td>
                                            <td class="text-center">
                                                <c:if test="${o.status == 0}">
                                                    <a href="cart?action=cancelOrder&id=${o.id}" 
                                                       class="btn btn-outline-danger btn-sm"
                                                       onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng #${o.id} không?')">
                                                        Hủy đơn
                                                    </a>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <footer class="footer mt-5">
            <div class="container text-center py-4">
                <hr>
                <p class="text-muted small">© 2026 - Hộ kinh doanh ATINO - Số 110 Phố Nhổn, Hà Nội</p>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const checkboxes = document.querySelectorAll('.item-checkbox');
                const totalPriceDisplay = document.getElementById('totalPriceDisplay');
                const cartForm = document.getElementById('cartForm');

                function formatMoney(amount) {
                    return new Intl.NumberFormat('vi-VN').format(amount) + 'đ';
                }

                function calculateTotal() {
                    let total = 0;
                    document.querySelectorAll('.item-checkbox:checked').forEach(checkbox => {
                        const row = checkbox.closest('.cart-row');
                        const price = parseInt(row.querySelector('.item-price').innerText.replace(/[^0-9]/g, ''));
                        const qty = parseInt(row.querySelector('.quantity-value').innerText);
                        total += price * qty;
                    });
                    totalPriceDisplay.innerText = formatMoney(total);
                }

                // Xử lý LocalStorage cho trạng thái Checkbox
                checkboxes.forEach(checkbox => {
                    // 1. Khôi phục trạng thái từ bộ nhớ
                    const savedStatus = localStorage.getItem('cart_item_' + checkbox.value);
                    if (savedStatus === 'true') {
                        checkbox.checked = true;
                    }

                    // 2. Lắng nghe thay đổi tích chọn
                    checkbox.addEventListener('change', function () {
                        localStorage.setItem('cart_item_' + this.value, this.checked);
                        calculateTotal();
                    });
                });

                // 3. Xóa bộ nhớ khi hoàn tất đặt hàng
                if (cartForm) {
                    cartForm.addEventListener('submit', function () {
                        checkboxes.forEach(cb => localStorage.removeItem('cart_item_' + cb.value));
                    });
                }

                // Tính toán lần đầu khi load trang
                calculateTotal();

                // Xử lý chuyển tab tự động nếu có action từ Order history
                const urlParams = new URLSearchParams(window.location.search);
                if (urlParams.get('tab') === 'order' || window.location.hash === '#order-history') {
                    $('#order-tab').tab('show');
                }
            });
        </script>
    </body>
</html>