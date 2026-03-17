
package com.shopshop.model;


public class Category {
    private int id;
    private String name;
    private String description;
    private int status; // 1: hiện trên menu | 0: ẩn khỏi menu
    private int parent_id;

    public Category() {
        
    }

    public Category(int id, String name, String description, int status, int parent_id) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.status = status;
        this.parent_id = parent_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getParent_id() {
        return parent_id;
    }

    public void setParent_id(int parent_id) {
        this.parent_id = parent_id;
    }
    
    
    
}
