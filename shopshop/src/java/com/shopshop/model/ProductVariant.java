/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.shopshop.model;

/**
 *
 * @author Admin
 */
public class ProductVariant {
    private int id;
    private int product_id;
    private String color;
    private String size;
    private int stock_quantity;

    public ProductVariant() {
    }

    public ProductVariant(int id, int product_id, String color, String size, int stock_quantity) {
        this.id = id;
        this.product_id = product_id;
        this.color = color;
        this.size = size;
        this.stock_quantity = stock_quantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
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

    public int getStock_quantity() {
        return stock_quantity;
    }

    public void setStock_quantity(int stock_quantity) {
        this.stock_quantity = stock_quantity;
    }
    
    
}
