
package com.shopshop.context;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {
    
    private final String serverName = "localhost";
    private final String dbName = "shopshop";
    private final String portNumber = "3306";
    private final String userId = "root";
    private final String password = "123456";
    
    public Connection getConnection() throws Exception {
        String url = "jdbc:mysql://" + serverName + ":" + portNumber + "/" + dbName;
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url,userId,password);
    }
    
    public static void main(String[] args) {
        try {
            DBContext dbc = new DBContext();
            if (dbc.getConnection() != null) {
                System.out.println("Ket noi thanh cong");
            }
        } catch(Exception e) {
            System.out.println("Loi: " + e.getMessage());
        }
    }
    
}
