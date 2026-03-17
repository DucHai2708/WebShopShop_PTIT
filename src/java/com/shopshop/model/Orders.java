/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.shopshop.model;
import  java.sql.Timestamp;
/**
 *
 * @author Admin
 */
public class Orders {
    private int id;
    private int user_id;
    private double totalPrice; 
    private String shipName;
    private String shipAddress;
    private String shipPhone;
    private Timestamp orderDate;
    private int status; 
    private String note;
    
    public Orders(){
        
    }

    public Orders(int id, int user_id, double totalPrice, String shipName, String shipAddress, String shipPhone, Timestamp orderDate, int status, String note) {
        this.id = id;
        this.user_id = user_id;
        this.totalPrice = totalPrice;
        this.shipName = shipName;
        this.shipAddress = shipAddress;
        this.shipPhone = shipPhone;
        this.orderDate = orderDate;
        this.status = status;
        this.note = note;
    }

    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getShipName() {
        return shipName;
    }

    public void setShipName(String shipName) {
        this.shipName = shipName;
    }

    public String getShipPhone() {
        return shipPhone;
    }

    public void setShipPhone(String shipPhone) {
        this.shipPhone = shipPhone;
    }

    public String getShipAddress() {
        return shipAddress;
    }

    public void setShipAddress(String shipAddress) {
        this.shipAddress = shipAddress;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
    
    
    
}