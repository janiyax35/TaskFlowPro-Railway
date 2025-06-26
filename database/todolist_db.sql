-- TaskFlow Pro Database Schema
-- MySQL Database Creation Script for Railway Deployment
-- Author: IT24102137
-- Date: 2025-06-26 19:20:44
-- Version: 1.0

-- =====================================================
-- Database Creation and Configuration
-- =====================================================

-- Use the Railway-provided database (don't create new one)
-- Railway automatically creates the database for you

-- =====================================================
-- Table Creation: todos
-- =====================================================

-- Drop table if exists (for clean deployment)
DROP TABLE IF EXISTS todos;

-- Create todos table with comprehensive structure
CREATE TABLE todos (
    -- Primary Key
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for each todo item',
    
    -- Required Fields
    title VARCHAR(255) NOT NULL COMMENT 'Todo title - required field, max 255 characters',
    description TEXT DEFAULT NULL COMMENT 'Detailed description of the todo item',
    
    -- Status and Priority
    status ENUM('pending', 'completed') DEFAULT 'pending' NOT NULL COMMENT 'Current status of the todo',
    priority ENUM('low', 'medium', 'high') DEFAULT 'medium' NOT NULL COMMENT 'Priority level of the todo',
    
    -- Date Fields
    due_date DATE DEFAULT NULL COMMENT 'Optional due date for the todo',
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp when todo was created',
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Timestamp when todo was last updated',
    
    -- User Association
    user_id VARCHAR(50) DEFAULT 'IT24102137' NOT NULL COMMENT 'User who owns this todo',
    
    -- Additional Metadata
    is_deleted BOOLEAN DEFAULT FALSE COMMENT 'Soft delete flag',
    completion_date TIMESTAMP NULL DEFAULT NULL COMMENT 'When the todo was completed',
    
    -- Constraints
    CONSTRAINT chk_title_length CHECK (CHAR_LENGTH(title) >= 1),
    CONSTRAINT chk_description_length CHECK (description IS NULL OR CHAR_LENGTH(description) <= 500),
    CONSTRAINT chk_user_id_format CHECK (user_id REGEXP '^[A-Z]{2}[0-9]{8}$')
    
) ENGINE=InnoDB 
DEFAULT CHARSET=utf8mb4 
COLLATE=utf8mb4_unicode_ci 
COMMENT='TaskFlow Pro - Main todos table storing all todo items';

-- =====================================================
-- Indexes for Performance Optimization
-- =====================================================

-- Index on user_id for fast user-specific queries
CREATE INDEX idx_todos_user_id ON todos(user_id);

-- Index on status for filtering
CREATE INDEX idx_todos_status ON todos(status);

-- Index on priority for sorting
CREATE INDEX idx_todos_priority ON todos(priority);

-- Index on due_date for deadline queries
CREATE INDEX idx_todos_due_date ON todos(due_date);

-- Index on created_date for chronological sorting
CREATE INDEX idx_todos_created_date ON todos(created_date DESC);

-- Composite index for user + status queries (most common)
CREATE INDEX idx_todos_user_status ON todos(user_id, status);

-- Composite index for user + priority queries
CREATE INDEX idx_todos_user_priority ON todos(user_id, priority);

-- =====================================================
-- Sample Data for IT24102137
-- =====================================================

-- Insert welcome and demonstration todos for Railway deployment
INSERT INTO todos (title, description, status, priority, due_date, user_id, created_date, updated_date) VALUES
(
    'Welcome to TaskFlow Pro on Railway!', 
    'Congratulations! You have successfully deployed TaskFlow Pro to Railway cloud platform. This is your first sample task running on Railway infrastructure. You can edit, complete, or delete it anytime. Explore all the features like priority settings, due dates, and the beautiful dark/light mode toggle.',
    'pending', 
    'high', 
    '2025-06-27', 
    'IT24102137',
    '2025-06-26 19:20:44',
    '2025-06-26 19:20:44'
),

(
    'Test Railway Cloud Performance', 
    'Experience the speed and reliability of Railway cloud hosting. Notice how fast the application responds and how smoothly the real-time features work. Railway provides excellent performance for Java applications with MySQL databases.',
    'pending', 
    'medium', 
    '2025-06-28', 
    'IT24102137',
    '2025-06-26 19:20:44',
    '2025-06-26 19:20:44'
),

(
    'Verify Dark Mode Toggle', 
    'Click the theme toggle button in the navigation bar to switch between light and dark modes. Your preference is automatically saved and will persist across browser sessions thanks to localStorage.',
    'completed', 
    'low', 
    NULL, 
    'IT24102137',
    '2025-06-26 19:20:44',
    '2025-06-26 19:20:44'
),

(
    'Add Your Production Tasks', 
    'Now that your application is live on Railway, start adding your real tasks. The system is ready for production use with full CRUD operations, real-time updates, and responsive design.',
    'pending', 
    'medium', 
    '2025-06-29', 
    'IT24102137',
    '2025-06-26 19:20:44',
    '2025-06-26 19:20:44'
),

(
    'Test Mobile Responsiveness', 
    'Open your Railway-deployed application on different devices (phone, tablet, desktop) to see how the responsive design adapts perfectly to all screen sizes.',
    'pending', 
    'low', 
    '2025-06-30', 
    'IT24102137',
    '2025-06-26 19:20:44',
    '2025-06-26 19:20:44'
),

(
    'Explore Railway Dashboard', 
    'Visit your Railway dashboard to monitor your application metrics, view logs, manage environment variables, and explore other Railway features like custom domains.',
    'pending', 
    'medium', 
    '2025-07-01', 
    'IT24102137',
    '2025-06-26 19:20:44',
    '2025-06-26 19:20:44'
),

(
    'Set Up Custom Domain (Optional)', 
    'If you have a custom domain, you can easily connect it to your Railway application for a professional look. Check the Railway documentation for domain setup instructions.',
    'pending', 
    'low', 
    NULL, 
    'IT24102137',
    '2025-06-26 19:20:44',
    '2025-06-26 19:20:44'
),

(
    'Railway Deployment Complete!', 
    'Congratulations! Your TaskFlow Pro application is now successfully running on Railway cloud platform. The deployment includes MySQL database, environment variables, and automatic scaling.',
    'completed', 
    'high', 
    NULL, 
    'IT24102137',
    '2025-06-26 19:20:44',
    '2025-06-26 19:20:44'
);

-- =====================================================
-- Views for Common Queries (Railway Optimized)
-- =====================================================

-- View for pending todos with priority sorting
CREATE OR REPLACE VIEW v_pending_todos AS
SELECT 
    id,
    title,
    description,
    priority,
    due_date,
    created_date,
    user_id,
    CASE 
        WHEN due_date IS NOT NULL AND due_date < CURDATE() THEN 'overdue'
        WHEN due_date IS NOT NULL AND due_date = CURDATE() THEN 'due_today'
        ELSE 'normal'
    END as urgency_status
FROM todos 
WHERE status = 'pending' AND is_deleted = FALSE
ORDER BY 
    FIELD(priority, 'high', 'medium', 'low'),
    due_date ASC,
    created_date DESC;

-- View for completed todos
CREATE OR REPLACE VIEW v_completed_todos AS
SELECT 
    id,
    title,
    description,
    priority,
    completion_date,
    created_date,
    user_id
FROM todos 
WHERE status = 'completed' AND is_deleted = FALSE
ORDER BY completion_date DESC;

-- View for Railway deployment stats
CREATE OR REPLACE VIEW v_railway_stats AS
SELECT 
    'Railway Deployment Stats' as deployment_info,
    COUNT(*) as total_todos,
    SUM(CASE WHEN status = 'pending' THEN 1 ELSE 0 END) as pending_todos,
    SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) as completed_todos,
    SUM(CASE WHEN priority = 'high' THEN 1 ELSE 0 END) as high_priority_todos,
    'IT24102137' as user_id,
    '2025-06-26 19:20:44' as deployment_time,
    'Railway Cloud Platform' as hosting_platform
FROM todos 
WHERE user_id = 'IT24102137' AND is_deleted = FALSE;

-- =====================================================
-- Stored Procedures for Railway Deployment
-- =====================================================

-- Procedure to get user statistics (Railway optimized)
DELIMITER //
CREATE PROCEDURE GetRailwayUserStats(IN p_user_id VARCHAR(50))
BEGIN
    SELECT 
        'TaskFlow Pro on Railway' as app_name,
        p_user_id as user_id,
        COUNT(*) as total_todos,
        SUM(CASE WHEN status = 'pending' THEN 1 ELSE 0 END) as pending_todos,
        SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) as completed_todos,
        SUM(CASE WHEN priority = 'high' THEN 1 ELSE 0 END) as high_priority_todos,
        SUM(CASE WHEN status = 'pending' AND due_date IS NOT NULL AND due_date < CURDATE() THEN 1 ELSE 0 END) as overdue_todos,
        '2025-06-26 19:20:44' as deployment_timestamp,
        'Railway MySQL' as database_info,
        NOW() as current_server_time
    FROM todos 
    WHERE user_id = p_user_id AND is_deleted = FALSE;
END //
DELIMITER ;

-- Procedure to initialize Railway deployment
DELIMITER //
CREATE PROCEDURE InitializeRailwayDeployment()
BEGIN
    -- Log deployment information
    INSERT INTO todos (title, description, status, priority, user_id, created_date, updated_date) VALUES
    (
        'Railway Deployment Initialized',
        CONCAT('TaskFlow Pro successfully deployed to Railway on ', NOW(), '. Database connection established and sample data loaded for user IT24102137.'),
        'completed',
        'high',
        'IT24102137',
        NOW(),
        NOW()
    );
    
    -- Return deployment summary
    SELECT 
        'Railway Deployment Complete!' as status,
        COUNT(*) as sample_todos_created,
        'IT24102137' as default_user,
        NOW() as deployment_completed,
        '2025-06-26 19:20:44' as build_timestamp
    FROM todos 
    WHERE user_id = 'IT24102137';
END //
DELIMITER ;

-- =====================================================
-- Triggers for Railway Environment
-- =====================================================

-- Trigger to set completion_date when status changes to completed
DELIMITER //
CREATE TRIGGER tr_railway_completion_date 
BEFORE UPDATE ON todos
FOR EACH ROW
BEGIN
    IF NEW.status = 'completed' AND OLD.status != 'completed' THEN
        SET NEW.completion_date = CURRENT_TIMESTAMP;
    ELSEIF NEW.status = 'pending' AND OLD.status = 'completed' THEN
        SET NEW.completion_date = NULL;
    END IF;
END //
DELIMITER ;

-- Trigger to validate data before insert (Railway optimized)
DELIMITER //
CREATE TRIGGER tr_railway_validate_insert 
BEFORE INSERT ON todos
FOR EACH ROW
BEGIN
    -- Ensure title is not empty
    IF NEW.title IS NULL OR TRIM(NEW.title) = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'TaskFlow Pro Railway: Todo title cannot be empty';
    END IF;
    
    -- Ensure user_id follows correct format
    IF NEW.user_id NOT REGEXP '^[A-Z]{2}[0-9]{8}$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'TaskFlow Pro Railway: User ID must follow format: 2 uppercase letters + 8 digits';
    END IF;
    
    -- Set completion_date if status is completed
    IF NEW.status = 'completed' THEN
        SET NEW.completion_date = CURRENT_TIMESTAMP;
    END IF;
END //
DELIMITER ;

-- =====================================================
-- Railway Deployment Verification
-- =====================================================

-- Call initialization procedure
CALL InitializeRailwayDeployment();

-- Display Railway deployment statistics
CALL GetRailwayUserStats('IT24102137');

-- Show Railway deployment summary
SELECT 
    '🚀 TaskFlow Pro Successfully Deployed to Railway!' as deployment_status,
    COUNT(*) as total_sample_todos,
    'IT24102137' as user_account,
    '2025-06-26 19:20:44' as build_timestamp,
    NOW() as database_initialized,
    'Railway MySQL 8.0' as database_version,
    'Java 11 + Tomcat 9' as runtime_environment,
    'https://your-app.railway.app' as app_url
FROM todos 
WHERE user_id = 'IT24102137';

-- Final verification query
SELECT 
    id,
    title,
    status,
    priority,
    created_date,
    'Railway Deployment Sample' as source
FROM todos 
WHERE user_id = 'IT24102137' 
ORDER BY created_date DESC 
LIMIT 5;

-- =====================================================
-- Railway Environment Information
-- =====================================================

-- Log Railway deployment completion
SELECT 
    '✅ Database Schema Created Successfully!' as message,
    '✅ Sample Data Loaded for IT24102137' as user_status,
    '✅ Railway MySQL Connection Ready' as database_status,
    '✅ Indexes and Views Created' as performance_status,
    '✅ Triggers and Procedures Installed' as functionality_status,
    NOW() as completion_time,
    '2025-06-26 19:20:44' as build_version;

-- =====================================================
-- End of TaskFlow Pro Railway Database Schema
-- =====================================================