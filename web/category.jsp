<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page import="com.shopshop.model.Product" %>
    <%@page import="com.shopshop.model.Category" %>
    <%@page import="com.shopshop.dao.CategoryDAO" %>
    <%@page import="java.util.List" %>
    <%@page import="java.util.Arrays" %>
    <%@page import="java.text.NumberFormat" %>
    <%@page import="java.util.Locale" %>
                        <!doctype html>
                        <html lang="vi">

                        <head>
                            <!-- Required meta tags -->
                            <meta charset="utf-8">
                            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

                            <!-- Bootstrap CSS -->
                            <link rel="stylesheet"
                                href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
                                integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
                                crossorigin="anonymous">

                            <title>Atino</title>
                            <!-- CSS -->
                            <link rel="stylesheet" href="./assets/css/style.css">
                            <link rel="stylesheet" href="./assets/css/base.css">
                            <link rel="stylesheet" href="./assets/css/reset.css">
                            <meta charset="UTF-8">
                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
                            <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
                                integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
                                crossorigin="anonymous">
                                </script>
                            <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
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
                                            <% com.shopshop.model.Users user=(com.shopshop.model.Users)
                                                session.getAttribute("user"); %>
                                                <% if (user !=null) { %>
                                                    <div class="account">
                                                        <i class="fa-solid fa-person account-icon"></i>
                                                        <p class="account-text">
                                                            <%= user.getFullName() %>
                                                        </p>
                                                    </div>
                                                    <div class="logout" style="margin-right: 20px;">
                                                        <i class="fa-solid fa-right-from-bracket"
                                                            style="margin-right: 5px;"></i>
                                                        <a href="logout" class="account-link"
                                                            style="text-decoration: none; color: #5a5a5a;">
                                                            <p class="account-text" style="margin: 0;">Đăng xuất</p>
                                                        </a>
                                                    </div>
                                                    <% } else { %>
                                                        <div class="account">
                                                            <i class="fa-solid fa-person account-icon"></i>
                                                            <a href="login" class="account-link">
                                                                <p class="account-text">Tài khoản</p>
                                                            </a>
                                                        </div>
                                                        <% } %>
                                                            <div class="cart">
                                                                <i class="fa-solid fa-cart-arrow-down cart-icon"></i>
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

                            <div class="breadcrumb-section">
                                <div class="container-fluid">
                                    <% Category category=(Category) request.getAttribute("category"); String
                                        cateName=category !=null ? category.getName() : "Danh mục" ; %>
                                        <nav aria-label="breadcrumb">
                                            <ol class="breadcrumb custom-breadcrumb">
                                                <li class="breadcrumb-item"><a href="home">Trang chủ</a></li>
                                                <li class="breadcrumb-item"><a href="#">
                                                        <%= cateName %>
                                                    </a></li>
                                            </ol>
                                        </nav>
                                </div>
                            </div>

                            <!-- Category -->
                            <div class="category">
                                <div class="container-fluid">
                                    <div class="category-wrap">
                                        <div class="row">
                                            <div class="col-12">
                                                <h2 class="category-title">
                                                    <%= cateName %>
                                                </h2>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-12">
                                            <% // Lấy lại danh sách đã chọn để giữ trạng thái
                                               String[] selectedPrices = (String[]) request.getAttribute("priceRanges");
                                               java.util.List<String> priceList = (selectedPrices != null) ? Arrays.asList(selectedPrices) : new java.util.ArrayList<String>();
                                               
                                               String[] selectedSizes = (String[]) request.getAttribute("sizes");
                                               java.util.List<String> sizeList = (selectedSizes != null) ? Arrays.asList(selectedSizes) : new java.util.ArrayList<String>();
                                               
                                               String[] selectedColors = (String[]) request.getAttribute("colors");
                                               java.util.List<String> colorList = (selectedColors != null) ? Arrays.asList(selectedColors) : new java.util.ArrayList<String>();

                                               int catId = (request.getAttribute("categoryId") != null) ? (int) request.getAttribute("categoryId") : 1;
                                            %>
                                            <div class="filter-wrap">
                                                <form action="category" method="GET" id="filterForm">
                                                    <input type="hidden" name="id" value="<%= catId %>">
                                                    <div class="filter-header">
                                                        <span class="filter-label">Bộ lọc</span>
                                                        <div class="filter-item"> Kích cỡ <i class="fa-solid fa-caret-down"></i> </div>
                                                        <div class="filter-item"> Màu sắc <i class="fa-solid fa-caret-down"></i> </div>
                                                        <div class="filter-item"> Khoảng giá <i class="fa-solid fa-caret-down"></i> </div>
                                                    </div>
                                                    <div class="filter-dropdown">
                                                        <div class="row">
                                                            <div class="col-xl-4" style="border-right: 1px solid #eee;">
                                                                <strong style="display:block; margin-bottom:10px;">Kích cỡ</strong>
                                                                <ul class="filter-list" style="max-height: 200px; overflow-y: auto;">
                                                                    <% String[] allSizes = {"s", "m", "l", "xl", "free size"};
                                                                       for (String s : allSizes) { %>
                                                                    <li><input type="checkbox" name="size" value="<%= s %>" id="size-<%= s.replaceAll(" ", "") %>" <%= sizeList.contains(s) ? "checked" : "" %>>
                                                                        <label for="size-<%= s.replaceAll(" ", "") %>" style="text-transform: uppercase;"><%= s %></label></li>
                                                                    <% } %>
                                                                </ul>
                                                            </div>
                                                            <div class="col-xl-4" style="border-right: 1px solid #eee;">
                                                                <strong style="display:block; margin-bottom:10px;">Màu sắc</strong>
                                                                <ul class="filter-list" style="max-height: 200px; overflow-y: auto;">
                                                                    <% String[] allColors = {"trắng", "đen", "navy", "xanh navy", "xanh rêu", "kem", "nâu", "xanh đậm", "xanh nhạt", "be", "xám"};
                                                                       for (int i=0; i<allColors.length; i++) { 
                                                                           String c = allColors[i]; %>
                                                                    <li><input type="checkbox" name="color" value="<%= c %>" id="color-<%= i %>" <%= colorList.contains(c) ? "checked" : "" %>>
                                                                        <label for="color-<%= i %>" style="text-transform: capitalize;"><%= c %></label></li>
                                                                    <% } %>
                                                                </ul>
                                                            </div>
                                                            <div class="col-xl-4">
                                                                <strong style="display:block; margin-bottom:10px;">Khoảng giá</strong>
                                                                <ul class="filter-list">
                                                                    <li><input type="checkbox" name="price" value="1" id="price-1" <%= priceList.contains("1") ? "checked" : "" %>>
                                                                        <label for="price-1">Dưới 200,000</label></li>
                                                                    <li><input type="checkbox" name="price" value="2" id="price-2" <%= priceList.contains("2") ? "checked" : "" %>>
                                                                        <label for="price-2">Từ 200,000 - 500k</label></li>
                                                                    <li><input type="checkbox" name="price" value="3" id="price-3" <%= priceList.contains("3") ? "checked" : "" %>>
                                                                        <label for="price-3">Từ 500,000 - 1Tr</label></li>
                                                                    <li><input type="checkbox" name="price" value="4" id="price-4" <%= priceList.contains("4") ? "checked" : "" %>>
                                                                        <label for="price-4">Trên 1,000,000</label></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <div style="margin-top: 20px;">
                                                            <button type="submit" class="filter-btn">Lọc</button>
                                                            <% if (!priceList.isEmpty() || !sizeList.isEmpty() || !colorList.isEmpty()) { %>
                                                            <a href="category?id=<%= catId %>" class="filter-btn" style="background:#888; margin-left:8px; text-decoration:none;">Bỏ lọc</a>
                                                            <% } %>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Grid Sản phẩm -->
                                <% List<Product> productList = (List<Product>) request.getAttribute("productList");
                                        NumberFormat nf = NumberFormat.getNumberInstance(new Locale("vi", "VN"));
                                        %>
                                        <div class="container-fluid">
                                            <div class="products-wrap">
                                                <div class="row">
                                                    <% if (productList != null && !productList.isEmpty()) {
                                                        for (Product p : productList) { %>
                                                    <div class="col-xl-3">
                                                        <div class="product-wrap">
                                                            <a href="product?id=<%= p.getId() %>">
                                                                <img src="<%= p.getImage() %>" alt="<%= p.getName() %>" class="product-img">
                                                            </a>
                                                            <h4 class="product-title"><%= p.getName() %></h4>
                                                            <div class="product-price-wrap">
                                                                <p class="product-price-number"><%= nf.format((long) p.getPrice()) %></p>
                                                                <i class="fa-solid fa-dong-sign product-price-dong"></i>
                                                            </div>
                                                            <div class="product-button-wrap">
                                                                <button class="product-btn">
                                                                    <i class="fa-solid fa-cart-arrow-down product-btn-icon"></i>
                                                                    Mua nhanh
                                                                </button>
                                                                <a href="product?id=<%= p.getId() %>" class="product-btn"
                                                                    style="display:inline-flex;align-items:center;gap:5px;text-decoration:none;justify-content:center;">
                                                                    <i class="fa-regular fa-eye"></i> Xem chi tiết
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <% } } else { %>
                                                    <div class="col-12 text-center" style="padding: 40px 0;">
                                                        <p style="font-size: 16px; color: #888;">Không có sản phẩm nào trong danh mục này.</p>
                                                    </div>
                                                    <% } %>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Pagination -->
                                        <div class="pagination-section">
                                            <div class="container">
                                                <div class="pagination-wrap">
                                                    <div class="row">
                                                        <div class="col-12">
                                                            <nav aria-label="Page navigation example">
                                                                <ul class="pagination">
                                                                    <li class="page-item">
                                                                        <a class="page-link" href="#"
                                                                            aria-label="Previous">
                                                                            <span aria-hidden="true">&laquo;</span>
                                                                        </a>
                                                                    </li>
                                                                    <li class="page-item"><a class="page-link"
                                                                            href="#">1</a></li>
                                                                    <li class="page-item"><a class="page-link"
                                                                            href="#">2</a></li>
                                                                    <li class="page-item"><a class="page-link"
                                                                            href="#">3</a></li>
                                                                    <li class="page-item">
                                                                        <a class="page-link" href="#" aria-label="Next">
                                                                            <span aria-hidden="true">&raquo;</span>
                                                                        </a>
                                                                    </li>
                                                                </ul>
                                                            </nav>
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
                                                        <p class="customer-desc">Các ngày trong tuần (trừ ngày lễ)</p>
                                                    </div>
                                                    <div class="col-xl-3">
                                                        <h3 class="customer-title">Đăng ký nhận thông tin mới</h3>
                                                        <div class="form-wrap">
                                                            <input type="text" class="form-control" id="customer-email"
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
                                                        <a href="#" class="footer-item-link">Hướng dẫn mua hàng</a> <br>
                                                        <a href="#" class="footer-item-link">Hướng dẫn chọn size</a>
                                                        <br>
                                                        <a href="#" class="footer-item-link">Phương thức</a> <br>
                                                        <a href="#" class="footer-item-link">Chính sách vận chuyển</a>
                                                        <br>
                                                        <a href="#" class="footer-item-link">Chính sách bảo mật</a> <br>
                                                        <a href="#" class="footer-item-link">Qui định đổi trả</a> <br>
                                                        <a href="#" class="footer-item-link">Chính sách xử lý khiếu
                                                            nại</a>
                                                    </div>
                                                    <div class="col-xl-3">
                                                        <h3 class="footer-item-title">Về chúng tôi</h3>
                                                        <p class="footer-item-text">Hộ kinh doanh atino</p>
                                                        <p style="font-size: 14px; margin-bottom: 5px;"><b>Địa chỉ:
                                                            </b>Số 110 Phố Nhổn, Phường Tây Tựu,
                                                            Quận Bắc Từ Liêm, Tp. Hà Nộ</p>
                                                        <p style="font-size: 14px; margin-bottom: 5px;"><b>Mã Số Doanh
                                                                Nghiệp: </b>01D-8004624</p>
                                                        <p style="font-size: 14px; margin-bottom: 5px;"><b>Email:
                                                            </b>cntt@atino.vn</p>
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

                                                        <h4 class="footer-list-title">Các tỉnh & thành phố khác:</h4>
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

                                                // Bạn có thể thay đổi số 150 này. 
                                                // Đây là mốc (tính bằng pixel) khi bạn cuộn qua, header sẽ trượt xuống.
                                                if (window.scrollY > 150) {
                                                    header.classList.add('sticky');
                                                } else {
                                                    header.classList.remove('sticky');
                                                }
                                            });
                                        </script>
                        </body>

                        </html>