<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page import="com.shopshop.model.Product" %>
        <%@page import="com.shopshop.model.ProductVariant" %>
                <%@page import="com.shopshop.model.Category" %>
            <%@page import="java.util.List" %>
                <%@page import="java.text.NumberFormat" %>
                    <%@page import="java.util.Locale" %>
                        <% Product product=(Product) request.getAttribute("product"); if (product==null) {
                            response.sendRedirect("home"); return; } NumberFormat nf=NumberFormat.getNumberInstance(new
                            Locale("vi", "VN" )); String formattedPrice=nf.format((long) product.getPrice());
                            List<ProductVariant> variants = product.getVariants();
                            // Lấy danh sách màu và size không trùng
                            java.util.Set<String> colors = new java.util.LinkedHashSet<>();
                                    java.util.Set<String> sizes = new java.util.LinkedHashSet<>();
                                            if (variants != null) {
                                            for (ProductVariant v : variants) {
                                            if (v.getColor() != null && !v.getColor().isEmpty())
                                            colors.add(v.getColor());
                                            if (v.getSize() != null && !v.getSize().isEmpty()) sizes.add(v.getSize());
                                            }
                                            }
                                            %>
                                            <!doctype html>
                                            <html lang="vi">

                                            <head>
                                                <!-- Required meta tags -->
                                                <meta charset="UTF-8">
                                                <meta name="viewport"
                                                    content="width=device-width, initial-scale=1, shrink-to-fit=no">

                                                <!-- Bootstrap CSS -->
                                                <link rel="stylesheet"
                                                    href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
                                                    integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
                                                    crossorigin="anonymous">

                                                <title>
                                                    <%= product.getName() %> - Atino
                                                </title>
                                                <!-- CSS -->
                                                <link rel="stylesheet" href="./assets/css/style.css">
                                                <link rel="stylesheet" href="./assets/css/base.css">
                                                <link rel="stylesheet" href="./assets/css/reset.css">
                                                <link rel="stylesheet" href="./assets/css/product.css">

                                                <link rel="stylesheet"
                                                    href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css"
                                                    integrity="sha512-NhSC1YmyruXifcj/KFRWoC561YpHpc5Jtzgvbuzx5VozKpWvQ+4nXhPdFgmx8xqexRcpAglTj9sIBWINXa8x5w=="
                                                    crossorigin="anonymous" referrerpolicy="no-referrer" />
                                                <link rel="stylesheet"
                                                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"
                                                    integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw=="
                                                    crossorigin="anonymous" referrerpolicy="no-referrer" />
                                            </head>

                                            <body>
                                                <script
                                                    src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
                                                    integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
                                                    crossorigin="anonymous">
                                                    </script>
                                                <script
                                                    src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
                                                    integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
                                                    crossorigin="anonymous">
                                                    </script>

                                                <link rel="preconnect" href="https://fonts.googleapis.com">
                                                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                                                <link
                                                    href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
                                                    rel="stylesheet">


                                                <div class="section-one">
                                                    <div class="container-fluid">
                                                        <div class="inner-wrap">
                                                            <div class="phone-wrap">
                                                                <i class="fa-solid fa-phone phone-icon"></i>
                                                                <p class="phone-number">096728.4444</p>
                                                            </div>
                                                            <div class="account-wrap">
                                                                <% com.shopshop.model.Users
                                                                    sessionUser=(com.shopshop.model.Users)
                                                                    session.getAttribute("user"); %>
                                                                    <% if (sessionUser !=null) { %>
                                                                        <div class="account">
                                                                            <i
                                                                                class="fa-solid fa-person account-icon"></i>
                                                                            <p class="account-text">
                                                                                <%= sessionUser.getFullName() %>
                                                                            </p>
                                                                        </div>
                                                                        <div class="logout" style="margin-right: 20px;">
                                                                            <i class="fa-solid fa-right-from-bracket"
                                                                                style="margin-right: 5px;"></i>
                                                                            <a href="logout" class="account-link"
                                                                                style="text-decoration: none; color: #5a5a5a;">
                                                                                <p class="account-text"
                                                                                    style="margin: 0;">Đăng xuất</p>
                                                                            </a>
                                                                        </div>
                                                                        <% } else { %>
                                                                            <div class="account">
                                                                                <i
                                                                                    class="fa-solid fa-person account-icon"></i>
                                                                                <a href="./login.jsp"
                                                                                    class="account-link">
                                                                                    <p class="account-text">Tài khoản
                                                                                    </p>
                                                                                </a>
                                                                            </div>
                                                                            <% } %>
                                                                                <div class="cart">
                                                                                    <i
                                                                                        class="fa-solid fa-cart-arrow-down cart-icon"></i>
                                                                                    <p class="cart-text">Giỏ hàng(0)</p>
                                                                                </div>
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
                                                                            <img src="./assets/images/logo.jpg" alt=""
                                                                                class="header-logo">
                                                                        </a>
                                                                    </div>
                                                                </div>
                                                                <div class="col-xl-7">
                                                                    <div class="nav-wrap">
                                                                        <div class="header-nav">
                                                                            <a href="home"
                                                                                class="header-item">Trang chủ</a>
                                                                           <div class="nav-item-has-dropdown">
    <a href="category?id=1" class="header-item">Áo Thu Đông</a>
    <div class="nav-dropdown">
        <% 
            List<Category> listWinter = (List<Category>) request.getAttribute("winter");
            if (listWinter != null) {
                for (Category c : listWinter) { 
        %>
            <a href="category?id=<%= c.getId() %>"><%= c.getName() %></a>
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
            <a href="category?id=<%= c.getId() %>"><%= c.getName() %></a>
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
            <a href="category?id=<%= c.getId() %>"><%= c.getName() %></a>
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
            <a href="category?id=<%= c.getId() %>"><%= c.getName() %></a>
        <%      }
            } 
        %>
    </div>
</div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-xl-3">
                                                                    <form action="search" method="GET"
                                                                        class="search-wrap">
                                                                        <input type="text" name="keyword"
                                                                            class="form-control search-bar"
                                                                            placeholder="Tìm kiếm" required>
                                                                        <button type="submit" class="search-btn">
                                                                            <i
                                                                                class="fa-solid fa-magnifying-glass search-icon"></i>
                                                                        </button>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </header>

                                                <!-- Breadcumb -->
                                                <div class="breadcrumb-section">
                                                    <div class="container-fluid">
                                                        <nav aria-label="breadcrumb">
                                                            <ol class="breadcrumb custom-breadcrumb">
                                                                <li class="breadcrumb-item"><a href="home">Trang chủ</a>
                                                                </li>
                                                                <li class="breadcrumb-item active" aria-current="page">
                                                                    <%= product.getName() %>
                                                                </li>
                                                            </ol>
                                                        </nav>
                                                    </div>
                                                </div>

                                                <!-- product section -->
                                                <div class="product-detail-section mt-5 mb-5">
                                                    <div class="container">
                                                        <div class="row">
                                                            <div class="col-xl-1 col-lg-2 col-md-2 d-none d-md-block">
                                                                <div class="product-thumbnails">
                                                                    <img src="<%= product.getImage() %>"
                                                                        alt="<%= product.getName() %>"
                                                                        class="thumb-img active">
                                                                </div>
                                                            </div>

                                                            <div class="col-xl-6 col-lg-5 col-md-10">
                                                                <div class="product-main-image">
                                                                    <img src="<%= product.getImage() %>"
                                                                        alt="<%= product.getName() %>"
                                                                        id="main-product-img">
                                                                    <div class="img-nav prev"><i
                                                                            class="fa-solid fa-chevron-left"></i></div>
                                                                    <div class="img-nav next"><i
                                                                            class="fa-solid fa-chevron-right"></i></div>
                                                                </div>
                                                            </div>

                                                            <div class="col-xl-5 col-lg-5 col-md-12">
                                                                <div class="product-info">
                                                                    <h1 class="product-name">
                                                                        <%= product.getName() %>
                                                                    </h1>
                                                                    <p class="product-status">Tình trạng:
                                                                        <span>
                                                                            <%= product.getQuantity()> 0 ? "Còn hàng" :
                                                                                "Hết hàng" %>
                                                                        </span>
                                                                    </p>

                                                                    <div class="product-price">
                                                                        <%= formattedPrice %>₫
                                                                    </div>
                                                                    <hr>

                                                                    <div class="product-options">
                                                                        <% if (!colors.isEmpty()) { %>
                                                                            <div class="option-group">
                                                                                <label>MÀU SẮC</label>
                                                                                <div class="color-list">
                                                                                    <% boolean firstColor=true; %>
                                                                                        <% for (String color : colors) { %>
                                                                                            <div class="color-item <%= firstColor ? "active" : "" %>">
                                                                                                <span style="padding: 4px 8px; font-size: 13px; text-transform: capitalize;">
                                                                                                    <%= color %>
                                                                                                </span>
                                                                                            </div>
                                                                                            <% firstColor=false; } %>
                                                                                </div>
                                                                            </div>
                                                                            <% } %>

                                                                                <% if (!sizes.isEmpty()) { %>
                                                                                    <div class="option-group">
                                                                                        <div
                                                                                            class="size-label-wrap d-flex justify-content-between">
                                                                                            <label>KÍCH THƯỚC</label>
                                                                                            <a href="#"
                                                                                                class="size-guide">Hướng
                                                                                                Dẫn Chọn Size</a>
                                                                                        </div>
                                                                                        <div class="size-list">
                                                                                            <% boolean firstSize=true;
                                                                                                %>
                                                                                                <% for (String size : sizes) { %>
                                                                                                    <div style="text-transform: uppercase;" class="size-item <%= firstSize ? "active" : "" %>">
                                                                                                        <%= size %>
                                                                                                    </div>
                                                                                                    <% firstSize=false; } %>
                                                                                        </div>
                                                                                    </div>
                                                                                    <% } %>
                                                                    </div>

                                                                    <div class="product-actions mt-4">
                                                                        <div class="quantity-selector">
                                                                            <button class="qty-btn minus">-</button>
                                                                            <input type="text" value="1"
                                                                                class="qty-input">
                                                                            <button class="qty-btn plus">+</button>
                                                                        </div>

                                                                        <div class="action-buttons d-flex mt-3">
                                                                            <button class="btn-add-cart w-50 mr-2">THÊM
                                                                                VÀO GIỎ HÀNG</button>
                                                                            <button class="btn-buy-now w-50 ml-2">MUA
                                                                                NGAY</button>
                                                                        </div>

                                                                        <button class="btn-wishlist w-100 mt-3"><i
                                                                                class="fa-regular fa-heart"></i> YÊU
                                                                            THÍCH</button>
                                                                    </div>

                                                                    <div class="product-share mt-3 text-center">
                                                                        <a href="#" class="share-icon"><i
                                                                                class="fa-brands fa-facebook-f"></i></a>
                                                                    </div>

                                                                    <div class="store-availability mt-4">
                                                                        <div class="store-header">Cửa hàng còn sản phẩm
                                                                            này</div>
                                                                        <select class="form-control store-select">
                                                                            <option>- Tỉnh thành -</option>
                                                                            <option>Hà Nội</option>
                                                                        </select>
                                                                        <div class="store-list mt-2">
                                                                            <div class="store-item">
                                                                                <i class="fa-solid fa-location-dot"></i>
                                                                                <div class="store-info">
                                                                                    <p class="store-address">110 Phố
                                                                                        Nhổn, HN, MB_CH1:</p>
                                                                                    <p class="store-phone">0969326783
                                                                                    </p>
                                                                                    <p class="store-status in-stock">110
                                                                                        Phố Nhổn, HN, MB_CH1 <span>(Còn
                                                                                            hàng)</span></p>
                                                                                </div>
                                                                            </div>
                                                                            <div class="store-item">
                                                                                <i class="fa-solid fa-location-dot"></i>
                                                                                <div class="store-info">
                                                                                    <p class="store-address">208 Bạch
                                                                                        Mai, HN, MB_CH4:</p>
                                                                                    <p class="store-phone">0969824182
                                                                                    </p>
                                                                                    <p class="store-status out-stock">
                                                                                        208 Bạch Mai, HN, MB_CH4
                                                                                        <span>(Hết hàng)</span>
                                                                                    </p>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="horizontal-ruler">
                                                    <div class="container">
                                                        <div class="row">
                                                            <hr class="hr">
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="customer-service">
                                                    <div class="container">
                                                        <div class="row">
                                                            <div class="col-xl-3">
                                                                <h3 class="customer-title">
                                                                    GỌI MUA HÀNG (8:30 - 22:20)
                                                                </h3>
                                                                <p class="customer-call-number">0967.284.444</p>
                                                                <p class="customer-desc">Tất cả các ngày trong tuần</p>
                                                            </div>
                                                            <div class="col-xl-3">
                                                                <h3 class="customer-title">
                                                                    GÓP Ý, KHIẾU NẠI (8:00 - 17:00)
                                                                </h3>
                                                                <p class="customer-call-number">0968.959.050</p>
                                                                <p class="customer-desc">Các ngày trong tuần (trừ ngày
                                                                    lễ)</p>
                                                            </div>
                                                            <div class="col-xl-3">
                                                                <h3 class="customer-title">Đăng ký nhận thông tin mới
                                                                </h3>
                                                                <div class="form-wrap">
                                                                    <input type="text" class="form-control"
                                                                        id="customer-email"
                                                                        placeholder="Nhập email của bạn tại đây...">
                                                                    <button class="form-control" id="customer-btn">Đăng
                                                                        ký</button>
                                                                </div>
                                                            </div>
                                                            <div class="col-xl-3">
                                                                <h3 class="customer-title">
                                                                    Theo dõi chúng tôi
                                                                </h3>
                                                                <div class="customer-socials-wrap">
                                                                    <a href="#" class="customer-socials-item">
                                                                        <i class="fa-brands fa-facebook-f"></i>
                                                                    </a>
                                                                    <a href="#" class="customer-socials-item">
                                                                        <i class="fa-brands fa-instagram"></i>
                                                                    </a>
                                                                    <a href="#" class="customer-socials-item">
                                                                        <i class="fa-solid fa-shop"></i>
                                                                    </a>
                                                                    <a href="#" class="customer-socials-item">
                                                                        <i class="fa-brands fa-twitter"></i>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>

                                                <footer class="footer">
                                                    <div class="container">
                                                        <div class="row">
                                                            <div class="col-xl-3">
                                                                <h3 class="footer-item-title">Hỗ trợ khách hàng</h3>
                                                                <a href="#" class="footer-item-link">Hướng dẫn mua
                                                                    hàng</a> <br>
                                                                <a href="#" class="footer-item-link">Hướng dẫn chọn
                                                                    size</a> <br>
                                                                <a href="#" class="footer-item-link">Phương thức</a>
                                                                <br>
                                                                <a href="#" class="footer-item-link">Chính sách vận
                                                                    chuyển</a> <br>
                                                                <a href="#" class="footer-item-link">Chính sách bảo
                                                                    mật</a> <br>
                                                                <a href="#" class="footer-item-link">Qui định đổi
                                                                    trả</a> <br>
                                                                <a href="#" class="footer-item-link">Chính sách xử lý
                                                                    khiếu nại</a>
                                                            </div>
                                                            <div class="col-xl-3">
                                                                <h3 class="footer-item-title">Về chúng tôi</h3>
                                                                <p class="footer-item-text">Hộ kinh doanh atino</p>
                                                                <p style="font-size: 14px; margin-bottom: 5px;"><b>Địa
                                                                        chỉ: </b>Số 110 Phố Nhổn, Phường Tây Tựu,
                                                                    Quận Bắc Từ Liêm, Tp. Hà Nộ</p>
                                                                <p style="font-size: 14px; margin-bottom: 5px;"><b>Mã Số
                                                                        Doanh Nghiệp: </b>01D-8004624</p>
                                                                <p style="font-size: 14px; margin-bottom: 5px;">
                                                                    <b>Email: </b>cntt@atino.vn
                                                                </p>
                                                            </div>
                                                            <div class="col-xl-3">
                                                                <h3 class="footer-item-title">Hệ thống cửa hàng</h3>
                                                                <h4 class="footer-list-title">Thành phố Hà Nội</h4>
                                                                <ul class="footer-item-list">
                                                                    <li class="footer-item">
                                                                        110 Phố Nhổn
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        1221 Giải Phóng
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        154 Quang Trung, Hà Đông
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        34 Trần Phú, Hà Đông
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        208 Bạch Mai
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        175 Chùa Bộc
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        116 Cầu Giấy
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        290 Nguyễn Trãi, Trung Văn (Gần Đại học Hà Nội)
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        312 Khu 6 Trạm Trôi, Hoài Đức
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        195 Quang Trung, Tx.Sơn Tây
                                                                    </li>
                                                                </ul>

                                                                <h4 class="footer-list-title">Khu vực miền Nam:</h4>
                                                                <ul class="footer-item-list">
                                                                    <li class="footer-item">
                                                                        225 Võ Văn Ngân, Thủ Đức, HCM
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        567 Quang Trung, P10, Gò Vấp, HCM
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        242 Nguyễn Trãi, P5, Q5, HCM
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        TP. Biên Hoà: 1363 Phạm Văn Thuận
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        Bình Dương: 93 Yersin, TP Thủ Dầu Một
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        Cần Thơ: 73 Nguyễn Việt Hồng
                                                                    </li>
                                                                </ul>

                                                                <h4 class="footer-list-title">Các tỉnh & thành phố khác:
                                                                </h4>
                                                                <ul class="footer-item-list">
                                                                    <li class="footer-item">
                                                                        TP. Thanh Hoá: 236-238 Lê Hoàn
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        TP. Vinh: 167 Nguyễn Văn Cừ, TP Vinh
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        TP. Bắc Ninh: 128 Trần Hưng Đạo
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        TP. Thái Nguyên: 156 Lương Ngọc Quyến
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        TP. Hải Phòng: 300 Lê Lợi
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        TP. Huế: 42 Bến Nghé
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        TP. Đà Nẵng: 436 Lê Duẩn
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        TP. Nam Định: 57 Hàn Thuyên
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        TP. Hạ Long: 581 Lê Thánh Tông
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        TP. Hải Dương: 58 Trần Hưng Đạo
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        TP. Thái Bình: 122 Trần Hưng Đạo
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        TP. Ninh Bình: 61 Đinh Tiên Hoàng
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        TP. Việt Trì: 2145 Đại Lộ Hùng Vương, Phú Thọ
                                                                    </li>
                                                                    <li class="footer-item">
                                                                        TP. Bắc Giang: 206 Hoàng Văn Thụ, Bắc Giang
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                            <div class="col-xl-3">
                                                                <iframe
                                                                    src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2FAtino.vn&tabs=timeline&width=340&height=250&small_header=true&adapt_container_width=true&hide_cover=true&show_facepile=false"
                                                                    width="100%" height="250"
                                                                    style="border:none;overflow:hidden" scrolling="no"
                                                                    frameborder="0" allowfullscreen="true"
                                                                    allow="autoplay; clipboard-write; encrypted-media; picture-in-picture; web-share"></iframe>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </footer>

                                                <script>
                                                    window.addEventListener('scroll', function () {
                                                        const header = document.querySelector('.header');
                                                        if (window.scrollY > 150) {
                                                            header.classList.add('sticky');
                                                        } else {
                                                            header.classList.remove('sticky');
                                                        }
                                                    });

                                                    $(document).ready(function () {
                                                        // --- 1. XỬ LÝ SLIDE ẢNH SẢN PHẨM ---
                                                        let images = [];
                                                        // Lấy danh sách link ảnh từ các ảnh nhỏ
                                                        $('.thumb-img').each(function () {
                                                            images.push($(this).attr('src'));
                                                        });
                                                        let currentIndex = 0;

                                                        // Khi click vào ảnh nhỏ
                                                        $('.thumb-img').click(function () {
                                                            // Cập nhật lại vị trí index hiện tại
                                                            currentIndex = $('.thumb-img').index(this);
                                                            updateImage(); // Gọi hàm cập nhật ảnh
                                                        });

                                                        // Khi click mũi tên Phải (Next)
                                                        $('.img-nav.next').click(function () {
                                                            currentIndex++;
                                                            if (currentIndex >= images.length) {
                                                                currentIndex = 0; // Quay lại ảnh đầu nếu vượt quá số lượng
                                                            }
                                                            updateImage();
                                                        });

                                                        // Khi click mũi tên Trái (Prev)
                                                        $('.img-nav.prev').click(function () {
                                                            currentIndex--;
                                                            if (currentIndex < 0) {
                                                                currentIndex = images.length - 1; // Lùi về ảnh cuối nếu đang ở ảnh đầu
                                                            }
                                                            updateImage();
                                                        });

                                                        // Hàm hỗ trợ cập nhật ảnh và viền đen CÓ ANIMATION FADE
                                                        function updateImage() {
                                                            let mainImg = $('#main-product-img');

                                                            // 1. Thêm class 'fade-out' để làm mờ ảnh cũ (mất 0.3s)
                                                            mainImg.addClass('fade-out');

                                                            // 2. Sử dụng setTimeout để đợi hiệu ứng fade-out hoàn tất (300ms)
                                                            setTimeout(function () {
                                                                // 3. Đổi link ảnh to sang ảnh mới
                                                                mainImg.attr('src', images[currentIndex]);

                                                                // 4. Xóa viền đen ở các ảnh khác, thêm viền đen vào ảnh nhỏ tương ứng
                                                                $('.thumb-img').removeClass('active');
                                                                $('.thumb-img').eq(currentIndex).addClass('active');

                                                                // 5. Xóa class 'fade-out' để làm hiện ảnh mới (mất 0.3s)
                                                                mainImg.removeClass('fade-out');
                                                            }, 300); // Thời gian chờ này phải khớp với transition trong CSS
                                                        }

                                                        // --- 2. XỬ LÝ NÚT TĂNG GIẢM SỐ LƯỢNG ---
                                                        $('.qty-btn.plus').click(function () {
                                                            let input = $(this).siblings('.qty-input');
                                                            let val = parseInt(input.val());
                                                            input.val(val + 1);
                                                        });

                                                        $('.qty-btn.minus').click(function () {
                                                            let input = $(this).siblings('.qty-input');
                                                            let val = parseInt(input.val());
                                                            if (val > 1) {
                                                                input.val(val - 1);
                                                            }
                                                        });

                                                        // --- 3. XỬ LÝ CHỌN MÀU SẮC VÀ KÍCH THƯỚC ---
                                                        $('.size-item').click(function () {
                                                            $('.size-item').removeClass('active');
                                                            $(this).addClass('active');
                                                        });

                                                        $('.color-item').click(function () {
                                                            $('.color-item').removeClass('active');
                                                            $(this).addClass('active');
                                                        });
                                                    });
                                                </script>
                                            </body>

                                            </html>