import sys

with open('web/search.jsp', 'r', encoding='utf-8') as f:
    lines = f.readlines()

new_content = '''                        <% // L?y l?i danh sách ð? ch?n ð? gi? tr?ng thái
                            String[] selectedPrices = (String[]) request.getAttribute("priceRanges");
                            java.util.List<String> priceList = (selectedPrices != null) ? java.util.Arrays.asList(selectedPrices) : new java.util.ArrayList<String>();

                            String[] selectedSizes = (String[]) request.getAttribute("sizes");
                            java.util.List<String> sizeList = (selectedSizes != null) ? java.util.Arrays.asList(selectedSizes) : new java.util.ArrayList<String>();

                            String[] selectedColors = (String[]) request.getAttribute("colors");
                            java.util.List<String> colorList = (selectedColors != null) ? java.util.Arrays.asList(selectedColors) : new java.util.ArrayList<String>();
                        %>
                        <div class="filter-wrap">
                            <form action="search" method="GET" id="filterForm">
                                <input type="hidden" name="keyword" value="<%= searchKw != null ? searchKw : "" %>">
                                <div class="filter-header">
                                    <span class="filter-label">B? l?c</span>
                                    <div class="filter-item"> Kích c? <i class="fa-solid fa-caret-down"></i> </div>
                                    <div class="filter-item"> Màu s?c <i class="fa-solid fa-caret-down"></i> </div>
                                    <div class="filter-item"> Kho?ng giá <i class="fa-solid fa-caret-down"></i> </div>
                                </div>
                                <div class="filter-dropdown">
                                    <div class="row">
                                        <div class="col-xl-4" style="border-right: 1px solid #eee;">
                                            <strong style="display:block; margin-bottom:10px;">Kích c?</strong>
                                            <ul class="filter-list" style="max-height: 200px; overflow-y: auto;">
                                                <% String[] allSizes = {"s", "m", "l", "xl", "free size"};
                                                                        for (String s : allSizes) {%>
                                                <li><input type="checkbox" name="size" value="<%= s%>" id="size-<%= s.replaceAll(" ", "")%>" <%= sizeList.contains(s) ? "checked" : ""%>>
                                                    <label for="size-<%= s.replaceAll(" ", "")%>" style="text-transform: uppercase;"><%= s%></label></li>
                                                    <% } %>
                                            </ul>
                                        </div>
                                        <div class="col-xl-4" style="border-right: 1px solid #eee;">
                                            <strong style="display:block; margin-bottom:10px;">Màu s?c</strong>
                                            <ul class="filter-list" style="max-height: 200px; overflow-y: auto;">
                                                <% String[] allColors = {"tr?ng", "ðen", "navy", "xanh navy", "xanh rêu", "kem", "nâu", "xanh ð?m", "xanh nh?t", "be", "xám"};
                                                                        for (int i = 0; i < allColors.length; i++) {
                                                                            String c = allColors[i];%>
                                                <li><input type="checkbox" name="color" value="<%= c%>" id="color-<%= i%>" <%= colorList.contains(c) ? "checked" : ""%>>
                                                    <label for="color-<%= i%>" style="text-transform: capitalize;"><%= c%></label></li>
                                                    <% }%>
                                            </ul>
                                        </div>
                                        <div class="col-xl-4">
                                            <strong style="display:block; margin-bottom:10px;">Kho?ng giá</strong>
                                            <ul class="filter-list">
                                                <li><input type="checkbox" name="price" value="1" id="price-1" <%= priceList.contains("1") ? "checked" : ""%>>
                                                    <label for="price-1">Dý?i 200,000</label></li>
                                                <li><input type="checkbox" name="price" value="2" id="price-2" <%= priceList.contains("2") ? "checked" : ""%>>
                                                    <label for="price-2">T? 200,000 - 500k</label></li>
                                                <li><input type="checkbox" name="price" value="3" id="price-3" <%= priceList.contains("3") ? "checked" : ""%>>
                                                    <label for="price-3">T? 500,000 - 1Tr</label></li>
                                                <li><input type="checkbox" name="price" value="4" id="price-4" <%= priceList.contains("4") ? "checked" : ""%>>
                                                    <label for="price-4">Trên 1,000,000</label></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div style="margin-top: 20px;">
                                        <button type="submit" class="filter-btn">L?c</button>
                                        <% if (!priceList.isEmpty() || !sizeList.isEmpty() || !colorList.isEmpty()) {%>
                                        <a href="search?keyword=<%= searchKw != null ? searchKw : "" %>" class="filter-btn" style="background:#888; margin-left:8px; text-decoration:none;">B? l?c</a>
                                        <% } %>
                                    </div>
                                </div>
                            </form>
                        </div>
'''

new_lines = lines[:218] + [new_content + '\n'] + lines[393:]
with open('web/search.jsp', 'w', encoding='utf-8') as f:
    f.writelines(new_lines)
print('Done!')
