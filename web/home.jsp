<%-- 
    Document   : home
    Created on : Mar 24, 2026, 10:31:52 AM
    Author     : Admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ATINO</title>
        <link rel="stylesheet" href="assets/css/style.css">
    </head>
    <body>
        <header class="header">
            <div class="top-bar">
                <div class="top-bar-left">
                    <span><i class="fa fa-phone"></i> 0986.19.9732</span>
                </div>
                <div class="top-bar-right">
                    <a href="#"><i class="fa fa-user"></i> Tài khoản</a>
                    <a href="#"><i class="fa fa-shopping-bag"></i> Giỏ hàng (0)</a>
                </div>
            </div>

            <div class="main-header">
                <div class="logo">Atino</div>
                
                <div class="menu-container">
                    <ul class="menu">
                        <li><a href="#">Trang chủ</a></li>

                        <li class="dropdown">
                            <a href="#">Áo Thu Đông</a>
                            <ul class="submenu">
                                <c:forEach var="p" items="${winter}">
                                    <li><a href="category?id=${p.id}">${p.name}</a></li>
                                </c:forEach>
                            </ul>
                        </li>

                        <li class="dropdown">
                            <a href="#">Áo Xuân Hè</a>
                            <ul class="submenu"> 
                                <c:forEach var="p" items="${summer}">
                                    <li><a href="category?id=${p.id}">${p.name}</a></li>
                                </c:forEach>    
                            </ul>
                        </li>

                        <li class="dropdown">
                            <a href="#">Quần</a>
                            <ul class="submenu">
                                <c:forEach var="p" items="${pant}">
                                    <li><a href="category?id=${p.id}">${p.name}</a></li>
                                </c:forEach>  
                            </ul>
                        </li>

                        <li class="dropdown">
                            <a href="#">Phụ kiện</a>
                            <ul class="submenu">
                                <c:forEach var="p" items="${accessories}">
                                    <li><a href="category?id=${p.id}">${p.name}</a></li>
                                </c:forEach>
                            </ul>
                        </li>
                    </ul>
                </div>

                <div class="search-bar">
                    <input type="text" class="search-input" placeholder="Tìm kiếm...">
                    <i class="fa fa-search search-icon"></i>
                </div>
            </div>
        </header>
        <div class = "hero-section"></div>
    </body>
</html>
