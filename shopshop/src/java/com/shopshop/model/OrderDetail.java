/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.shopshop.model;

/**
 *
 * @author Admin
 */
public class OrderDetail {
    private int id;
    private int order_id;
    private int variant_id;
    private int quantity;
    private double price;
    // Ba biến này chỉ dùng để phục vụ hiển thị nên k cần lưu vào database
    private String productName;
    private String color;
    private String size;
    
    public OrderDetail(){
        
    }

    public OrderDetail(int id, int order_id, int variant_id, int quantity, double price) {
        this.id = id;
        this.order_id = order_id;
        this.variant_id = variant_id;
        this.quantity = quantity;
        this.price = price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getVariant_id() {
        return variant_id;
    }

    public void setVariant_id(int variant_id) {
        this.variant_id = variant_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    
    // getter/setter để phục vụ OrderDetailDAO

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }
    
    
}
