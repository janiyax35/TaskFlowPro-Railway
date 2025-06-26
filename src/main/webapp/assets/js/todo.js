/**
 * TaskFlow Pro - Todo Dashboard JavaScript
 * Advanced functionality with Dark/Light Mode Support
 * Author: IT24102137
 * Date: 2025-06-26 18:00:53
 */

class TodoDashboard {
    constructor() {
        this.todos = [];
        this.currentFilter = 'all';
        this.currentUser = 'IT24102137';
        this.baseUrl = '/TodoListApp';
        this.currentTheme = 'light';
        this.searchTerm = '';
        this.autoRefreshInterval = null;
        this.init();
    }

    /**
     * Initialize the dashboard application
     */
    init() {
        this.initTheme();
        this.initAOS();
        this.bindEvents();
        this.loadTodos();
        this.startAutoRefresh();
        this.startTimeUpdates();
        this.initFormValidation();
        this.initKeyboardShortcuts();
        this.showWelcomeMessage();
        
        console.log('TaskFlow Pro Dashboard Loaded Successfully');
        console.log('Current User: ' + this.currentUser);
        console.log('Current UTC Time: 2025-06-26 18:00:53');
    }

    /**
     * Initialize theme system
     */
    initTheme() {
        // Check for saved theme preference or default to 'light'
        const savedTheme = localStorage.getItem('taskflow-theme') || 'light';
        this.setTheme(savedTheme);
        
        // Create theme toggle event listener
        const themeToggle = document.getElementById('themeToggleNav');
        if (themeToggle) {
            themeToggle.addEventListener('click', () => {
                this.toggleTheme();
            });
        }
    }

    /**
     * Toggle between light and dark themes
     */
    toggleTheme() {
        const newTheme = this.currentTheme === 'light' ? 'dark' : 'light';
        this.setTheme(newTheme);
        
        // Add animation feedback
        const themeToggle = document.getElementById('themeToggleNav');
        if (themeToggle) {
            themeToggle.style.transform = 'scale(0.8)';
            setTimeout(() => {
                themeToggle.style.transform = 'scale(1)';
            }, 150);
        }
        
        // Show theme change notification
        this.showSuccess('Theme switched to ' + newTheme + ' mode');
    }

    /**
     * Set theme
     */
    setTheme(theme) {
        this.currentTheme = theme;
        document.documentElement.setAttribute('data-theme', theme);
        localStorage.setItem('taskflow-theme', theme);
        
        // Update meta theme-color for mobile browsers
        const metaThemeColor = document.querySelector('meta[name="theme-color"]');
        if (metaThemeColor) {
            metaThemeColor.setAttribute('content', theme === 'dark' ? '#0f172a' : '#1e3a8a');
        }
        
        console.log('Theme switched to: ' + theme);
    }

    /**
     * Initialize AOS animations
     */
    initAOS() {
        if (typeof AOS !== 'undefined') {
            AOS.init({
                duration: 600,
                easing: 'ease-in-out',
                once: true,
                offset: 50
            });
        }
    }

    /**
     * Bind all event listeners
     */
    bindEvents() {
        // Form submission
        const addTodoForm = document.getElementById('addTodoForm');
        if (addTodoForm) {
            addTodoForm.addEventListener('submit', (e) => this.handleAddTodo(e));
        }

        // Filter buttons
        const filterBtns = document.querySelectorAll('.filter-btn');
        filterBtns.forEach(btn => {
            btn.addEventListener('click', (e) => this.handleFilter(e));
        });

        // Search functionality
        const searchInput = document.getElementById('searchTasks');
        if (searchInput) {
            searchInput.addEventListener('input', (e) => this.handleSearch(e));
        }

        // Clear search
        const clearSearch = document.getElementById('clearSearch');
        if (clearSearch) {
            clearSearch.addEventListener('click', () => this.clearSearch());
        }

        // Character counter for description
        const descriptionInput = document.getElementById('todoDescription');
        if (descriptionInput) {
            descriptionInput.addEventListener('input', (e) => this.updateCharCounter(e));
        }

        // Quick actions
        const quickAddBtn = document.getElementById('quickAddBtn');
        if (quickAddBtn) {
            quickAddBtn.addEventListener('click', () => this.toggleQuickMenu());
        }

        // Close quick menu when clicking outside
        document.addEventListener('click', (e) => {
            const quickActions = document.querySelector('.quick-actions');
            if (quickActions && !quickActions.contains(e.target)) {
                this.closeQuickMenu();
            }
        });

        // Window events
        window.addEventListener('beforeunload', () => this.cleanup());
        window.addEventListener('focus', () => this.handleWindowFocus());
        window.addEventListener('blur', () => this.handleWindowBlur());
    }

    /**
     * Handle form submission for adding todos
     */
    async handleAddTodo(e) {
        e.preventDefault();
        
        const form = e.target;
        const formData = new FormData(form);
        
        const todoData = {
            title: formData.get('title') ? formData.get('title').trim() : '',
            description: formData.get('description') ? formData.get('description').trim() : '',
            priority: formData.get('priority') || 'medium',
            dueDate: formData.get('dueDate') || null,
            userId: this.currentUser
        };

        // Validation
        if (!this.validateTodoData(todoData)) {
            return;
        }

        this.showLoading(true);
        
        try {
            const response = await this.makeRequest('POST', '/TodoAjaxServlet', todoData);
            
            if (response.success) {
                this.showSuccess('Task added successfully!');
                this.clearForm();
                await this.loadTodos();
                this.focusElement('todoTitle');
                
                // Add animation to new todo
                this.animateNewTodo();
            } else {
                throw new Error(response.message || 'Failed to add task');
            }
        } catch (error) {
            console.error('Error adding todo:', error);
            this.showError(error.message || 'Failed to add task. Please try again.');
        } finally {
            this.showLoading(false);
        }
    }

    /**
     * Validate todo data
     */
    validateTodoData(todoData) {
        if (!todoData.title) {
            this.showError('Please enter a task title');
            this.focusElement('todoTitle');
            return false;
        }

        if (todoData.title.length > 255) {
            this.showError('Task title is too long (max 255 characters)');
            this.focusElement('todoTitle');
            return false;
        }

        if (todoData.description && todoData.description.length > 500) {
            this.showError('Description is too long (max 500 characters)');
            this.focusElement('todoDescription');
            return false;
        }

        // Validate due date
        if (todoData.dueDate) {
            const today = new Date().toISOString().split('T')[0];
            if (todoData.dueDate < today) {
                this.showError('Due date cannot be in the past');
                this.focusElement('todoDueDate');
                return false;
            }
        }

        return true;
    }

    /**
     * Load todos from server
     */
    async loadTodos() {
        this.showLoading(true);
        
        try {
            const response = await this.makeRequest('GET', '/TodoAjaxServlet', {
                action: 'list',
                userId: this.currentUser
            });
            
            if (response.success && Array.isArray(response.todos)) {
                this.todos = response.todos;
                this.renderTodos();
                this.updateStats();
                this.updateTaskCount();
                console.log('Loaded ' + this.todos.length + ' todos');
            } else {
                throw new Error(response.message || 'Failed to load tasks');
            }
        } catch (error) {
            console.error('Error loading todos:', error);
            this.showError('Failed to load tasks. Please refresh the page.');
            this.renderEmptyState();
        } finally {
            this.showLoading(false);
        }
    }

    /**
     * Update todo status
     */
    async updateTodoStatus(todoId, newStatus) {
        const originalTodos = JSON.parse(JSON.stringify(this.todos));
        
        // Optimistic update
        const todoIndex = this.todos.findIndex(t => t.id === todoId);
        if (todoIndex !== -1) {
            this.todos[todoIndex].status = newStatus;
            this.todos[todoIndex].updatedDate = new Date().toISOString();
            this.renderTodos();
            this.updateStats();
        }
        
        try {
            const response = await this.makeRequest('PUT', '/TodoAjaxServlet', {
                action: 'updateStatus',
                todoId: todoId,
                status: newStatus,
                userId: this.currentUser
            });
            
            if (response.success) {
                const statusText = newStatus === 'completed' ? 'completed' : 'marked as pending';
                this.showSuccess('Task ' + statusText + '!');
                
                // Animate status change
                this.animateStatusChange(todoId, newStatus);
            } else {
                throw new Error(response.message || 'Failed to update task');
            }
        } catch (error) {
            console.error('Error updating todo status:', error);
            
            // Revert optimistic update
            this.todos = originalTodos;
            this.renderTodos();
            this.updateStats();
            
            this.showError(error.message || 'Failed to update task status');
        }
    }

    /**
     * Delete todo
     */
    async deleteTodo(todoId) {
        const todo = this.todos.find(t => t.id === todoId);
        if (!todo) return;
        
        // Show confirmation dialog
        const confirmed = await this.showConfirmDialog(
            'Delete Task',
            'Are you sure you want to delete "' + todo.title + '"? This action cannot be undone.'
        );
        
        if (!confirmed) return;
        
        const originalTodos = JSON.parse(JSON.stringify(this.todos));
        
        // Optimistic update with animation
        this.animateDeleteTodo(todoId);
        
        // Remove from array after animation
        setTimeout(() => {
            this.todos = this.todos.filter(t => t.id !== todoId);
            this.renderTodos();
            this.updateStats();
        }, 300);
        
        try {
            const response = await this.makeRequest('DELETE', '/TodoAjaxServlet', {
                action: 'delete',
                todoId: todoId,
                userId: this.currentUser
            });
            
            if (response.success) {
                this.showSuccess('Task deleted successfully!');
            } else {
                throw new Error(response.message || 'Failed to delete task');
            }
        } catch (error) {
            console.error('Error deleting todo:', error);
            
            // Revert optimistic update
            this.todos = originalTodos;
            this.renderTodos();
            this.updateStats();
            
            this.showError(error.message || 'Failed to delete task');
        }
    }

    /**
     * Update todo priority
     */
    async updateTodoPriority(todoId, newPriority) {
        const originalTodos = JSON.parse(JSON.stringify(this.todos));
        
        // Optimistic update
        const todoIndex = this.todos.findIndex(t => t.id === todoId);
        if (todoIndex !== -1) {
            this.todos[todoIndex].priority = newPriority;
            this.todos[todoIndex].updatedDate = new Date().toISOString();
            this.renderTodos();
        }
        
        try {
            const response = await this.makeRequest('PUT', '/TodoAjaxServlet', {
                action: 'updatePriority',
                todoId: todoId,
                priority: newPriority,
                userId: this.currentUser
            });
            
            if (response.success) {
                this.showSuccess('Priority updated to ' + newPriority + '!');
            } else {
                throw new Error(response.message || 'Failed to update priority');
            }
        } catch (error) {
            console.error('Error updating priority:', error);
            
            // Revert optimistic update
            this.todos = originalTodos;
            this.renderTodos();
            
            this.showError(error.message || 'Failed to update priority');
        }
    }

    /**
     * Handle filter changes
     */
    handleFilter(e) {
        const filterValue = e.target.dataset.filter;
        if (!filterValue) return;
        
        this.currentFilter = filterValue;
        
        // Update active button
        document.querySelectorAll('.filter-btn').forEach(btn => {
            btn.classList.remove('active');
        });
        e.target.classList.add('active');
        
        this.renderTodos();
        this.updateTaskCount();
        
        // Announce filter change for screen readers
        this.announceToScreenReader('Filtered to show ' + filterValue + ' tasks');
    }

    /**
     * Handle search input
     */
    handleSearch(e) {
        this.searchTerm = e.target.value.toLowerCase();
        this.renderTodos();
        this.updateTaskCount();
    }

    /**
     * Clear search
     */
    clearSearch() {
        const searchInput = document.getElementById('searchTasks');
        if (searchInput) {
            searchInput.value = '';
            this.searchTerm = '';
            this.renderTodos();
            this.updateTaskCount();
            searchInput.focus();
        }
    }

    /**
     * Get filtered and searched todos
     */
    getFilteredTodos() {
        const now = new Date();
        const today = now.toISOString().split('T')[0];
        
        let filtered = this.todos.filter(todo => {
            // Apply filter
            let matchesFilter = true;
            switch (this.currentFilter) {
                case 'pending':
                    matchesFilter = todo.status === 'pending';
                    break;
                case 'completed':
                    matchesFilter = todo.status === 'completed';
                    break;
                case 'high':
                    matchesFilter = todo.priority === 'high';
                    break;
                case 'overdue':
                    matchesFilter = todo.status === 'pending' && todo.dueDate && todo.dueDate < today;
                    break;
                case 'all':
                default:
                    matchesFilter = true;
            }
            
            // Apply search
            let matchesSearch = true;
            if (this.searchTerm) {
                const title = todo.title.toLowerCase();
                const description = (todo.description || '').toLowerCase();
                matchesSearch = title.includes(this.searchTerm) || description.includes(this.searchTerm);
            }
            
            return matchesFilter && matchesSearch;
        });
        
        // Sort todos: pending first, then by priority, then by due date
        return filtered.sort((a, b) => {
            // Status priority (pending first)
            if (a.status !== b.status) {
                return a.status === 'pending' ? -1 : 1;
            }
            
            // Priority sorting
            const priorityOrder = { high: 3, medium: 2, low: 1 };
            const priorityDiff = (priorityOrder[b.priority] || 0) - (priorityOrder[a.priority] || 0);
            if (priorityDiff !== 0) return priorityDiff;
            
            // Due date sorting (earliest first)
            if (a.dueDate && b.dueDate) {
                return new Date(a.dueDate) - new Date(b.dueDate);
            }
            if (a.dueDate && !b.dueDate) return -1;
            if (!a.dueDate && b.dueDate) return 1;
            
            // Created date (newest first)
            return new Date(b.createdDate) - new Date(a.createdDate);
        });
    }

    /**
     * Render todos to DOM
     */
    renderTodos() {
        const todoList = document.getElementById('todoList');
        if (!todoList) return;
        
        const filteredTodos = this.getFilteredTodos();
        
        if (filteredTodos.length === 0) {
            this.renderEmptyState();
            return;
        }
        
        const todoHTML = filteredTodos.map(todo => this.renderTodoCard(todo)).join('');
        todoList.innerHTML = todoHTML;
        
        // Bind action buttons
        this.bindTodoActions();
        
        // Hide empty state
        const emptyState = document.getElementById('emptyState');
        if (emptyState) {
            emptyState.style.display = 'none';
        }
        
        // Re-initialize AOS for new elements
        if (typeof AOS !== 'undefined') {
            AOS.refresh();
        }
    }

    /**
     * Render individual todo card
     */
    renderTodoCard(todo) {
        const isOverdue = this.isOverdue(todo);
        const dueDate = todo.dueDate ? new Date(todo.dueDate).toLocaleDateString() : null;
        const createdDate = new Date(todo.createdDate).toLocaleDateString();
        
        const cardClasses = [
            'todo-card',
            todo.status === 'completed' ? 'completed' : '',
            todo.priority + '-priority',
            isOverdue ? 'overdue' : ''
        ].filter(Boolean).join(' ');
        
        const statusBadgeClass = todo.status === 'completed' ? 'status-completed' : 'status-pending';
        const priorityBadgeClass = 'priority-' + todo.priority;
        
        const overdueIcon = isOverdue ? '<i class="fas fa-exclamation-triangle text-danger ms-2" title="Overdue"></i>' : '';
        
        return '<div class="' + cardClasses + '" data-todo-id="' + todo.id + '" data-aos="fade-up">' +
                '<div class="todo-header">' +
                    '<h4 class="todo-title">' + this.escapeHtml(todo.title) + overdueIcon + '</h4>' +
                '</div>' +
                
                (todo.description ? '<p class="todo-description">' + this.escapeHtml(todo.description) + '</p>' : '') +
                
                '<div class="todo-meta">' +
                    '<span class="badge ' + statusBadgeClass + '">' +
                        '<i class="fas ' + (todo.status === 'completed' ? 'fa-check' : 'fa-clock') + ' me-1"></i>' +
                        todo.status +
                    '</span>' +
                    '<span class="badge ' + priorityBadgeClass + '">' +
                        '<i class="fas fa-flag me-1"></i>' +
                        todo.priority + ' priority' +
                    '</span>' +
                    '<div class="todo-date-info">' +
                        '<i class="fas fa-calendar-plus me-1"></i>' +
                        'Created: ' + createdDate +
                    '</div>' +
                    (dueDate ? 
                        '<div class="todo-date-info ' + (isOverdue ? 'text-danger' : '') + '">' +
                            '<i class="fas fa-calendar-check me-1"></i>' +
                            'Due: ' + dueDate +
                        '</div>'
                    : '') +
                '</div>' +
                
                '<div class="todo-actions">' +
                    (todo.status === 'pending' ? 
                        '<button class="btn btn-success btn-sm complete-btn" data-todo-id="' + todo.id + '" title="Mark as completed">' +
                            '<i class="fas fa-check me-1"></i>Complete' +
                        '</button>'
                    : 
                        '<button class="btn btn-warning btn-sm reopen-btn" data-todo-id="' + todo.id + '" title="Mark as pending">' +
                            '<i class="fas fa-undo me-1"></i>Reopen' +
                        '</button>'
                    ) +
                    
                    '<div class="btn-group" role="group">' +
                        '<button class="btn btn-info btn-sm dropdown-toggle" data-bs-toggle="dropdown" title="Change priority">' +
                            '<i class="fas fa-flag me-1"></i>Priority' +
                        '</button>' +
                        '<ul class="dropdown-menu">' +
                            '<li><a class="dropdown-item priority-btn" href="#" data-todo-id="' + todo.id + '" data-priority="high">' +
                                '<i class="fas fa-flag text-danger me-2"></i>High Priority' +
                            '</a></li>' +
                            '<li><a class="dropdown-item priority-btn" href="#" data-todo-id="' + todo.id + '" data-priority="medium">' +
                                '<i class="fas fa-flag text-warning me-2"></i>Medium Priority' +
                            '</a></li>' +
                            '<li><a class="dropdown-item priority-btn" href="#" data-todo-id="' + todo.id + '" data-priority="low">' +
                                '<i class="fas fa-flag text-info me-2"></i>Low Priority' +
                            '</a></li>' +
                        '</ul>' +
                    '</div>' +
                    
                    '<button class="btn btn-info btn-sm view-btn" data-todo-id="' + todo.id + '" title="View details">' +
                        '<i class="fas fa-eye me-1"></i>View' +
                    '</button>' +
                    
                    '<button class="btn btn-danger btn-sm delete-btn" data-todo-id="' + todo.id + '" title="Delete task">' +
                        '<i class="fas fa-trash me-1"></i>Delete' +
                    '</button>' +
                '</div>' +
            '</div>';
    }

    /**
     * Bind todo action events
     */
    bindTodoActions() {
        // Complete/Reopen buttons
        document.querySelectorAll('.complete-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const todoId = parseInt(e.currentTarget.dataset.todoId);
                this.updateTodoStatus(todoId, 'completed');
            });
        });
        
        document.querySelectorAll('.reopen-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const todoId = parseInt(e.currentTarget.dataset.todoId);
                this.updateTodoStatus(todoId, 'pending');
            });
        });
        
        // Priority buttons
        document.querySelectorAll('.priority-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.preventDefault();
                const todoId = parseInt(e.currentTarget.dataset.todoId);
                const priority = e.currentTarget.dataset.priority;
                this.updateTodoPriority(todoId, priority);
            });
        });
        
        // View buttons
        document.querySelectorAll('.view-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const todoId = parseInt(e.currentTarget.dataset.todoId);
                this.showTodoDetails(todoId);
            });
        });
        
        // Delete buttons
        document.querySelectorAll('.delete-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const todoId = parseInt(e.currentTarget.dataset.todoId);
                this.deleteTodo(todoId);
            });
        });
    }

    /**
     * Show todo details in modal
     */
    showTodoDetails(todoId) {
        const todo = this.todos.find(t => t.id === todoId);
        if (!todo) return;
        
        const isOverdue = this.isOverdue(todo);
        const dueDate = todo.dueDate ? new Date(todo.dueDate).toLocaleDateString() : 'Not set';
        const createdDate = new Date(todo.createdDate).toLocaleDateString();
        const updatedDate = todo.updatedDate ? new Date(todo.updatedDate).toLocaleDateString() : 'Never';
        
        const modalBody = document.getElementById('taskDetailsModalBody');
        if (modalBody) {
            modalBody.innerHTML = `
                <div class="task-details">
                    <h5 class="task-detail-title">${this.escapeHtml(todo.title)}</h5>
                    
                    <div class="task-detail-section">
                        <h6><i class="fas fa-align-left me-2"></i>Description</h6>
                        <p class="task-detail-description">${todo.description ? this.escapeHtml(todo.description) : 'No description provided'}</p>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="task-detail-section">
                                <h6><i class="fas fa-info-circle me-2"></i>Status</h6>
                                <span class="badge ${todo.status === 'completed' ? 'status-completed' : 'status-pending'}">
                                    <i class="fas ${todo.status === 'completed' ? 'fa-check' : 'fa-clock'} me-1"></i>
                                    ${todo.status}
                                </span>
                                ${isOverdue ? '<span class="badge bg-danger ms-2"><i class="fas fa-exclamation-triangle me-1"></i>Overdue</span>' : ''}
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="task-detail-section">
                                <h6><i class="fas fa-flag me-2"></i>Priority</h6>
                                <span class="badge priority-${todo.priority}">
                                    <i class="fas fa-flag me-1"></i>
                                    ${todo.priority} priority
                                </span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="task-detail-section">
                                <h6><i class="fas fa-calendar-plus me-2"></i>Created Date</h6>
                                <p class="task-detail-date">${createdDate}</p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="task-detail-section">
                                <h6><i class="fas fa-calendar-check me-2"></i>Due Date</h6>
                                <p class="task-detail-date ${isOverdue ? 'text-danger' : ''}">${dueDate}</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="task-detail-section">
                        <h6><i class="fas fa-clock me-2"></i>Last Updated</h6>
                        <p class="task-detail-date">${updatedDate}</p>
                    </div>
                </div>
            `;
        }
        
        const modal = new bootstrap.Modal(document.getElementById('taskDetailsModal'));
        modal.show();
    }

    /**
     * Render empty state
     */
    renderEmptyState() {
        const todoList = document.getElementById('todoList');
        const emptyState = document.getElementById('emptyState');
        
        if (todoList) {
            todoList.innerHTML = '';
        }
        
        if (emptyState) {
            emptyState.style.display = 'block';
            
            const emptyMessages = {
                all: 'No tasks found. Start by adding your first task!',
                pending: 'No pending tasks. Great job!',
                completed: 'No completed tasks yet. Get started!',
                high: 'No high priority tasks.',
                overdue: 'No overdue tasks. You are on track!'
            };
            
            let message = emptyMessages[this.currentFilter] || emptyMessages.all;
            
            if (this.searchTerm) {
                message = 'No tasks found matching "' + this.searchTerm + '". Try a different search term.';
            }
            
            const messageElement = emptyState.querySelector('p');
            if (messageElement) {
                messageElement.textContent = message;
            }
        }
    }

    /**
     * Update statistics
     */
    updateStats() {
        const total = this.todos.length;
        const completed = this.todos.filter(t => t.status === 'completed').length;
        const pending = this.todos.filter(t => t.status === 'pending').length;
        const overdue = this.todos.filter(t => this.isOverdue(t)).length;
        
        this.updateStatCard('totalTodos', total);
        this.updateStatCard('completedTodos', completed);
        this.updateStatCard('pendingTodos', pending);
        this.updateStatCard('overdueTodos', overdue);
    }

    /**
     * Update individual stat card
     */
    updateStatCard(elementId, value) {
        const element = document.getElementById(elementId);
        if (element) {
            const currentValue = parseInt(element.textContent) || 0;
            if (currentValue !== value) {
                this.animateNumber(element, currentValue, value);
            }
        }
    }

    /**
     * Update task count display
     */
    updateTaskCount() {
        const filteredTodos = this.getFilteredTodos();
        const taskCount = document.getElementById('taskCount');
        if (taskCount) {
            taskCount.textContent = filteredTodos.length;
        }
    }

    /**
     * Animate number changes
     */
    animateNumber(element, start, end, duration) {
        duration = duration || 500;
        const range = end - start;
        const increment = range / (duration / 16);
        let current = start;
        
        const timer = setInterval(() => {
            current += increment;
            if ((increment > 0 && current >= end) || (increment < 0 && current <= end)) {
                current = end;
                clearInterval(timer);
            }
            element.textContent = Math.floor(current);
        }, 16);
    }

    /**
     * Check if todo is overdue
     */
    isOverdue(todo) {
        if (!todo.dueDate || todo.status === 'completed') return false;
        const today = new Date().toISOString().split('T')[0];
        return todo.dueDate < today;
    }

    /**
     * Make AJAX request
     */
    async makeRequest(method, endpoint, data) {
        data = data || null;
        const url = this.baseUrl + endpoint;
        const options = {
            method: method,
            headers: {
                'Content-Type': 'application/json',
                'X-Requested-With': 'XMLHttpRequest'
            }
        };
        
        if (data && (method === 'POST' || method === 'PUT')) {
            options.body = JSON.stringify(data);
        } else if (data && method === 'GET') {
            const params = new URLSearchParams(data);
            return fetch(url + '?' + params, options).then(response => this.handleResponse(response));
        } else if (data && method === 'DELETE') {
            options.body = JSON.stringify(data);
        }
        
        const response = await fetch(url, options);
        return this.handleResponse(response);
    }

    /**
     * Handle fetch response
     */
    async handleResponse(response) {
        if (!response.ok) {
            if (response.status === 404) {
                throw new Error('Service not found. Please check server configuration.');
            } else if (response.status === 500) {
                throw new Error('Server error. Please try again later.');
            } else {
                throw new Error('HTTP error! status: ' + response.status);
            }
        }
        
        const contentType = response.headers.get('content-type');
        if (!contentType || !contentType.includes('application/json')) {
            throw new Error('Invalid response format. Expected JSON.');
        }
        
        try {
            return await response.json();
        } catch (error) {
            throw new Error('Failed to parse server response.');
        }
    }

    /**
     * Show success message
     */
    showSuccess(message) {
        const toast = document.getElementById('successToast');
        const messageElement = document.getElementById('toastMessage');
        
        if (toast && messageElement) {
            messageElement.textContent = message;
            const bsToast = new bootstrap.Toast(toast, { delay: 3000 });
            bsToast.show();
        }
        
        console.log('Success:', message);
    }

    /**
     * Show error message
     */
    showError(message) {
        const toast = document.getElementById('errorToast');
        const messageElement = document.getElementById('errorMessage');
        
        if (toast && messageElement) {
            messageElement.textContent = message;
            const bsToast = new bootstrap.Toast(toast, { delay: 5000 });
            bsToast.show();
        }
        
        console.error('Error:', message);
    }

    /**
     * Show confirmation dialog
     */
    showConfirmDialog(title, message) {
        return new Promise((resolve) => {
            const modal = document.getElementById('confirmModal');
            const modalTitle = document.getElementById('confirmModalLabel');
            const modalBody = document.getElementById('confirmModalBody');
            const confirmBtn = document.getElementById('confirmModalAction');
            
            if (modalTitle) modalTitle.textContent = title;
            if (modalBody) modalBody.textContent = message;
            
            const handleConfirm = () => {
                resolve(true);
                bootstrap.Modal.getInstance(modal).hide();
                confirmBtn.removeEventListener('click', handleConfirm);
            };
            
            const handleClose = () => {
                resolve(false);
                confirmBtn.removeEventListener('click', handleConfirm);
            };
            
            confirmBtn.addEventListener('click', handleConfirm);
            modal.addEventListener('hidden.bs.modal', handleClose, { once: true });
            
            const bsModal = new bootstrap.Modal(modal);
            bsModal.show();
        });
    }

    /**
     * Show/hide loading state
     */
    showLoading(show) {
        const spinner = document.getElementById('loadingSpinner');
        const todoList = document.getElementById('todoList');
        
        if (spinner) {
            spinner.style.display = show ? 'flex' : 'none';
        }
        
        if (todoList && show) {
            todoList.style.opacity = '0.5';
        } else if (todoList) {
            todoList.style.opacity = '1';
        }
        
        // Disable form during loading
        const form = document.getElementById('addTodoForm');
        if (form) {
            const inputs = form.querySelectorAll('input, textarea, select, button');
            inputs.forEach(input => {
                input.disabled = show;
            });
        }
    }

    /**
     * Clear form
     */
    clearForm() {
        const form = document.getElementById('addTodoForm');
        if (form) {
            form.reset();
            
            // Reset to default values
            const prioritySelect = form.querySelector('#todoPriority');
            if (prioritySelect) {
                prioritySelect.value = 'medium';
            }
            
            // Clear validation styles
            form.querySelectorAll('.form-control, .form-select').forEach(input => {
                input.classList.remove('is-invalid', 'is-valid');
            });
            
            // Reset character counter
            const charCount = document.getElementById('charCount');
            if (charCount) {
                charCount.textContent = '0';
            }
        }
    }

    /**
     * Focus element by ID
     */
    focusElement(elementId) {
        const element = document.getElementById(elementId);
        if (element) {
            element.focus();
            element.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
    }

    /**
     * Escape HTML to prevent XSS
     */
    escapeHtml(text) {
        if (!text) return '';
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    /**
     * Announce to screen readers
     */
    announceToScreenReader(message) {
        const announcement = document.createElement('div');
        announcement.setAttribute('aria-live', 'polite');
        announcement.setAttribute('aria-atomic', 'true');
        announcement.className = 'sr-only';
        announcement.textContent = message;
        
        document.body.appendChild(announcement);
        
        setTimeout(() => {
            document.body.removeChild(announcement);
        }, 1000);
    }

    /**
     * Update character counter
     */
    updateCharCounter(e) {
        const charCount = e.target.value.length;
        const charCountElement = document.getElementById('charCount');
        
        if (charCountElement) {
            charCountElement.textContent = charCount;
        }
        
        if (charCount > 450) {
            e.target.classList.add('text-warning');
        } else {
            e.target.classList.remove('text-warning');
        }
    }

    /**
     * Toggle quick menu
     */
    toggleQuickMenu() {
        const quickMenu = document.getElementById('quickMenu');
        if (quickMenu) {
            quickMenu.classList.toggle('show');
        }
    }

    /**
     * Close quick menu
     */
    closeQuickMenu() {
        const quickMenu = document.getElementById('quickMenu');
        if (quickMenu) {
            quickMenu.classList.remove('show');
        }
    }

    /**
     * Start auto-refresh
     */
    startAutoRefresh() {
        // Refresh every 5 minutes
        this.autoRefreshInterval = setInterval(() => {
            this.loadTodos();
        }, 5 * 60 * 1000);
    }

    /**
     * Start time updates
     */
    startTimeUpdates() {
        this.updateTime();
        setInterval(() => {
            this.updateTime();
        }, 1000);
    }

    /**
     * Update time display
     */
    updateTime() {
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

    /**
     * Initialize form validation
     */
    initFormValidation() {
        const forms = document.querySelectorAll('.needs-validation');
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', (event) => {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    }

    /**
     * Initialize keyboard shortcuts
     */
    initKeyboardShortcuts() {
        document.addEventListener('keydown', (e) => {
            // Ctrl/Cmd + N for new task
            if ((e.ctrlKey || e.metaKey) && e.key === 'n') {
                e.preventDefault();
                this.focusElement('todoTitle');
            }
            
            // Ctrl/Cmd + F for search
            if ((e.ctrlKey || e.metaKey) && e.key === 'f') {
                e.preventDefault();
                this.focusElement('searchTasks');
            }
            
            // Ctrl/Cmd + R for refresh
            if ((e.ctrlKey || e.metaKey) && e.key === 'r') {
                e.preventDefault();
                this.loadTodos();
            }
            
            // 'T' key to toggle theme
            if (e.key === 't' || e.key === 'T') {
                if (e.target === document.body) {
                    this.toggleTheme();
                }
            }
            
            // ESC to clear form
            if (e.key === 'Escape') {
                this.clearForm();
                this.closeQuickMenu();
            }
        });
    }

    /**
     * Show welcome message
     */
    showWelcomeMessage() {
        setTimeout(() => {
            this.showSuccess('Welcome back, ' + this.currentUser + '! Your tasks are ready.');
        }, 1000);
    }

    /**
     * Handle window focus
     */
    handleWindowFocus() {
        // Refresh data when window regains focus
        this.loadTodos();
    }

    /**
     * Handle window blur
     */
    handleWindowBlur() {
        // Optional: Pause auto-refresh when window loses focus
        // Implementation depends on requirements
    }

    /**
     * Animation helpers
     */
    animateNewTodo() {
        // Add fade-in animation to the first todo card
        setTimeout(() => {
            const firstCard = document.querySelector('.todo-card');
            if (firstCard) {
                firstCard.style.animation = 'slideUp 0.5s ease-out';
            }
        }, 100);
    }

    animateStatusChange(todoId, status) {
        const card = document.querySelector('.todo-card[data-todo-id="' + todoId + '"]');
        if (card) {
            card.style.animation = 'pulse 0.6s ease-in-out';
            setTimeout(() => {
                card.style.animation = '';
            }, 600);
        }
    }

    animateDeleteTodo(todoId) {
        const card = document.querySelector('.todo-card[data-todo-id="' + todoId + '"]');
        if (card) {
            card.style.animation = 'fadeOut 0.3s ease-out';
            card.style.transform = 'translateX(-100%)';
        }
    }

    /**
     * Cleanup resources
     */
    cleanup() {
        if (this.autoRefreshInterval) {
            clearInterval(this.autoRefreshInterval);
        }
        console.log('TaskFlow Pro Dashboard cleanup');
    }
}

// Global functions for backward compatibility
let todoDashboard;

function loadTodos() {
    if (todoDashboard) {
        todoDashboard.loadTodos();
    }
}

function addTodo() {
    if (todoDashboard) {
        const form = document.getElementById('addTodoForm');
        if (form) {
            todoDashboard.handleAddTodo({ target: form, preventDefault: function() {} });
        }
    }
}

function updateTodoStatus(todoId, status) {
    if (todoDashboard) {
        todoDashboard.updateTodoStatus(todoId, status);
    }
}

function deleteTodo(todoId) {
    if (todoDashboard) {
        todoDashboard.deleteTodo(todoId);
    }
}

// Initialize dashboard when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    todoDashboard = new TodoDashboard();
    
    // Set current date as minimum for due date input
    const today = new Date().toISOString().split('T')[0];
    const dueDateInput = document.getElementById('todoDueDate');
    if (dueDateInput) {
        dueDateInput.setAttribute('min', today);
    }
    
    console.log('TaskFlow Pro Dashboard Started Successfully');
    console.log('Current User: IT24102137');
    console.log('Current UTC Time: 2025-06-26 18:00:53');
});

// Add CSS animation styles
const animationStyles = document.createElement('style');
animationStyles.textContent = `
    @keyframes slideUp {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    @keyframes fadeOut {
        from {
            opacity: 1;
            transform: translateX(0);
        }
        to {
            opacity: 0;
            transform: translateX(-100%);
        }
    }
    
    @keyframes pulse {
        0%, 100% {
            transform: scale(1);
        }
        50% {
            transform: scale(1.02);
        }
    }
    
    .task-details {
        padding: 1rem 0;
    }
    
    .task-detail-title {
        color: var(--primary-color);
        margin-bottom: 1.5rem;
        border-bottom: 2px solid var(--border-color);
        padding-bottom: 0.5rem;
    }
    
    .task-detail-section {
        margin-bottom: 1.5rem;
    }
    
    .task-detail-section h6 {
        color: var(--text-secondary);
        font-size: 0.9rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 0.5rem;
    }
    
    .task-detail-description {
        background: var(--input-bg);
        padding: 1rem;
        border-radius: var(--radius-md);
        border: 1px solid var(--border-color);
        color: var(--text-primary);
        margin: 0;
    }
    
    .task-detail-date {
        font-family: 'Poppins', monospace;
        font-weight: 500;
        margin: 0;
    }
    
    .sr-only {
        position: absolute !important;
        width: 1px !important;
        height: 1px !important;
        padding: 0 !important;
        margin: -1px !important;
        overflow: hidden !important;
        clip: rect(0, 0, 0, 0) !important;
        white-space: nowrap !important;
        border: 0 !important;
    }
`;

document.head.appendChild(animationStyles);