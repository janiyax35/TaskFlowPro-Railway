package com.todolist.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.todolist.db.DatabaseConnection;
import com.todolist.model.Todo;

/**
 * TaskFlow Pro - Todo AJAX Servlet
 * Handles all AJAX operations for todo management
 * Author: IT24102137
 * Date: 2025-06-26 18:14:23
 */
@WebServlet("/TodoAjaxServlet")
public class TodoAjaxServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DEFAULT_USER_ID = "IT24102137";
    
    public TodoAjaxServlet() {
        super();
    }

    /**
     * Handle GET requests - List todos
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-cache");
        
        PrintWriter out = response.getWriter();
        
        try {
            String action = request.getParameter("action");
            String userId = request.getParameter("userId");
            
            if (userId == null || userId.trim().isEmpty()) {
                userId = DEFAULT_USER_ID;
            }
            
            if ("list".equals(action) || action == null) {
                List<Todo> todos = getAllTodos(userId);
                String jsonResponse = buildTodosListResponse(todos, true, "Todos loaded successfully");
                out.print(jsonResponse);
            } else {
                String errorResponse = buildErrorResponse("Invalid action parameter");
                out.print(errorResponse);
            }
            
        } catch (Exception e) {
            System.err.println("Error in doGet: " + e.getMessage());
            e.printStackTrace();
            String errorResponse = buildErrorResponse("Failed to load todos: " + e.getMessage());
            out.print(errorResponse);
        } finally {
            out.flush();
            out.close();
        }
    }

    /**
     * Handle POST requests - Add new todo
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-cache");
        
        PrintWriter out = response.getWriter();
        
        try {
            // Read JSON from request body
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
            
            String jsonData = sb.toString();
            System.out.println("Received JSON: " + jsonData);
            
            // Parse JSON manually (simple parsing)
            Todo todo = parseJsonToTodo(jsonData);
            
            if (todo.getUserId() == null || todo.getUserId().trim().isEmpty()) {
                todo.setUserId(DEFAULT_USER_ID);
            }
            
            // Validate required fields
            if (todo.getTitle() == null || todo.getTitle().trim().isEmpty()) {
                String errorResponse = buildErrorResponse("Title is required");
                out.print(errorResponse);
                return;
            }
            
            // Add todo to database
            boolean success = addTodo(todo);
            
            if (success) {
                String successResponse = buildSimpleResponse(true, "Task added successfully!");
                out.print(successResponse);
            } else {
                String errorResponse = buildErrorResponse("Failed to add task");
                out.print(errorResponse);
            }
            
        } catch (Exception e) {
            System.err.println("Error in doPost: " + e.getMessage());
            e.printStackTrace();
            String errorResponse = buildErrorResponse("Failed to add task: " + e.getMessage());
            out.print(errorResponse);
        } finally {
            out.flush();
            out.close();
        }
    }

    /**
     * Handle PUT requests - Update todo
     */
    protected void doPut(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-cache");
        
        PrintWriter out = response.getWriter();
        
        try {
            // Read JSON from request body
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
            
            String jsonData = sb.toString();
            System.out.println("Received PUT JSON: " + jsonData);
            
            // Parse action from JSON
            String action = extractValueFromJson(jsonData, "action");
            String todoIdStr = extractValueFromJson(jsonData, "todoId");
            String userId = extractValueFromJson(jsonData, "userId");
            
            if (userId == null || userId.trim().isEmpty()) {
                userId = DEFAULT_USER_ID;
            }
            
            if (todoIdStr == null || todoIdStr.trim().isEmpty()) {
                String errorResponse = buildErrorResponse("Todo ID is required");
                out.print(errorResponse);
                return;
            }
            
            int todoId = Integer.parseInt(todoIdStr);
            boolean success = false;
            String message = "";
            
            if ("updateStatus".equals(action)) {
                String status = extractValueFromJson(jsonData, "status");
                success = updateTodoStatus(todoId, status, userId);
                message = success ? "Status updated successfully!" : "Failed to update status";
                
            } else if ("updatePriority".equals(action)) {
                String priority = extractValueFromJson(jsonData, "priority");
                success = updateTodoPriority(todoId, priority, userId);
                message = success ? "Priority updated successfully!" : "Failed to update priority";
                
            } else {
                String errorResponse = buildErrorResponse("Invalid update action");
                out.print(errorResponse);
                return;
            }
            
            if (success) {
                String successResponse = buildSimpleResponse(true, message);
                out.print(successResponse);
            } else {
                String errorResponse = buildErrorResponse(message);
                out.print(errorResponse);
            }
            
        } catch (Exception e) {
            System.err.println("Error in doPut: " + e.getMessage());
            e.printStackTrace();
            String errorResponse = buildErrorResponse("Failed to update task: " + e.getMessage());
            out.print(errorResponse);
        } finally {
            out.flush();
            out.close();
        }
    }

    /**
     * Handle DELETE requests - Delete todo
     */
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-cache");
        
        PrintWriter out = response.getWriter();
        
        try {
            // Read JSON from request body
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
            
            String jsonData = sb.toString();
            System.out.println("Received DELETE JSON: " + jsonData);
            
            String todoIdStr = extractValueFromJson(jsonData, "todoId");
            String userId = extractValueFromJson(jsonData, "userId");
            
            if (userId == null || userId.trim().isEmpty()) {
                userId = DEFAULT_USER_ID;
            }
            
            if (todoIdStr == null || todoIdStr.trim().isEmpty()) {
                String errorResponse = buildErrorResponse("Todo ID is required");
                out.print(errorResponse);
                return;
            }
            
            int todoId = Integer.parseInt(todoIdStr);
            boolean success = deleteTodo(todoId, userId);
            
            if (success) {
                String successResponse = buildSimpleResponse(true, "Task deleted successfully!");
                out.print(successResponse);
            } else {
                String errorResponse = buildErrorResponse("Failed to delete task");
                out.print(errorResponse);
            }
            
        } catch (Exception e) {
            System.err.println("Error in doDelete: " + e.getMessage());
            e.printStackTrace();
            String errorResponse = buildErrorResponse("Failed to delete task: " + e.getMessage());
            out.print(errorResponse);
        } finally {
            out.flush();
            out.close();
        }
    }

    /**
     * Get all todos for a user
     */
    private List<Todo> getAllTodos(String userId) throws SQLException {
        List<Todo> todos = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM todos WHERE user_id = ? ORDER BY created_date DESC";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userId);
            
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Todo todo = new Todo();
                todo.setId(rs.getInt("id"));
                todo.setTitle(rs.getString("title"));
                todo.setDescription(rs.getString("description"));
                todo.setStatus(rs.getString("status"));
                todo.setPriority(rs.getString("priority"));
                
                // Handle date fields
                if (rs.getDate("due_date") != null) {
                    todo.setDueDate(rs.getDate("due_date").toString());
                }
                
                if (rs.getTimestamp("created_date") != null) {
                    todo.setCreatedDate(formatTimestamp(rs.getTimestamp("created_date")));
                }
                
                if (rs.getTimestamp("updated_date") != null) {
                    todo.setUpdatedDate(formatTimestamp(rs.getTimestamp("updated_date")));
                }
                
                todo.setUserId(rs.getString("user_id"));
                todos.add(todo);
            }
            
        } finally {
            DatabaseConnection.closeConnection(rs, stmt, conn);
        }
        
        return todos;
    }

    /**
     * Add new todo
     */
    private boolean addTodo(Todo todo) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO todos (title, description, status, priority, due_date, user_id, created_date, updated_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, todo.getTitle());
            stmt.setString(2, todo.getDescription());
            stmt.setString(3, todo.getStatus() != null ? todo.getStatus() : "pending");
            stmt.setString(4, todo.getPriority() != null ? todo.getPriority() : "medium");
            
            if (todo.getDueDate() != null && !todo.getDueDate().trim().isEmpty()) {
                stmt.setString(5, todo.getDueDate());
            } else {
                stmt.setNull(5, java.sql.Types.DATE);
            }
            
            stmt.setString(6, todo.getUserId());
            
            Timestamp now = Timestamp.valueOf(LocalDateTime.now());
            stmt.setTimestamp(7, now);
            stmt.setTimestamp(8, now);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } finally {
            DatabaseConnection.closeConnection(null, stmt, conn);
        }
    }

    /**
     * Update todo status
     */
    private boolean updateTodoStatus(int todoId, String status, String userId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE todos SET status = ?, updated_date = ? WHERE id = ? AND user_id = ?";
            stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, status);
            stmt.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setInt(3, todoId);
            stmt.setString(4, userId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } finally {
            DatabaseConnection.closeConnection(null, stmt, conn);
        }
    }

    /**
     * Update todo priority
     */
    private boolean updateTodoPriority(int todoId, String priority, String userId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE todos SET priority = ?, updated_date = ? WHERE id = ? AND user_id = ?";
            stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, priority);
            stmt.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setInt(3, todoId);
            stmt.setString(4, userId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } finally {
            DatabaseConnection.closeConnection(null, stmt, conn);
        }
    }

    /**
     * Delete todo
     */
    private boolean deleteTodo(int todoId, String userId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "DELETE FROM todos WHERE id = ? AND user_id = ?";
            stmt = conn.prepareStatement(sql);
            
            stmt.setInt(1, todoId);
            stmt.setString(2, userId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } finally {
            DatabaseConnection.closeConnection(null, stmt, conn);
        }
    }

    /**
     * Parse JSON to Todo object (simple manual parsing)
     */
    private Todo parseJsonToTodo(String json) {
        Todo todo = new Todo();
        
        todo.setTitle(extractValueFromJson(json, "title"));
        todo.setDescription(extractValueFromJson(json, "description"));
        todo.setStatus(extractValueFromJson(json, "status"));
        todo.setPriority(extractValueFromJson(json, "priority"));
        todo.setDueDate(extractValueFromJson(json, "dueDate"));
        todo.setUserId(extractValueFromJson(json, "userId"));
        
        return todo;
    }

    /**
     * Extract value from JSON string (simple manual extraction)
     */
    private String extractValueFromJson(String json, String key) {
        try {
            String searchKey = "\"" + key + "\"";
            int keyIndex = json.indexOf(searchKey);
            
            if (keyIndex == -1) {
                return null;
            }
            
            int colonIndex = json.indexOf(":", keyIndex);
            if (colonIndex == -1) {
                return null;
            }
            
            int valueStart = colonIndex + 1;
            while (valueStart < json.length() && (json.charAt(valueStart) == ' ' || json.charAt(valueStart) == '\t')) {
                valueStart++;
            }
            
            if (valueStart >= json.length()) {
                return null;
            }
            
            char startChar = json.charAt(valueStart);
            int valueEnd;
            
            if (startChar == '"') {
                // String value
                valueStart++; // Skip opening quote
                valueEnd = json.indexOf("\"", valueStart);
                if (valueEnd == -1) {
                    return null;
                }
                return json.substring(valueStart, valueEnd);
            } else {
                // Non-string value (number, boolean, null)
                valueEnd = json.indexOf(",", valueStart);
                if (valueEnd == -1) {
                    valueEnd = json.indexOf("}", valueStart);
                }
                if (valueEnd == -1) {
                    valueEnd = json.length();
                }
                
                String value = json.substring(valueStart, valueEnd).trim();
                if ("null".equals(value)) {
                    return null;
                }
                return value;
            }
        } catch (Exception e) {
            System.err.println("Error extracting " + key + " from JSON: " + e.getMessage());
            return null;
        }
    }

    /**
     * Build JSON response for todos list
     */
    private String buildTodosListResponse(List<Todo> todos, boolean success, String message) {
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"success\": ").append(success).append(",");
        json.append("\"message\": \"").append(escapeJson(message)).append("\",");
        json.append("\"todos\": [");
        
        for (int i = 0; i < todos.size(); i++) {
            if (i > 0) {
                json.append(",");
            }
            json.append(todoToJson(todos.get(i)));
        }
        
        json.append("]}");
        return json.toString();
    }

    /**
     * Build simple JSON response
     */
    private String buildSimpleResponse(boolean success, String message) {
        return "{\"success\": " + success + ", \"message\": \"" + escapeJson(message) + "\"}";
    }

    /**
     * Build error JSON response
     */
    private String buildErrorResponse(String message) {
        return "{\"success\": false, \"message\": \"" + escapeJson(message) + "\"}";
    }

    /**
     * Convert Todo object to JSON string
     */
    private String todoToJson(Todo todo) {
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"id\": ").append(todo.getId()).append(",");
        json.append("\"title\": \"").append(escapeJson(todo.getTitle())).append("\",");
        json.append("\"description\": \"").append(escapeJson(todo.getDescription())).append("\",");
        json.append("\"status\": \"").append(escapeJson(todo.getStatus())).append("\",");
        json.append("\"priority\": \"").append(escapeJson(todo.getPriority())).append("\",");
        json.append("\"dueDate\": ").append(todo.getDueDate() != null ? "\"" + escapeJson(todo.getDueDate()) + "\"" : "null").append(",");
        json.append("\"createdDate\": \"").append(escapeJson(todo.getCreatedDate())).append("\",");
        json.append("\"updatedDate\": \"").append(escapeJson(todo.getUpdatedDate())).append("\",");
        json.append("\"userId\": \"").append(escapeJson(todo.getUserId())).append("\"");
        json.append("}");
        return json.toString();
    }

    /**
     * Escape JSON special characters
     */
    private String escapeJson(String str) {
        if (str == null) {
            return "";
        }
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\b", "\\b")
                  .replace("\f", "\\f")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }

    /**
     * Format timestamp to string
     */
    private String formatTimestamp(Timestamp timestamp) {
        if (timestamp == null) {
            return "";
        }
        LocalDateTime ldt = timestamp.toLocalDateTime();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return ldt.format(formatter);
    }
}