# 📦 PROJECT OVERVIEW — WebShopShop_PTIT

> **Cập nhật lần cuối:** 2026-04-09  
> **Mục đích:** Tài liệu tổng quan dự án để tra cứu nhanh cấu trúc, luồng dữ liệu, dependencies và các quy ước code.

---

## 🧰 Công nghệ & Dependencies

| Thành phần | Chi tiết |
|---|---|
| **Ngôn ngữ Backend** | Java (Jakarta EE / Servlet + JSP) |
| **Web Server** | Apache Tomcat |
| **IDE** | NetBeans |
| **Database** | MySQL |
| **Frontend** | HTML, CSS (Vanilla), Bootstrap 5 (CDN) |
| **Font Awesome** | CDN (icons) |

### Thư viện (`/lib`)
| File JAR | Mô tả |
|---|---|
| `jakarta.servlet-api-6.1.0.jar` | Jakarta Servlet API |
| `jakarta.servlet.jsp.jstl-3.0.0.jar` | JSTL cho JSP |
| `jakarta.servlet.jsp.jstl-api-3.0.0.jar` | JSTL API |
| `mysql-connector-j-9.6.0.jar` | JDBC Driver kết nối MySQL |

> ⚠️ **Lưu ý IDE:** Các lỗi lint `"jakarta cannot be resolved"` trong IDE (NetBeans/VSCode) chỉ là **cảnh báo classpath của IDE** — code chạy hoàn toàn bình thường trên Tomcat vì lib đã được cấu hình đúng trong `project.properties`.

---

## 🗄️ Database

- **Tên DB:** `shopshop`
- **Host:** `localhost:3306`
- **User:** `root` / **Password:** `123456`
- **File schema:** `shopshop_db.sql`

### Sơ đồ bảng

```
Category (id, name, description, status, parent_id)
    └── Product (id, name, image, price, description, category_id, quantity)
            └── ProductVariant (id, product_id, color, size, stock_quantity)

Users (id, username, password, fullName, email, phone, address, role)
    └── Orders (id, user_id, totalPrice, shipName, shipAddress, shipPhone, orderDate, status, note)
            └── OrderDetail (id, order_id, variant_id, quantity, price)
```

### Chi tiết bảng quan trọng

**Category**
- `status`: `1` = hiển thị trên menu, `0` = ẩn
- `parent_id`: danh mục con trỏ về ID danh mục cha (NULL nếu là danh mục gốc)
- ID danh mục hiện tại trên header: `1` = Áo thun/Áo nỉ, `2` = Áo xuân hè, `3` = Quần, `4` = Phụ kiện

**Users**
- `role`: `1` = admin, `0` = customer
- Session key: `"user"` → lưu object `Users` sau khi đăng nhập

**Orders**
- `status`: `0` = chờ xác nhận, `1` = đang giao, `2` = hoàn thành, v.v.

---

## 📁 Cấu trúc dự án

```
WebShopShop_PTIT/
├── src/java/com/shopshop/
│   ├── context/
│   │   └── DBContext.java          ← Kết nối JDBC MySQL (kế thừa bởi mọi DAO)
│   ├── model/
│   │   ├── Category.java           ← Model danh mục
│   │   ├── Product.java            ← Model sản phẩm (có List<ProductVariant>)
│   │   ├── ProductVariant.java     ← Model biến thể (màu, size, số lượng)
│   │   ├── Users.java              ← Model người dùng
│   │   ├── Orders.java             ← Model đơn hàng
│   │   ├── OrderDetail.java        ← Model chi tiết đơn hàng
│   │   └── Cart.java               ← Model giỏ hàng (chưa implement)
│   ├── dao/
│   │   ├── CategoryDAO.java        ← CRUD danh mục
│   │   ├── ProductDAO.java         ← CRUD + filter + search sản phẩm
│   │   ├── UsersDAO.java           ← CRUD người dùng
│   │   └── OrdersDAO.java          ← CRUD đơn hàng
│   └── controller/
│       ├── HomeServlet.java        ← GET /home → home.jsp
│       ├── CategoryServlet.java    ← GET /category?id={n} → category.jsp
│       ├── ProductServlet.java     ← GET /product?id={n} → product.jsp
│       ├── SearchServlet.java      ← GET /search?keyword={q} → search.jsp  
│       ├── LoginServlet.java       ← GET+POST /login → login.jsp
│       ├── RegisterServlet.java    ← POST /register → login.jsp
│       └── LogoutServlet.java      ← GET /logout → redirect home
│
├── web/
│   ├── index.jsp                   ← Redirect về /home
│   ├── home.jsp                    ← Trang chủ (4 sản phẩm đầu của category 1)
│   ├── category.jsp                ← Danh sách sản phẩm theo danh mục (động)
│   ├── product.jsp                 ← Chi tiết sản phẩm (màu, size, mô tả)
│   ├── search.jsp                  ← Kết quả tìm kiếm
│   ├── login.jsp                   ← Đăng nhập + Đăng ký (2 tab)
│   ├── admin.jsp                   ← Trang quản trị (chưa hoàn thiện)
│   ├── assets/
│   │   ├── css/
│   │   │   ├── style.css           ← CSS chính: header, footer, home, category
│   │   │   ├── product.css         ← CSS trang chi tiết sản phẩm
│   │   │   ├── search.css          ← CSS trang tìm kiếm
│   │   │   ├── login.css           ← CSS trang đăng nhập
│   │   │   ├── base.css            ← CSS reset/base
│   │   │   └── admin.css           ← CSS admin (chưa hoàn thiện)
│   │   └── images/
│   │       ├── logo.jpg
│   │       ├── slide.jpg
│   │       ├── banner.png
│   │       ├── product1.jpeg       ← Ảnh sản phẩm mặc định (fallback)
│   │       └── product2.jpeg
│   └── WEB-INF/
│       └── web.xml                 ← Đăng ký tất cả Servlet + URL mapping
│
├── shopshop_db.sql                 ← Script tạo database (schema)
├── btl.sql                         ← Script khác (seed data?)
├── databases_model.mwb             ← File MySQL Workbench (ER diagram)
└── PROJECT_OVERVIEW.md             ← File này
```

---

## 🔄 URL Routing (Servlet Mapping)

| URL | Servlet | View (JSP) | Method | Mô tả |
|---|---|---|---|---|
| `/home` | HomeServlet | `home.jsp` | GET | Trang chủ |
| `/category?id={n}` | CategoryServlet | `category.jsp` | GET | Danh sách SP theo danh mục |
| `/product?id={n}` | ProductServlet | `product.jsp` | GET | Chi tiết sản phẩm |
| `/search?keyword={q}` | SearchServlet | `search.jsp` | GET | Tìm kiếm sản phẩm |
| `/login` | LoginServlet | `login.jsp` | GET + POST | Đăng nhập |
| `/register` | RegisterServlet | `login.jsp` | POST | Đăng ký tài khoản |
| `/logout` | LogoutServlet | redirect `/home` | GET | Đăng xuất |

---

## 🏗️ Luồng MVC (Flow)

```
Browser → URL → Servlet (Controller)
                    ↓
              DAO (truy vấn DB)
                    ↓
         request.setAttribute("key", data)
                    ↓
         request.getRequestDispatcher("view.jsp").forward()
                    ↓
              JSP (render HTML)
                    ↓
              HTML → Browser
```

**Ví dụ cụ thể — click vào danh mục "Áo thun":**
1. `href="category?id=1"` → GET request tới `/category?id=1`
2. `CategoryServlet.doGet()` đọc param `id=1`
3. `ProductDAO.getProductByCategoryId(1)` → truy vấn MySQL
4. `CategoryDAO.getCategoryById(1)` → lấy tên danh mục
5. `request.setAttribute("productList", list)` + `request.setAttribute("category", category)`
6. Forward sang `category.jsp`
7. JSP dùng `<% for (Product p : productList) %>` render từng sản phẩm

---

## 🗃️ DAO Methods quan trọng

### ProductDAO
| Method | Mô tả |
|---|---|
| `getAll()` | Lấy tất cả sản phẩm |
| `getProductById(int id)` | Lấy 1 sản phẩm theo ID |
| `getProductByCategoryId(int cid)` | Lấy SP theo danh mục (bao gồm danh mục con) |
| `searchByName(String keyword)` | Tìm kiếm SP theo tên (LIKE) |
| `getProductByPrice(double min, double max)` | Lọc SP theo khoảng giá |
| `insertProduct(Product p)` | Thêm sản phẩm mới, trả về ID |
| `insertVariant(ProductVariant pv)` | Thêm biến thể (màu/size) |
| `updateProduct(Product p)` | Cập nhật sản phẩm |
| `deleteProduct(int id)` | Xóa SP (kèm xóa variants, có transaction) |
| `getVariantProductId(int productId)` | Lấy danh sách biến thể của 1 SP |

### CategoryDAO
| Method | Mô tả |
|---|---|
| `getAll()` | Lấy tất cả danh mục (status=1) |
| `getCategoryById(int id)` | Lấy 1 danh mục theo ID |
| `getChildCategories(int parentId)` | Lấy danh mục con theo ID cha |

### UsersDAO
| Method | Mô tả |
|---|---|
| `checkLogin(String user, String pass)` | Kiểm tra đăng nhập, trả về `Users` hoặc null |
| `register(Users u)` | Đăng ký tài khoản mới |
| *(còn lại xem file)* | |

---

## 🎨 CSS & Giao diện

| File CSS | Áp dụng cho |
|---|---|
| `style.css` | Header, footer, home section, thanh tìm kiếm, slideshow, category-wrap |
| `product.css` | Trang chi tiết sản phẩm: gallery ảnh, bộ chọn màu/size, product info |
| `search.css` | Trang kết quả tìm kiếm |
| `login.css` | Form đăng nhập/đăng ký, tab switcher |
| `base.css` | Reset cơ bản |

**Bootstrap:** Được load qua CDN, dùng cho grid (`col-xl-3`), pagination, form controls, alert.

---

## 🔐 Authentication (Xác thực)

- Sau khi đăng nhập thành công, `Users` object được lưu vào **Session** với key `"user"`
- Mọi trang JSP kiểm tra session bằng:
  ```jsp
  <% com.shopshop.model.Users user = (com.shopshop.model.Users) session.getAttribute("user"); %>
  <% if (user != null) { %> ... Hiển thị tên + nút Đăng xuất <% } else { %> ... Hiển thị nút Đăng nhập <% } %>
  ```
- **Đăng xuất:** `LogoutServlet` gọi `session.invalidate()` rồi redirect về `/home`

---

## ⚠️ Các điểm cần lưu ý

### Lỗi phổ biến đã gặp
1. **Lỗi 500 từ JSP string bị ngắt dòng** — Code formatter (VS Code/NetBeans) tự ngắt chuỗi JSP `<%= condition ? "class1" : "class2" %>` xuống nhiều dòng → Java không cho phép. **Tắt Format On Save** cho file `.jsp`.
2. **Sản phẩm tĩnh (hard-code) trong JSP** — Phải dùng vòng lặp `<% for (Product p : productList) %>` thay vì copy-paste HTML cứng.
3. **Container-fluid lồng nhau** — Đặt `<div class="row">` trực tiếp trong `<div class="row">` không có `container-fluid` bao ngoài sẽ làm margin âm bị nhân đôi, gây tràn layout.
4. **Code Java trong comment HTML** — `<!-- <% ... %> -->` vẫn bị JSP compiler thực thi → dùng `<%-- ... --%>` để comment code Java.

### Tính năng đã làm (✅) / chưa làm (❌)
| Tính năng | Trạng thái |
|---|---|
| Trang chủ (home.jsp) | ✅ Động, lấy 4 SP từ category 1 |
| Danh mục sản phẩm (category.jsp) | ✅ Động theo `?id=`, link đến product detail |
| Chi tiết sản phẩm (product.jsp) | ✅ Hiển thị thông tin, màu, size |
| Tìm kiếm (search.jsp) | ✅ Tìm theo keyword, hiển thị grid |
| Đăng nhập / Đăng ký | ✅ Session-based auth |
| Đăng xuất | ✅ |
| Giỏ hàng | ❌ Chưa implement (model Cart có nhưng chưa dùng) |
| Thanh toán | ❌ Chưa implement |
| Trang Admin | ❌ Chưa implement |
| Bộ lọc sản phẩm (filter) | ❌ UI có nhưng logic chưa implement |
| Phân trang (pagination) | ❌ UI có nhưng logic chưa implement |
| Đặt hàng | ❌ Chưa implement (DAO có sẵn) |
