<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="com.shopshop.dao.CategoryDAO" %>
<%@page import="com.shopshop.model.Category" %>
<%@page import="java.util.List" %>
    <!doctype html>
    <html lang="vi">

    <head>
        <!-- Required meta tags -->
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
            integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

        <title>Atino</title>
        <!-- CSS -->
        <link rel="stylesheet" href="./assets/css/style.css">
        <link rel="stylesheet" href="./assets/css/base.css">
        <link rel="stylesheet" href="./assets/css/reset.css">
        <link rel="stylesheet" href="./assets/css/login.css">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css"
            integrity="sha512-NhSC1YmyruXifcj/KFRWoC561YpHpc5Jtzgvbuzx5VozKpWvQ+4nXhPdFgmx8xqexRcpAglTj9sIBWINXa8x5w=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"
            integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>

    <body>
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
            integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous">
            </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous">
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
                                <a href="./home.jsp">
                                    <img src="./assets/images/logo.jpg" alt="" class="header-logo">
                                </a>
                            </div>
                        </div>
                        <div class="col-xl-7">
                            <div class="nav-wrap">
                                <div class="header-nav">
                                    <a href="./home" class="header-item">Trang chủ</a>
                                    <% CategoryDAO headerCatDAO = new CategoryDAO();
                                       List<Category> rootCats = headerCatDAO.getRootCategories();
                                       for (Category rc : rootCats) {
                                           List<Category> childCats = headerCatDAO.getChildCategories(rc.getId()); %>
                                    <div class="nav-item-has-dropdown">
                                        <a href="category?id=<%= rc.getId() %>" class="header-item"><%= rc.getName() %></a>
                                        <% if (!childCats.isEmpty()) { %>
                                        <div class="nav-dropdown">
                                            <% for (Category cc : childCats) { %>
                                            <a href="category?id=<%= cc.getId() %>"><%= cc.getName() %></a>
                                            <% } %>
                                        </div>
                                        <% } %>
                                    </div>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3">
                            <form action="search" method="GET" class="search-wrap">
                                <input type="text" name="keyword" class="form-control search-bar" placeholder="Tìm kiếm"
                                    required>
                                <button type="submit" class="search-btn">
                                    <i class="fa-solid fa-magnifying-glass search-icon"></i>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <style>

        </style>

        <div class="login">
            <div class="container">
                <div class="login-wrapper">
                    <div class="login-box">
                        <% String error=(String) request.getAttribute("error"); %>
                            <% String registerError=(String) request.getAttribute("registerError"); %>
                                <% boolean showRegister=request.getAttribute("showRegister") !=null; %>
                                    <% String registerSuccess=request.getParameter("registerSuccess"); %>
                                        <div class="login-tabs d-flex">
                                            <div class="tab-item <%= showRegister ? "" : " active" %>"
                                                id="tab-login">Đăng nhập</div>
                                            <div class="tab-item <%= showRegister ? " active" : "" %>"
                                                id="tab-register">Đăng ký</div>
                                        </div>

                                        <div class="login-form-body" id="form-login"
                                            style="display: <%= showRegister ? " none" : "block" %>">
                                            <form action="login" method="POST">
                                                <% if ("true".equals(registerSuccess)) { %>
                                                    <div class="alert alert-success" style="font-size: 14px;">
                                                        Đăng ký thành công! Vui lòng đăng nhập.
                                                    </div>
                                                    <% } %>
                                                        <% if (error !=null) { %>
                                                            <div class="alert alert-danger" style="font-size: 14px;">
                                                                <%= error %>
                                                            </div>
                                                            <% } %>
                                                                <div class="form-group mb-4">
                                                                    <input type="text" name="username"
                                                                        class="form-control"
                                                                        placeholder="Nhập email hoặc Tên đăng nhập">
                                                                </div>
                                                                <div class="form-group mb-4">
                                                                    <input type="password" name="password"
                                                                        class="form-control" placeholder="Mật khẩu">
                                                                </div>
                                                                <button type="submit"
                                                                    class="btn btn-login-submit mb-3 col-12">ĐĂNG
                                                                    NHẬP</button>

                                                                <div class="text-center mt-2 mb-3">
                                                                    <a href="#"
                                                                        style="color: #4285f4; font-size: 14px; text-decoration: none;">Quên
                                                                        mật
                                                                        khẩu?</a>
                                                                    <!-- <p class="mt-2 text-muted" style="font-size: 14px;">
                                                                        Hoặc đăng nhập
                                                                        với</p> -->
                                                                </div>

                                                                <!-- <div class="row px-2">
                                                                    <div class="col-6 px-2">
                                                                        <a href="#" class="social-btn btn-fb w-100">
                                                                            <div class="icon-box">
                                                                                <i class="fa-brands fa-facebook-f"></i>
                                                                            </div>
                                                                            <span class="flex-grow-1 text-center">Đăng
                                                                                nhập bằng
                                                                                Facebook</span>
                                                                        </a>
                                                                    </div>
                                                                    <div class="col-6 px-2">
                                                                        <a href="#" class="social-btn btn-gg w-100">
                                                                            <div class="icon-box">
                                                                                <i class="fa-brands fa-google text-dark bg-white"
                                                                                    style="display: inline-flex; align-items: center; justify-content: center; width: 24px; height: 24px; border-radius: 50%; font-size: 12px;"></i>
                                                                            </div>
                                                                            <span class="flex-grow-1 text-center">Đăng
                                                                                nhập bằng
                                                                                Google</span>
                                                                        </a>
                                                                    </div>
                                                                </div> -->
                                            </form>
                                        </div>

                                        <div class="login-form-body" id="form-register"
                                            style="display: <%= showRegister ? " block" : "none" %>;">
                                            <form action="register" method="POST">
                                                <%-- Hiển thị lỗi đăng ký nếu có --%>
                                                    <% if (registerError !=null) { %>
                                                        <div class="alert alert-danger" style="font-size: 14px;">
                                                            <%= registerError %>
                                                        </div>
                                                        <% } %>
                                                            <div class="form-group mb-4">
                                                                <input type="text" name="fullName" class="form-control"
                                                                    placeholder="Họ và tên *" required>
                                                            </div>
                                                            <div class="form-group mb-4">
                                                                <input type="text" name="username" class="form-control"
                                                                    placeholder="Tên đăng nhập *" required>
                                                            </div>
                                                            <div class="form-group mb-4">
                                                                <input type="text" name="phone" class="form-control"
                                                                    placeholder="Số điện thoại">
                                                            </div>
                                                            <div class="form-group mb-4">
                                                                <input type="email" name="email" class="form-control"
                                                                    placeholder="Email">
                                                            </div>
                                                            <div class="form-group mb-4">
                                                                <input type="password" name="password"
                                                                    class="form-control" placeholder="Mật khẩu *"
                                                                    required>
                                                            </div>
                                                            <div class="form-group mb-4">
                                                                <input type="password" name="confirmPassword"
                                                                    class="form-control"
                                                                    placeholder="Xác nhận mật khẩu *" required>
                                                            </div>
                                                            <button type="submit"
                                                                class="btn btn-login-submit mb-3 w-100">ĐĂNG KÝ TÀI
                                                                KHOẢN</button>
                                            </form>
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
                            <button class="form-control" id="customer-btn">Đăng ký</button>
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
                        <a href="#" class="footer-item-link">Hướng dẫn chọn size</a> <br>
                        <a href="#" class="footer-item-link">Phương thức</a> <br>
                        <a href="#" class="footer-item-link">Chính sách vận chuyển</a> <br>
                        <a href="#" class="footer-item-link">Chính sách bảo mật</a> <br>
                        <a href="#" class="footer-item-link">Qui định đổi trả</a> <br>
                        <a href="#" class="footer-item-link">Chính sách xử lý khiếu nại</a>
                    </div>
                    <div class="col-xl-3">
                        <h3 class="footer-item-title">Về chúng tôi</h3>
                        <p class="footer-item-text">Hộ kinh doanh atino</p>
                        <p style="font-size: 14px; margin-bottom: 5px;"><b>Địa chỉ: </b>Số 110 Phố Nhổn, Phường Tây Tựu,
                            Quận Bắc Từ Liêm, Tp. Hà Nộ</p>
                        <p style="font-size: 14px; margin-bottom: 5px;"><b>Mã Số Doanh Nghiệp: </b>01D-8004624</p>
                        <p style="font-size: 14px; margin-bottom: 5px;"><b>Email: </b>cntt@atino.vn</p>
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
                            width="100%" height="250" style="border:none;overflow:hidden" scrolling="no" frameborder="0"
                            allowfullscreen="true"
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

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Lấy các phần tử tab và form
                const tabLogin = document.getElementById('tab-login');
                const tabRegister = document.getElementById('tab-register');
                const formLogin = document.getElementById('form-login');
                const formRegister = document.getElementById('form-register');

                // Bắt sự kiện click vào tab Đăng nhập
                tabLogin.addEventListener('click', function () {
                    // Đổi trạng thái tab
                    tabLogin.classList.add('active');
                    tabRegister.classList.remove('active');

                    // Hiển thị form đăng nhập, ẩn form đăng ký
                    formLogin.style.display = 'block';
                    formRegister.style.display = 'none';
                });

                // Bắt sự kiện click vào tab Đăng ký
                tabRegister.addEventListener('click', function () {
                    // Đổi trạng thái tab
                    tabRegister.classList.add('active');
                    tabLogin.classList.remove('active');

                    // Hiển thị form đăng ký, ẩn form đăng nhập
                    formRegister.style.display = 'block';
                    formLogin.style.display = 'none';
                });
            });
        </script>
    </body>

    </html>