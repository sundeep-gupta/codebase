/*
 * Copyright (C) 2010 Bubble Inc., All Rights Reserved
 */

package com.bubble.tiffinbox.model;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author bubble
 * @version 1.0
 */
public class DBConnectionFactory {
    private static Connection conn = null;
    private static String DRIVER_CLASS_NAME = "com.mysql.jdbc.Driver";
    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        if (conn != null) {
            return conn;
        }
        // Loaded drivers
        Class.forName(DRIVER_CLASS_NAME);
        // Establish a database connection
        String url = "jdbc:mysql://localhost:3306/test";
        conn = DriverManager.getConnection(url, "root", "");

        return conn;
    }
}
