<%-- 
    Document   : checkout
    Created on : 10 Apr 2026, 9:43:53 am
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <title>Thanh toán - Atino</title>
    <link rel="stylesheet" href="./assets/css/checkout.css">
    <link rel="stylesheet" href="./assets/css/base.css">
</head>
<body style="background-color: #f8f9fa;">
    <div class="container mt-5">
        <h2 class="text-center mb-4 font-weight-bold">Thanh Toán</h2>

        <%-- Hiển thị lỗi vượt tồn kho nếu có --%>
        <c:if test="${not empty requestScope.errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fa-solid fa-triangle-exclamation mr-2"></i>
                ${requestScope.errorMessage}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>

        <form action="process-order" method="POST">
            <div class="row">
                <div class="col-md-7">
                    <div class="card p-4 border-0 shadow-sm">
                        <h5 class="font-weight-bold mb-4">Thông tin giao hàng</h5>
                        
                        <div class="form-group">
                            <input type="text" class="form-control" name="customerName" placeholder="Họ và tên" required value="${sessionScope.user.fullName}">
                        </div>
                        <div class="row">
                            <div class="col-md-7 form-group">
                                <input type="email" class="form-control" name="email" placeholder="Email" value="${sessionScope.user.email}">
                            </div>
                            <div class="col-md-5 form-group">
                                <input type="text" class="form-control" name="phone" placeholder="Số điện thoại" required value="${sessionScope.user.phone}">
                            </div>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control" name="address" placeholder="Địa chỉ chi tiết" required>
                        </div>
                        <div class="form-group mt-4">
                            <textarea class="form-control" name="note" rows="3" placeholder="Ghi chú (Tùy chọn)"></textarea>
                        </div>
                        <h5 class="font-weight-bold mt-4 mb-3">Phương thức thanh toán</h5>
                        <div class="custom-control custom-radio">
                            <input type="radio" id="cod" name="paymentMethod" class="custom-control-input" value="COD" checked>
                            <label class="custom-control-label" for="cod">Thanh toán khi nhận hàng (COD)</label>
                        </div>
                    </div>
                </div>

                <div class="col-md-5">
                    <div class="card p-4 border-0 shadow-sm" style="background-color: #fafafa;">
                        <h5 class="font-weight-bold mb-4">Đơn hàng của bạn</h5>
                        <hr>
                        
                        <c:forEach items="${checkoutList}" var="item">
                            <input type="hidden" name="cartItemIds" value="${item.id}">
                            
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div class="d-flex align-items-center">
                                    <img src="${item.image}" width="60" class="rounded border mr-3">
                                    <div>
                                        <p class="mb-0 font-weight-bold" style="font-size: 14px;">${item.productName}</p>
                                        <p class="mb-0 text-muted small">${item.color} / ${item.size}</p>
                                        <p class="mb-0 text-muted small">x ${item.quantity}</p>
                                    </div>
                                </div>
                                <div class="font-weight-bold">
                                    <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###"/>đ
                                </div>
                            </div>
                        </c:forEach>

                        <hr>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Tạm tính:</span>
                            <span><fmt:formatNumber value="${totalPrice}" pattern="#,###"/>đ</span>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <span class="text-muted">Phí vận chuyển:</span>
                            <span><fmt:formatNumber value="${shipFee}" pattern="#,###"/>đ</span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between mb-4">
                            <span class="font-weight-bold text-uppercase">Tổng cộng:</span>
                            <span class="font-weight-bold text-danger h4">
                                <fmt:formatNumber value="${totalPrice + shipFee}" pattern="#,###"/>đ
                            </span>
                        </div>

                        <!-- <div class="d-flex mt-2 checkout-btns">
                            <a href="cart" class="checkout-btn btn btn-outline-secondary btn-block py-3 font-weight-bold mr-2">
                                ← Quay lại giỏ hàng
                            </a>
                            <button type="submit" class="checkout-btn btn btn-info btn-block py-3 font-weight-bold ml-2">HOÀN TẤT ĐƠN HÀNG</button>
                        </div> -->

                        <div class="checkout-btns">
                            <a href="cart" class="checkout-btn">Quay lại giỏ hàng</a>
                            <button type="submit" class="checkout-btn submit-btn">Hoàn tất đơn hàng</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</body>
</html>