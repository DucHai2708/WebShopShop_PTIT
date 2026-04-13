<%@page import="com.shopshop.model.Category"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <title>Đặt hàng thành công - Atino</title>
    <link rel="stylesheet" href="./assets/css/style.css">
    <link rel="stylesheet" href="./assets/css/base.css">
    <link rel="stylesheet" href="./assets/css/reset.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;700&display=swap" rel="stylesheet">
</head>
<body style="background-color: #f8f9fa;">

    <div class="section-one bg-white">
        <div class="container-fluid">
            <div class="inner-wrap">
                <div class="phone-wrap">
                    <i class="fa-solid fa-phone phone-icon"></i>
                    <p class="phone-number">096728.4444</p>
                </div>
                <div class="account-wrap">
                    <% com.shopshop.model.Users user = (com.shopshop.model.Users) session.getAttribute("user"); %>
                    <% if (user != null) { %>
                        <div class="account">
                            <i class="fa-solid fa-person account-icon"></i>
                            <p class="account-text"><%= user.getFullName() %></p>
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
                            <p class="cart-text mb-0">Giỏ hàng(${sessionScope.cartCount != null ? sessionScope.cartCount : 0})</p>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <header class="header bg-white border-bottom">
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
                        
    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8 text-center">
                <div class="card p-5 border-0 shadow-sm" style="border-radius: 15px;">
                    <div class="mb-4">
                        <i class="fa-solid fa-circle-check text-success" style="font-size: 80px;"></i>
                    </div>
                    
                    <h2 class="font-weight-bold mb-3">ĐẶT HÀNG THÀNH CÔNG!</h2>
                    <p class="text-muted mb-4">Cảm ơn bạn đã mua sắm tại Atino. Đơn hàng của bạn đã được ghi nhận và đang chờ xử lý.</p>
                    
                    <div class="bg-light p-4 text-left rounded mb-4" style="border: 1px dashed #ddd;">
                        <h5 class="font-weight-bold mb-3 border-bottom pb-2">Thông tin đơn hàng</h5>
                        <p class="mb-1"><b>Người nhận:</b> ${shipName}</p>
                        <p class="mb-1"><b>Số điện thoại:</b> ${shipPhone}</p>
                        <p class="mb-4"><b>Địa chỉ nhận hàng:</b> ${shipAddress}</p>

                        <h5 class="font-weight-bold mb-3 border-bottom pb-2">Sản phẩm đã đặt</h5>

                        <%-- Vòng lặp lấy dữ liệu từ Servlet ném sang --%>
                        <c:forEach items="${orderedItems}" var="item">
                            <%-- justify-content-between để đẩy ảnh và chữ về 2 phía, ml-auto trên ảnh để ảnh nằm bên phải --%>
                            <div class="d-flex align-items-center justify-content-between mb-3 pb-3 border-bottom">
                                <%-- flex-grow-1 để phần văn bản chiếm hết không gian bên trái, pr-3 để tạo khoảng cách --%>
                                <div class="flex-grow-1 pr-3">
                                    <h6 class="font-weight-bold mb-1 text-dark">${item.productName}</h6>
                                    <p class="text-muted mb-1" style="font-size: 14px;">${item.color} / ${item.size}</p>
                                    <p class="mb-0 text-muted" style="font-size: 14px;">Số lượng: x${item.quantity}</p>
                                </div>

                                <div class="ml-auto">
                                    <img src="${item.image}" alt="${item.productName}" class="rounded border" style="width: 70px; height: 70px; object-fit: cover;">
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="alert alert-warning text-left p-3 mb-4" style="font-size: 14px; border-left: 4px solid #ffc107;">
                        Chúng tôi sẽ XÁC NHẬN đơn hàng bằng TIN NHẮN SMS hoặc GỌI ĐIỆN. Bạn vui lòng kiểm tra TIN NHẮN hoặc NGHE MÁY ngay khi đặt hàng thành công và CHỜ NHẬN HÀNG.
                    </div>
                    
                    <a href="home" class="btn btn-dark py-3 px-5 font-weight-bold" style="border-radius: 30px;">
                        TIẾP TỤC MUA SẮM
                    </a>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer mt-5 bg-white border-top">
        <div class="container text-center py-4">
            <p class="text-muted small mb-0">© 2026 - Hộ kinh doanh ATINO - Số 110 Phố Nhổn, Hà Nội</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>