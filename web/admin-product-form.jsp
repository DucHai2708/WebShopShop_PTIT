<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.shopshop.model.Product"%>
<%@page import="com.shopshop.model.Category"%>
<%@page import="com.shopshop.model.ProductVariant"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%
    com.shopshop.model.Users adminUser = (com.shopshop.model.Users) session.getAttribute("user");
    if (adminUser == null || adminUser.getRole() != 1) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    Product product = (Product) request.getAttribute("product");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    boolean editMode = Boolean.TRUE.equals(request.getAttribute("editMode"));
    // Xây dựng map lưu stock_quantity hiện tại: key = "color|size"
    java.util.Map<String, Integer> variantStockMap = new java.util.HashMap<>();
    if (editMode && product.getVariants() != null) {
        for (com.shopshop.model.ProductVariant pv : product.getVariants()) {
            String key = pv.getColor().toLowerCase() + "|" + pv.getSize().toLowerCase();
            variantStockMap.put(key, pv.getStock_quantity());
        }
    }
%>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><%= editMode ? "Sửa" : "Thêm" %> Sản phẩm — Atino Admin</title>
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
            <h1 class="page-title"><%= editMode ? "Sửa sản phẩm" : "Thêm sản phẩm mới" %></h1>
            <div class="topbar-user">
                <div class="avatar"><%= adminUser.getFullName().substring(0,1).toUpperCase() %></div>
                <span><%= adminUser.getFullName() %></span>
            </div>
        </div>

        <div class="admin-main">
            <div class="admin-form-card">
                <form method="POST" action="products">
                    <input type="hidden" name="action" value="<%= editMode ? "edit" : "add" %>">
                    <% if (editMode) { %>
                    <input type="hidden" name="id" value="<%= product.getId() %>">
                    <% } %>

                    <div class="form-group">
                        <label>Tên sản phẩm <span style="color:#e74c3c">*</span></label>
                        <input type="text" name="name" class="form-control" required
                               value="<%= editMode ? product.getName() : "" %>"
                               placeholder="Vd: Áo Nỉ Fitted L.2.7812">
                    </div>

                    <div class="form-group">
                        <label>URL Hình ảnh <span style="color:#e74c3c">*</span></label>
                        <input type="text" name="image" class="form-control" required
                               value="<%= editMode ? product.getImage() : "" %>"
                               placeholder="Vd: ./assets/images/product1.jpeg" id="imgInput">
                        <small style="color:#888; font-size:12px; margin-top:4px; display:block;">
                            Nhập đường dẫn tương đối hoặc URL ảnh
                        </small>
                        <% if (editMode && product.getImage() != null) { %>
                        <img src="../<%= product.getImage() %>" alt="preview"
                             style="margin-top:10px; height:80px; border-radius:8px; border:1px solid #eee;"
                             onerror="this.style.display='none'" id="imgPreview">
                        <% } else { %>
                        <img id="imgPreview" style="display:none; margin-top:10px; height:80px; border-radius:8px; border:1px solid #eee;">
                        <% } %>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Giá (VNĐ) <span style="color:#e74c3c">*</span></label>
                                <input type="number" name="price" class="form-control" required min="0"
                                       value="<%= editMode ? (long)product.getPrice() : "" %>"
                                       placeholder="Vd: 89000">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Số lượng tồn kho</label>
                                <input type="text" class="form-control" disabled
                                       value="<%= editMode ? product.getQuantity() + " (tự động tính từ biến thể)" : "Sẽ tự tính sau khi chọn biến thể" %>"
                                       style="background:#f0f0f0; color:#888; cursor:not-allowed;">
                                <small style="color:#888; font-size:11px;">Số lượng = Tổng tất cả các biến thể. Không chỉnh sửa trực tiếp.</small>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Danh mục <span style="color:#e74c3c">*</span></label>
                        <select name="category_id" class="form-control" required>
                            <option value="">-- Chọn danh mục --</option>
                            <% if (categories != null) { for (Category c : categories) { %>
                            <option value="<%= c.getId() %>"
                                <%= (editMode && product.getCategory_id() == c.getId()) ? "selected" : "" %>>
                                <%= c.getName() %>
                            </option>
                            <% } } %>
                        </select>
                    </div>

                    <%
                        List<String> currentSizes = new ArrayList<>();
                        List<String> currentColors = new ArrayList<>();
                        if (editMode && product.getVariants() != null) {
                            for (ProductVariant pv : product.getVariants()) {
                                if (pv.getSize() != null && !currentSizes.contains(pv.getSize())) currentSizes.add(pv.getSize());
                                if (pv.getColor() != null && !currentColors.contains(pv.getColor())) currentColors.add(pv.getColor());
                            }
                        }
                    %>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Kích cỡ <span style="color:#e74c3c">*</span> <small>(Chọn ít nhất 1)</small></label>
                                <div style="display:flex; gap:10px; flex-wrap:wrap; margin-top:5px;">
                                    <% String[] allSizes = {"s", "m", "l", "xl", "free size"};
                                       for (String s : allSizes) { %>
                                    <label style="display:flex; align-items:center; gap:5px; margin-bottom:0; font-weight:normal;">
                                        <input type="checkbox" name="sizes" value="<%= s %>" <%= currentSizes.contains(s) ? "checked" : "" %>> 
                                        <span style="text-transform:uppercase;"><%= s %></span>
                                    </label>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Màu sắc <span style="color:#e74c3c">*</span> <small>(Chọn ít nhất 1)</small></label>
                                <div style="display:flex; gap:10px; flex-wrap:wrap; margin-top:5px;">
                                    <% String[] allColors = {"trắng", "đen", "navy", "xanh navy", "xanh rêu", "kem", "nâu", "xanh đậm", "xanh nhạt", "be", "xám"};
                                       for (String c : allColors) { %>
                                    <label style="display:flex; align-items:center; gap:5px; margin-bottom:0; font-weight:normal;">
                                        <input type="checkbox" name="colors" value="<%= c %>" <%= currentColors.contains(c) ? "checked" : "" %>> 
                                        <span style="text-transform:capitalize;"><%= c %></span>
                                    </label>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group" id="variantStockSection" style="margin-top:20px; display:none;">
                        <label><i class="fa-solid fa-table"></i> Số lượng kho theo tổ hợp biến thể <span style="color:#e74c3c">*</span></label>
                        <div style="font-size:12px; color:#888; margin-bottom:8px;">
                            Nhập số lượng tồn kho cho từng tổ hợp Màu × Size. Hệ thống sẽ tự tính tổng.
                        </div>
                        <div id="variantStockTable"></div>
                    </div>

                    <div class="form-group">
                        <label>Mô tả</label>
                        <textarea name="description" class="form-control" rows="4"
                                  placeholder="Mô tả chi tiết sản phẩm..."><%= editMode && product.getDescription() != null ? product.getDescription() : "" %></textarea>
                    </div>

                    <div style="display:flex; gap:12px; margin-top:8px;">
                        <button type="submit" class="btn-admin btn-admin-primary">
                            <i class="fa-solid fa-<%= editMode ? "floppy-disk" : "plus" %>"></i>
                            <%= editMode ? "Lưu thay đổi" : "Thêm sản phẩm" %>
                        </button>
                        <a href="products" class="btn-admin btn-admin-secondary">
                            <i class="fa-solid fa-xmark"></i> Hủy
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    // Dữ liệu tồn kho hiện tại (chế độ sửa)
    const existingStock = {
        <% for (java.util.Map.Entry<String, Integer> entry : variantStockMap.entrySet()) { %>
            "<%= entry.getKey() %>": <%= entry.getValue() %>,
        <% } %>
    };

    // Preview ảnh khi nhập URL
    document.getElementById('imgInput').addEventListener('input', function() {
        var preview = document.getElementById('imgPreview');
        if (this.value) {
            preview.src = '../' + this.value;
            preview.style.display = 'block';
            preview.onerror = function() { this.style.display='none'; };
        } else {
            preview.style.display = 'none';
        }
    });

    // Sinh bảng nhập số lượng kho theo biến thể
    function updateVariantStockTable() {
        const checkedSizes = [...document.querySelectorAll('input[name="sizes"]:checked')].map(el => el.value);
        const checkedColors = [...document.querySelectorAll('input[name="colors"]:checked')].map(el => el.value);
        const section = document.getElementById('variantStockSection');
        const tableDiv = document.getElementById('variantStockTable');

        if (checkedSizes.length === 0 || checkedColors.length === 0) {
            section.style.display = 'none';
            tableDiv.innerHTML = '';
            return;
        }

        section.style.display = 'block';

        // Xây dựng bảng HTML
        let html = '<table class="table table-bordered table-sm" style="background:#fff; font-size:13px;">';
        html += '<thead class="thead-light"><tr><th style="min-width:80px;">Màu / Size</th>';
        for (const size of checkedSizes) {
            html += '<th class="text-center">' + size.toUpperCase() + '</th>';
        }
        html += '</tr></thead><tbody>';

        for (const color of checkedColors) {
            html += '<tr><td class="font-weight-bold" style="text-transform:capitalize;">' + color + '</td>';
            for (const size of checkedSizes) {
                const key = color.toLowerCase() + '|' + size.toLowerCase();
                const currentVal = (existingStock[key] !== undefined) ? existingStock[key] : 0;
                html += '<td><input type="number" name="stockQtys" min="0" value="' + currentVal + '"'
                     +  ' style="width:100%; border:none; text-align:center; font-size:13px; background:transparent;"'
                     +  ' placeholder="0"></td>';
            }
            html += '</tr>';
        }

        html += '</tbody></table>';
        tableDiv.innerHTML = html;
    }

    // Gắn sự kiện cho tất cả checkbox
    document.querySelectorAll('input[name="sizes"], input[name="colors"]').forEach(cb => {
        cb.addEventListener('change', updateVariantStockTable);
    });

    // Gọi ngay khi load (cho chế độ sửa)
    updateVariantStockTable();
</script>
</body>
</html>
