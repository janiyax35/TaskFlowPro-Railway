package com.todolist.model;

import java.io.Serializable;

/**
 * TaskFlow Pro - Todo Model Class
 * Simple POJO/Bean for Todo entities
 * Author: IT24102137
 * Date: 2025-06-26 18:15:36
 */
public class Todo implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    // Primary key
    private int id;
    
    // Required fields
    private String title;
    private String description;
    
    // Status and priority
    private String status;        // "pending" or "completed"
    private String priority;      // "low", "medium", or "high"
    
    // Date fields (String format for easy JSON handling)
    private String dueDate;       // YYYY-MM-DD format
    private String createdDate;   // YYYY-MM-DD HH:MM:SS format
    private String updatedDate;   // YYYY-MM-DD HH:MM:SS format
    
    // User association
    private String userId;        // Default: "IT24102137"
    
    /**
     * Default constructor
     */
    public Todo() {
        this.status = "pending";
        this.priority = "medium";
        this.userId = "IT24102137";
    }
    
    /**
     * Constructor with required fields
     */
    public Todo(String title, String description) {
        this();
        this.title = title;
        this.description = description;
    }
    
    /**
     * Constructor with all fields
     */
    public Todo(int id, String title, String description, String status, 
                String priority, String dueDate, String createdDate, 
                String updatedDate, String userId) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.status = status != null ? status : "pending";
        this.priority = priority != null ? priority : "medium";
        this.dueDate = dueDate;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
        this.userId = userId != null ? userId : "IT24102137";
    }
    
    // Getter and Setter methods
    
    /**
     * Get todo ID
     */
    public int getId() {
        return id;
    }
    
    /**
     * Set todo ID
     */
    public void setId(int id) {
        this.id = id;
    }
    
    /**
     * Get todo title
     */
    public String getTitle() {
        return title;
    }
    
    /**
     * Set todo title
     */
    public void setTitle(String title) {
        this.title = title != null ? title.trim() : null;
    }
    
    /**
     * Get todo description
     */
    public String getDescription() {
        return description;
    }
    
    /**
     * Set todo description
     */
    public void setDescription(String description) {
        this.description = description != null ? description.trim() : null;
    }
    
    /**
     * Get todo status
     */
    public String getStatus() {
        return status;
    }
    
    /**
     * Set todo status
     */
    public void setStatus(String status) {
        if (status != null && (status.equals("pending") || status.equals("completed"))) {
            this.status = status;
        } else {
            this.status = "pending"; // Default fallback
        }
    }
    
    /**
     * Get todo priority
     */
    public String getPriority() {
        return priority;
    }
    
    /**
     * Set todo priority
     */
    public void setPriority(String priority) {
        if (priority != null && (priority.equals("low") || priority.equals("medium") || priority.equals("high"))) {
            this.priority = priority;
        } else {
            this.priority = "medium"; // Default fallback
        }
    }
    
    /**
     * Get due date
     */
    public String getDueDate() {
        return dueDate;
    }
    
    /**
     * Set due date (YYYY-MM-DD format)
     */
    public void setDueDate(String dueDate) {
        this.dueDate = dueDate != null && !dueDate.trim().isEmpty() ? dueDate.trim() : null;
    }
    
    /**
     * Get created date
     */
    public String getCreatedDate() {
        return createdDate;
    }
    
    /**
     * Set created date (YYYY-MM-DD HH:MM:SS format)
     */
    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }
    
    /**
     * Get updated date
     */
    public String getUpdatedDate() {
        return updatedDate;
    }
    
    /**
     * Set updated date (YYYY-MM-DD HH:MM:SS format)
     */
    public void setUpdatedDate(String updatedDate) {
        this.updatedDate = updatedDate;
    }
    
    /**
     * Get user ID
     */
    public String getUserId() {
        return userId;
    }
    
    /**
     * Set user ID
     */
    public void setUserId(String userId) {
        this.userId = userId != null && !userId.trim().isEmpty() ? userId.trim() : "IT24102137";
    }
    
    // Utility methods
    
    /**
     * Check if todo is completed
     */
    public boolean isCompleted() {
        return "completed".equals(this.status);
    }
    
    /**
     * Check if todo is pending
     */
    public boolean isPending() {
        return "pending".equals(this.status);
    }
    
    /**
     * Check if todo is high priority
     */
    public boolean isHighPriority() {
        return "high".equals(this.priority);
    }
    
    /**
     * Check if todo is medium priority
     */
    public boolean isMediumPriority() {
        return "medium".equals(this.priority);
    }
    
    /**
     * Check if todo is low priority
     */
    public boolean isLowPriority() {
        return "low".equals(this.priority);
    }
    
    /**
     * Check if todo has due date
     */
    public boolean hasDueDate() {
        return dueDate != null && !dueDate.trim().isEmpty();
    }
    
    /**
     * Check if title is valid (not null/empty)
     */
    public boolean isValidTitle() {
        return title != null && !title.trim().isEmpty();
    }
    
    /**
     * Get priority level as integer (for sorting)
     * High = 3, Medium = 2, Low = 1
     */
    public int getPriorityLevel() {
        switch (this.priority) {
            case "high":
                return 3;
            case "medium":
                return 2;
            case "low":
                return 1;
            default:
                return 2; // Default to medium
        }
    }
    
    /**
     * Get formatted display title (truncated if too long)
     */
    public String getDisplayTitle() {
        if (title == null) return "";
        return title.length() > 50 ? title.substring(0, 47) + "..." : title;
    }
    
    /**
     * Get formatted display description (truncated if too long)
     */
    public String getDisplayDescription() {
        if (description == null || description.trim().isEmpty()) {
            return "No description";
        }
        return description.length() > 100 ? description.substring(0, 97) + "..." : description;
    }
    
    /**
     * Validate todo data
     */
    public boolean isValid() {
        // Title is required
        if (title == null || title.trim().isEmpty()) {
            return false;
        }
        
        // Title length check
        if (title.length() > 255) {
            return false;
        }
        
        // Description length check (if provided)
        if (description != null && description.length() > 500) {
            return false;
        }
        
        // Status validation
        if (status != null && !status.equals("pending") && !status.equals("completed")) {
            return false;
        }
        
        // Priority validation
        if (priority != null && !priority.equals("low") && !priority.equals("medium") && !priority.equals("high")) {
            return false;
        }
        
        return true;
    }
    
    /**
     * Get validation errors
     */
    public String getValidationErrors() {
        StringBuilder errors = new StringBuilder();
        
        if (title == null || title.trim().isEmpty()) {
            errors.append("Title is required. ");
        } else if (title.length() > 255) {
            errors.append("Title too long (max 255 characters). ");
        }
        
        if (description != null && description.length() > 500) {
            errors.append("Description too long (max 500 characters). ");
        }
        
        if (status != null && !status.equals("pending") && !status.equals("completed")) {
            errors.append("Invalid status (must be 'pending' or 'completed'). ");
        }
        
        if (priority != null && !priority.equals("low") && !priority.equals("medium") && !priority.equals("high")) {
            errors.append("Invalid priority (must be 'low', 'medium', or 'high'). ");
        }
        
        return errors.toString().trim();
    }
    
    /**
     * Create a copy of this todo
     */
    public Todo copy() {
        return new Todo(this.id, this.title, this.description, this.status,
                       this.priority, this.dueDate, this.createdDate,
                       this.updatedDate, this.userId);
    }
    
    /**
     * Reset to default values
     */
    public void reset() {
        this.id = 0;
        this.title = null;
        this.description = null;
        this.status = "pending";
        this.priority = "medium";
        this.dueDate = null;
        this.createdDate = null;
        this.updatedDate = null;
        this.userId = "IT24102137";
    }
    
    /**
     * toString method for debugging
     */
    @Override
    public String toString() {
        return "Todo{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", description='" + (description != null ? description.substring(0, Math.min(description.length(), 30)) + "..." : "null") + '\'' +
                ", status='" + status + '\'' +
                ", priority='" + priority + '\'' +
                ", dueDate='" + dueDate + '\'' +
                ", createdDate='" + createdDate + '\'' +
                ", updatedDate='" + updatedDate + '\'' +
                ", userId='" + userId + '\'' +
                '}';
    }
    
    /**
     * equals method for comparison
     */
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        
        Todo todo = (Todo) obj;
        return id == todo.id &&
               java.util.Objects.equals(title, todo.title) &&
               java.util.Objects.equals(userId, todo.userId);
    }
    
    /**
     * hashCode method
     */
    @Override
    public int hashCode() {
        return java.util.Objects.hash(id, title, userId);
    }
    
    /**
     * Compare todos by priority (for sorting)
     */
    public int compareToPriority(Todo other) {
        return Integer.compare(other.getPriorityLevel(), this.getPriorityLevel());
    }
    
    /**
     * Compare todos by creation date (for sorting)
     */
    public int compareToCreatedDate(Todo other) {
        if (this.createdDate == null && other.createdDate == null) return 0;
        if (this.createdDate == null) return 1;
        if (other.createdDate == null) return -1;
        return other.createdDate.compareTo(this.createdDate); // Newest first
    }
    
    /**
     * Get summary information
     */
    public String getSummary() {
        return String.format("Todo #%d: %s [%s/%s] - %s",
                id,
                getDisplayTitle(),
                status.toUpperCase(),
                priority.toUpperCase(),
                userId);
    }
}