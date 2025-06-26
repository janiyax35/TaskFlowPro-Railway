package com.todolist.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * TaskFlow Pro - Railway Database Connection
 * Author: IT24102137
 * Date: 2025-06-26 19:15:51
 */
public class DatabaseConnection {
    
    // Railway MySQL Configuration
    private static final String DB_URL = System.getenv("DATABASE_URL") != null ? 
        System.getenv("DATABASE_URL") : "jdbc:mysql://localhost:3306/todolist_db";
    private static final String DB_USERNAME = System.getenv("MYSQLUSER") != null ? 
        System.getenv("MYSQLUSER") : "root";
    private static final String DB_PASSWORD = System.getenv("MYSQLPASSWORD") != null ? 
        System.getenv("MYSQLPASSWORD") : "Mmtt@5791";
    private static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";
    
    // Railway specific configurations
    private static final String RAILWAY_DB_HOST = System.getenv("MYSQLHOST");
    private static final String RAILWAY_DB_PORT = System.getenv("MYSQLPORT");
    private static final String RAILWAY_DB_NAME = System.getenv("MYSQLDATABASE");
    
    static {
        try {
            Class.forName(DB_DRIVER);
            System.out.println("=== TaskFlow Pro Railway Deployment ===");
            System.out.println("MySQL JDBC Driver loaded successfully");
            System.out.println("Current User: IT24102137");
            System.out.println("Build Time: 2025-06-26 19:15:51");
            System.out.println("Environment: " + (System.getenv("RAILWAY_ENVIRONMENT") != null ? "Railway Cloud" : "Local"));
            
            if (RAILWAY_DB_HOST != null) {
                System.out.println("Railway MySQL Host: " + RAILWAY_DB_HOST);
                System.out.println("Railway MySQL Port: " + RAILWAY_DB_PORT);
                System.out.println("Railway MySQL Database: " + RAILWAY_DB_NAME);
            }
            System.out.println("=======================================");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found!");
            e.printStackTrace();
        }
    }
    
    /**
     * Get Railway-optimized database connection
     */
    public static Connection getConnection() throws SQLException {
        try {
            String connectionUrl = DB_URL;
            
            // Build Railway connection URL if environment variables exist
            if (RAILWAY_DB_HOST != null && RAILWAY_DB_PORT != null && RAILWAY_DB_NAME != null) {
                connectionUrl = String.format(
                    "jdbc:mysql://%s:%s/%s?useSSL=true&serverTimezone=UTC&allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF-8",
                    RAILWAY_DB_HOST, RAILWAY_DB_PORT, RAILWAY_DB_NAME
                );
            }
            
            Connection connection = DriverManager.getConnection(connectionUrl, DB_USERNAME, DB_PASSWORD);
            
            // Configure connection for Railway
            connection.setAutoCommit(true);
            connection.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);
            
            // Test connection
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT 'TaskFlow Pro Connected!' as message, NOW() as server_time");
            if (rs.next()) {
                System.out.println("✅ Railway Database Connected: " + rs.getString("message"));
                System.out.println("✅ Server Time: " + rs.getString("server_time"));
                System.out.println("✅ User: IT24102137");
            }
            rs.close();
            stmt.close();
            
            return connection;
            
        } catch (SQLException e) {
            System.err.println("❌ Railway Database Connection Failed!");
            System.err.println("Error Code: " + e.getErrorCode());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Message: " + e.getMessage());
            
            // Railway-specific error handling
            if (e.getMessage().contains("Access denied")) {
                System.err.println("SOLUTION: Check Railway MySQL credentials");
            } else if (e.getMessage().contains("Unknown database")) {
                System.err.println("SOLUTION: Ensure Railway MySQL database is created");
            } else if (e.getMessage().contains("Connection refused")) {
                System.err.println("SOLUTION: Verify Railway MySQL service is running");
            }
            
            throw e;
        }
    }
    
    // Rest of the methods remain the same...
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                if (!connection.isClosed()) {
                    connection.close();
                    System.out.println("Railway database connection closed successfully");
                }
            } catch (SQLException e) {
                System.err.println("Error closing Railway database connection: " + e.getMessage());
            }
        }
    }
    
    public static void closeConnection(ResultSet resultSet, PreparedStatement statement, Connection connection) {
        if (resultSet != null) {
            try { resultSet.close(); } catch (SQLException e) { /* ignore */ }
        }
        if (statement != null) {
            try { statement.close(); } catch (SQLException e) { /* ignore */ }
        }
        closeConnection(connection);
    }
    
    public static void closeConnection(ResultSet resultSet, Statement statement, Connection connection) {
        if (resultSet != null) {
            try { resultSet.close(); } catch (SQLException e) { /* ignore */ }
        }
        if (statement != null) {
            try { statement.close(); } catch (SQLException e) { /* ignore */ }
        }
        closeConnection(connection);
    }
}