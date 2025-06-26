<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="TaskFlow Pro - Advanced Todo List Management Dashboard">
    <meta name="keywords" content="todo, task management, productivity, dashboard">
    <meta name="author" content="IT24102137">
    <meta name="theme-color" content="#1e3a8a">
    <title>TaskFlow Pro - Todo Dashboard</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome 6.4 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts - Poppins & Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- AOS Animation CSS -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link href="../assets/css/custom.css" rel="stylesheet">
    
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>✅</text></svg>">
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-custom sticky-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="../index.jsp">
                <i class="fas fa-tasks me-2"></i>
                <span class="brand-text">TaskFlow Pro</span>
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="#dashboard">
                            <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#tasks">
                            <i class="fas fa-list-check me-1"></i>Tasks
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#analytics">
                            <i class="fas fa-chart-bar me-1"></i>Analytics
                        </a>
                    </li>
                </ul>
                
                <div class="navbar-tools">
                    <!-- Theme Toggle -->
                    <button class="theme-toggle-nav" id="themeToggleNav" aria-label="Toggle theme">
                        <i class="fas fa-sun theme-icon-light"></i>
                        <i class="fas fa-moon theme-icon-dark"></i>
                    </button>
                    
                    <!-- User Info -->
                    <div class="user-info-nav">
                        <i class="fas fa-user-circle me-2"></i>
                        <span class="user-name">IT24102137</span>
                    </div>
                    
                    <!-- Time Display -->
                    <div class="time-display" id="currentTimeNav">
                        <i class="fas fa-clock me-2"></i>
                        <span id="timeValue">2025-06-26 18:32:53</span>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <!-- Header Section -->
    <header class="header-section">
        <div class="container-fluid">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <div class="header-content">
                        <h1 class="main-title" data-aos="fade-right">
                            <i class="fas fa-clipboard-list me-3"></i>
                            Todo Dashboard
                        </h1>
                        <p class="subtitle" data-aos="fade-right" data-aos-delay="200">
                            Manage your tasks efficiently with our advanced todo management system
                        </p>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="header-info" data-aos="fade-left">
                        <div class="current-time-large">
                            <div class="time-label">Current Time (UTC)</div>
                            <div class="time-value" id="currentTimeLarge">2025-06-26 18:32:53</div>
                        </div>
                        <div class="user-welcome">
                            <i class="fas fa-user-check me-2"></i>
                            Welcome back, <strong>IT24102137</strong>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- Statistics Section -->
    <section class="stats-container" data-aos="fade-up">
        <div class="container-fluid">
            <div class="row">
                <div class="col-xl-3 col-lg-6 col-md-6 mb-4">
                    <div class="stat-card total-card">
                        <div class="stat-icon total-icon">
                            <i class="fas fa-tasks"></i>
                        </div>
                        <div class="stat-content">
                            <div class="stat-number" id="totalTodos">0</div>
                            <div class="stat-label">Total Tasks</div>
                            <div class="stat-trend">
                                <i class="fas fa-chart-line me-1"></i>
                                <span class="trend-text">All time</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-xl-3 col-lg-6 col-md-6 mb-4">
                    <div class="stat-card pending-card">
                        <div class="stat-icon pending-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="stat-content">
                            <div class="stat-number" id="pendingTodos">0</div>
                            <div class="stat-label">Pending Tasks</div>
                            <div class="stat-trend">
                                <i class="fas fa-exclamation-circle me-1"></i>
                                <span class="trend-text">Needs attention</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-xl-3 col-lg-6 col-md-6 mb-4">
                    <div class="stat-card completed-card">
                        <div class="stat-icon completed-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="stat-content">
                            <div class="stat-number" id="completedTodos">0</div>
                            <div class="stat-label">Completed Tasks</div>
                            <div class="stat-trend">
                                <i class="fas fa-trophy me-1"></i>
                                <span class="trend-text">Well done!</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-xl-3 col-lg-6 col-md-6 mb-4">
                    <div class="stat-card overdue-card">
                        <div class="stat-icon overdue-icon">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                        <div class="stat-content">
                            <div class="stat-number" id="overdueTodos">0</div>
                            <div class="stat-label">Overdue Tasks</div>
                            <div class="stat-trend">
                                <i class="fas fa-calendar-times me-1"></i>
                                <span class="trend-text">Past due date</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Add Todo Section -->
    <section class="add-todo-section" data-aos="fade-up">
        <div class="container-fluid">
            <div class="card border-0 shadow-lg">
                <div class="card-header bg-transparent border-0">
                    <h4 class="mb-0">
                        <i class="fas fa-plus-circle me-2 text-primary"></i>
                        Add New Task
                    </h4>
                </div>
                <div class="card-body">
                    <!-- FIXED: Removed novalidate and fixed validation handling -->
                    <form id="addTodoForm">
                        <div class="row">
                            <div class="col-lg-6 mb-3">
                                <label for="todoTitle" class="form-label">
                                    <i class="fas fa-heading me-1"></i>Task Title *
                                </label>
                                <!-- FIXED: Removed required attribute to prevent browser validation -->
                                <input type="text" class="form-control" id="todoTitle" name="title" 
                                       placeholder="Enter task title..." maxlength="255">
                                <!-- FIXED: Custom validation feedback div -->
                                <div class="validation-feedback" id="titleFeedback"></div>
                            </div>
                            
                            <div class="col-lg-3 mb-3">
                                <label for="todoPriority" class="form-label">
                                    <i class="fas fa-flag me-1"></i>Priority
                                </label>
                                <select class="form-select" id="todoPriority" name="priority">
                                    <option value="low">
                                        <i class="fas fa-flag text-info"></i> Low Priority
                                    </option>
                                    <option value="medium" selected>
                                        <i class="fas fa-flag text-warning"></i> Medium Priority
                                    </option>
                                    <option value="high">
                                        <i class="fas fa-flag text-danger"></i> High Priority
                                    </option>
                                </select>
                            </div>
                            
                            <div class="col-lg-3 mb-3">
                                <label for="todoDueDate" class="form-label">
                                    <i class="fas fa-calendar-alt me-1"></i>Due Date
                                </label>
                                <input type="date" class="form-control" id="todoDueDate" name="dueDate">
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-12 mb-3">
                                <label for="todoDescription" class="form-label">
                                    <i class="fas fa-align-left me-1"></i>Description (Optional)
                                </label>
                                <textarea class="form-control" id="todoDescription" name="description" 
                                          rows="3" placeholder="Enter task description..." maxlength="500"></textarea>
                                <div class="form-text">
                                    <span id="charCount">0</span>/500 characters
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-12">
                                <button type="submit" class="btn btn-primary btn-lg" id="addTaskBtn">
                                    <i class="fas fa-plus me-2"></i>Add Task
                                </button>
                                <button type="button" class="btn btn-outline-secondary btn-lg ms-2" id="clearFormBtn">
                                    <i class="fas fa-undo me-2"></i>Clear
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <!-- Filter Controls -->
    <section class="filter-controls" data-aos="fade-up">
        <div class="container-fluid">
            <div class="card border-0 shadow">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col-lg-8">
                            <h5 class="mb-3 mb-lg-0">
                                <i class="fas fa-filter me-2"></i>Filter Tasks
                            </h5>
                            <div class="filter-buttons">
                                <button type="button" class="filter-btn active" data-filter="all">
                                    <i class="fas fa-list me-1"></i>All Tasks
                                </button>
                                <button type="button" class="filter-btn" data-filter="pending">
                                    <i class="fas fa-clock me-1"></i>Pending
                                </button>
                                <button type="button" class="filter-btn" data-filter="completed">
                                    <i class="fas fa-check me-1"></i>Completed
                                </button>
                                <button type="button" class="filter-btn" data-filter="high">
                                    <i class="fas fa-exclamation me-1"></i>High Priority
                                </button>
                                <button type="button" class="filter-btn" data-filter="overdue">
                                    <i class="fas fa-calendar-times me-1"></i>Overdue
                                </button>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="search-box">
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-search"></i>
                                    </span>
                                    <input type="text" class="form-control" id="searchTasks" 
                                           placeholder="Search tasks...">
                                    <button class="btn btn-outline-secondary" type="button" id="clearSearch">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Todo List Section -->
    <section class="todo-container" data-aos="fade-up">
        <div class="container-fluid">
            <div class="card border-0 shadow-lg">
                <div class="card-header bg-transparent border-0">
                    <div class="row align-items-center">
                        <div class="col-lg-6">
                            <h4 class="mb-0">
                                <i class="fas fa-list-ul me-2 text-primary"></i>
                                My Tasks
                            </h4>
                        </div>
                        <div class="col-lg-6">
                            <div class="task-summary text-lg-end">
                                <small class="text-muted">
                                    <i class="fas fa-info-circle me-1"></i>
                                    Showing <span id="taskCount">0</span> tasks
                                </small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-body p-0">
                    <!-- Loading Spinner -->
                    <div id="loadingSpinner" class="loading-spinner" style="display: none;">
                        <div class="spinner-border text-primary" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                        <div class="loading-text mt-3">Loading your tasks...</div>
                    </div>
                    
                    <!-- Todo Items Container -->
                    <div id="todoList" class="todo-list">
                        <!-- Todo items will be dynamically inserted here -->
                    </div>
                    
                    <!-- Empty State -->
                    <div id="emptyState" class="empty-state" style="display: none;">
                        <div class="empty-icon">
                            <i class="fas fa-tasks"></i>
                        </div>
                        <h4>No tasks found</h4>
                        <p>Start by adding your first task using the form above!</p>
                        <button class="btn btn-primary" onclick="document.getElementById('todoTitle').focus();">
                            <i class="fas fa-plus me-2"></i>Add Your First Task
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Quick Actions Floating Button -->
    <div class="quick-actions">
        <button class="quick-action-btn" id="quickAddBtn" title="Quick Add Task">
            <i class="fas fa-plus"></i>
        </button>
        <div class="quick-menu" id="quickMenu">
            <button class="quick-menu-item" onclick="document.getElementById('todoTitle').focus();">
                <i class="fas fa-plus me-2"></i>Add Task
            </button>
            <button class="quick-menu-item" onclick="window.scrollTo({top: 0, behavior: 'smooth'});">
                <i class="fas fa-arrow-up me-2"></i>Scroll Top
            </button>
            <button class="quick-menu-item" onclick="location.reload();">
                <i class="fas fa-sync me-2"></i>Refresh
            </button>
        </div>
    </div>

    <!-- Success Toast -->
    <div class="toast-container position-fixed bottom-0 end-0 p-3">
        <div id="successToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header bg-success text-white">
                <i class="fas fa-check-circle me-2"></i>
                <strong class="me-auto">Success</strong>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
            </div>
            <div class="toast-body" id="toastMessage">
                Task added successfully!
            </div>
        </div>
    </div>

    <!-- Error Toast -->
    <div class="toast-container position-fixed bottom-0 end-0 p-3">
        <div id="errorToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header bg-danger text-white">
                <i class="fas fa-exclamation-circle me-2"></i>
                <strong class="me-auto">Error</strong>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
            </div>
            <div class="toast-body" id="errorMessage">
                An error occurred!
            </div>
        </div>
    </div>

    <!-- Confirmation Modal -->
    <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmModalLabel">
                        <i class="fas fa-question-circle me-2"></i>Confirm Action
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="confirmModalBody">
                    Are you sure you want to perform this action?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-2"></i>Cancel
                    </button>
                    <button type="button" class="btn btn-danger" id="confirmModalAction">
                        <i class="fas fa-check me-2"></i>Confirm
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Task Details Modal -->
    <div class="modal fade" id="taskDetailsModal" tabindex="-1" aria-labelledby="taskDetailsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="taskDetailsModalLabel">
                        <i class="fas fa-info-circle me-2"></i>Task Details
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="taskDetailsModalBody">
                    <!-- Task details will be loaded here -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-2"></i>Close
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Progress Bar -->
    <div class="progress-container" id="progressContainer" style="display: none;">
        <div class="progress">
            <div class="progress-bar progress-bar-striped progress-bar-animated" 
                 id="progressBar" role="progressbar" style="width: 0%"></div>
        </div>
    </div>

    <!-- Bootstrap 5.3 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- AOS Animation JS -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    
    <!-- Custom JavaScript -->
    <script src="../assets/js/todo.js"></script>

    <!-- FIXED: Additional inline script to prevent validation issues -->
    <script>
        // Override default form validation behavior
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('addTodoForm');
            const titleInput = document.getElementById('todoTitle');
            const titleFeedback = document.getElementById('titleFeedback');
            
            // Remove any existing validation states on page load
            titleInput.classList.remove('is-invalid', 'is-valid');
            titleFeedback.textContent = '';
            
            // Clear validation feedback when user starts typing
            titleInput.addEventListener('input', function() {
                this.classList.remove('is-invalid', 'is-valid');
                titleFeedback.textContent = '';
                titleFeedback.className = 'validation-feedback';
            });
            
            // Clear form button
            document.getElementById('clearFormBtn').addEventListener('click', function() {
                form.reset();
                document.querySelectorAll('.form-control, .form-select').forEach(input => {
                    input.classList.remove('is-invalid', 'is-valid');
                });
                document.querySelectorAll('.validation-feedback').forEach(feedback => {
                    feedback.textContent = '';
                });
                document.getElementById('charCount').textContent = '0';
                titleInput.focus();
            });
            
            // Update timestamps
            function updateTimestamps() {
                const now = new Date();
                const utcTime = now.toISOString().replace('T', ' ').substring(0, 19);
                
                const timeElements = ['timeValue', 'currentTimeLarge'];
                timeElements.forEach(id => {
                    const element = document.getElementById(id);
                    if (element) {
                        element.textContent = utcTime;
                    }
                });
            }
            
            // Update time every second
            setInterval(updateTimestamps, 1000);
            updateTimestamps(); // Initial call
            
            console.log('TaskFlow Pro Todo Dashboard Loaded Successfully');
            console.log('Current User: IT24102137');
            console.log('Current UTC Time: 2025-06-26 18:32:53');
        });
    </script>

    <!-- Custom CSS for validation feedback -->
    <style>
        .validation-feedback {
            font-size: 0.875rem;
            margin-top: 0.25rem;
            display: block;
        }
        
        .validation-feedback.invalid {
            color: var(--danger-color);
        }
        
        .validation-feedback.valid {
            color: var(--success-color);
        }
        
        .form-control.custom-invalid {
            border-color: var(--danger-color);
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
        }
        
        .form-control.custom-valid {
            border-color: var(--success-color);
            box-shadow: 0 0 0 0.2rem rgba(25, 135, 84, 0.25);
        }
    </style>
</body>
</html>