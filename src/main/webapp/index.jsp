<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="TaskFlow Pro - Advanced Todo Management System for efficient task organization">
    <meta name="keywords" content="todo, task management, productivity, TaskFlow Pro">
    <meta name="author" content="IT24102137">
    <meta name="theme-color" content="#1e3a8a">
    <title>TaskFlow Pro - Advanced Todo Management System</title>
    
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome 6.4 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts - Poppins & Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- AOS Animation CSS -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link href="assets/css/index.css" rel="stylesheet">
    
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>✅</text></svg>">
</head>
<body>
    <!-- Theme Toggle Button will be created by JavaScript -->

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <div class="hero-content">
                        <h1 class="hero-title">
                            <i class="fas fa-tasks me-3"></i>
                            TaskFlow Pro
                        </h1>
                        <p class="hero-subtitle">
                            Transform your productivity with our advanced todo management system. 
                            Organize, prioritize, and accomplish your goals with elegance and efficiency.
                        </p>
                        
                        <div class="hero-stats">
                            <div class="hero-stat">
                                <span class="hero-stat-number">100%</span>
                                <div class="hero-stat-label">Responsive</div>
                            </div>
                            <div class="hero-stat">
                                <span class="hero-stat-number">24/7</span>
                                <div class="hero-stat-label">Available</div>
                            </div>
                            <div class="hero-stat">
                                <span class="hero-stat-number">Fast</span>
                                <div class="hero-stat-label">Performance</div>
                            </div>
                        </div>
                        
                        <div class="hero-buttons">
                            <a href="views/todoList.jsp" class="btn-hero btn-primary-hero">
                                <i class="fas fa-rocket"></i>
                                Get Started
                            </a>
                            <a href="#features" class="btn-hero btn-secondary-hero">
                                <i class="fas fa-info-circle"></i>
                                Learn More
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="hero-image text-center">
                        <!-- SVG Illustration -->
                        <svg width="500" height="400" viewBox="0 0 500 400" class="hero-illustration">
                            <defs>
                                <linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="100%">
                                    <stop offset="0%" style="stop-color:#1e3a8a;stop-opacity:1" />
                                    <stop offset="100%" style="stop-color:#0891b2;stop-opacity:1" />
                                </linearGradient>
                                <linearGradient id="grad2" x1="0%" y1="0%" x2="100%" y2="100%">
                                    <stop offset="0%" style="stop-color:#06b6d4;stop-opacity:1" />
                                    <stop offset="100%" style="stop-color:#059669;stop-opacity:1" />
                                </linearGradient>
                            </defs>
                            
                            <!-- Background -->
                            <rect width="500" height="400" fill="none"/>
                            
                            <!-- Main Device -->
                            <rect x="100" y="50" width="300" height="300" rx="20" fill="url(#grad1)" opacity="0.9"/>
                            <rect x="120" y="70" width="260" height="200" rx="10" fill="white" opacity="0.95"/>
                            
                            <!-- Task Items -->
                            <rect x="140" y="90" width="220" height="25" rx="5" fill="#f1f5f9"/>
                            <circle cx="155" cy="102.5" r="6" fill="url(#grad2)"/>
                            <rect x="170" y="98" width="140" height="8" rx="4" fill="#64748b" opacity="0.6"/>
                            
                            <rect x="140" y="125" width="220" height="25" rx="5" fill="#f1f5f9"/>
                            <circle cx="155" cy="137.5" r="6" fill="url(#grad2)"/>
                            <rect x="170" y="133" width="180" height="8" rx="4" fill="#64748b" opacity="0.6"/>
                            
                            <rect x="140" y="160" width="220" height="25" rx="5" fill="#f1f5f9"/>
                            <circle cx="155" cy="172.5" r="6" fill="#d97706"/>
                            <rect x="170" y="168" width="160" height="8" rx="4" fill="#64748b" opacity="0.6"/>
                            
                            <!-- Floating Elements -->
                            <circle cx="80" cy="100" r="15" fill="url(#grad2)" opacity="0.7">
                                <animate attributeName="cy" values="100;90;100" dur="3s" repeatCount="indefinite"/>
                            </circle>
                            <circle cx="420" cy="150" r="20" fill="url(#grad1)" opacity="0.6">
                                <animate attributeName="cy" values="150;140;150" dur="4s" repeatCount="indefinite"/>
                            </circle>
                            <circle cx="450" cy="80" r="10" fill="#059669" opacity="0.8">
                                <animate attributeName="cy" values="80;70;80" dur="2.5s" repeatCount="indefinite"/>
                            </circle>
                            
                            <!-- Plus Icon -->
                            <circle cx="350" cy="320" r="30" fill="url(#grad2)"/>
                            <rect x="342" y="308" width="16" height="4" rx="2" fill="white"/>
                            <rect x="348" y="302" width="4" height="16" rx="2" fill="white"/>
                        </svg>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="features-section">
        <div class="container">
            <h2 class="section-title" data-aos="fade-up">Powerful Features</h2>
            <p class="section-subtitle" data-aos="fade-up" data-aos-delay="100">
                Discover the advanced capabilities that make TaskFlow Pro the perfect choice for your productivity needs.
            </p>
            
            <div class="row">
                <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-bolt"></i>
                        </div>
                        <h3 class="feature-title">Lightning Fast</h3>
                        <p class="feature-description">
                            Built with modern technologies for instant response times. 
                            AJAX-powered operations ensure smooth user experience without page reloads.
                        </p>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h3 class="feature-title">Fully Responsive</h3>
                        <p class="feature-description">
                            Perfect experience across all devices. Whether on desktop, tablet, 
                            or mobile, your tasks are always accessible and beautifully displayed.
                        </p>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="400">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-flag"></i>
                        </div>
                        <h3 class="feature-title">Smart Priorities</h3>
                        <p class="feature-description">
                            Organize tasks with intelligent priority system. Visual indicators 
                            and automatic sorting help you focus on what matters most.
                        </p>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="500">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <h3 class="feature-title">Due Date Tracking</h3>
                        <p class="feature-description">
                            Never miss a deadline again. Automatic overdue detection with 
                            visual alerts keeps you on track with all your commitments.
                        </p>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="600">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-chart-bar"></i>
                        </div>
                        <h3 class="feature-title">Real-time Analytics</h3>
                        <p class="feature-description">
                            Track your productivity with live statistics. Monitor completed tasks, 
                            pending items, and overall progress at a glance.
                        </p>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="700">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h3 class="feature-title">Secure & Reliable</h3>
                        <p class="feature-description">
                            Your data is protected with enterprise-grade security. 
                            Reliable SQL database ensures your tasks are never lost.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section id="about" class="about-section">
        <div class="container">
            <div class="about-content">
                <div class="about-text" data-aos="fade-right">
                    <h2 class="section-title text-start">About TaskFlow Pro</h2>
                    <p class="mb-4">
                        TaskFlow Pro is a modern, full-featured todo management application built with 
                        cutting-edge Java technologies. Designed with user experience in mind, it combines 
                        powerful functionality with elegant design.
                    </p>
                    <p class="mb-4">
                        This application demonstrates advanced web development concepts including 
                        Java Servlets, JSP templating, AJAX interactions, and responsive design principles. 
                        Every aspect has been crafted to provide a seamless and efficient task management experience.
                    </p>
                    <p class="mb-4">
                        Built as a comprehensive solution for modern productivity needs, TaskFlow Pro 
                        features real-time updates, intelligent prioritization, and cross-platform compatibility 
                        to help you stay organized and achieve your goals.
                    </p>
                    
                    <div class="tech-stack">
                        <span class="tech-badge"><i class="fab fa-java me-1"></i>Java Servlets</span>
                        <span class="tech-badge"><i class="fas fa-file-code me-1"></i>JSP</span>
                        <span class="tech-badge"><i class="fab fa-bootstrap me-1"></i>Bootstrap 5</span>
                        <span class="tech-badge"><i class="fab fa-js-square me-1"></i>JavaScript</span>
                        <span class="tech-badge"><i class="fas fa-database me-1"></i>MySQL</span>
                        <span class="tech-badge"><i class="fas fa-code me-1"></i>AJAX</span>
                        <span class="tech-badge"><i class="fab fa-font-awesome me-1"></i>Font Awesome</span>
                        <span class="tech-badge"><i class="fas fa-magic me-1"></i>AOS Animations</span>
                    </div>
                </div>
                
                <div class="about-image" data-aos="fade-left">
                    <!-- Code illustration SVG -->
                    <svg width="400" height="300" viewBox="0 0 400 300" class="about-illustration">
                        <defs>
                            <linearGradient id="codeGrad1" x1="0%" y1="0%" x2="100%" y2="100%">
                                <stop offset="0%" style="stop-color:#1e3a8a;stop-opacity:1" />
                                <stop offset="100%" style="stop-color:#0891b2;stop-opacity:1" />
                            </linearGradient>
                        </defs>
                        
                        <!-- Terminal Window -->
                        <rect x="50" y="50" width="300" height="200" rx="10" fill="url(#codeGrad1)" opacity="0.9"/>
                        <rect x="60" y="80" width="280" height="160" rx="5" fill="#1f2937"/>
                        
                        <!-- Title Bar -->
                        <rect x="50" y="50" width="300" height="30" rx="10" fill="url(#codeGrad1)"/>
                        <circle cx="70" cy="65" r="5" fill="#ef4444"/>
                        <circle cx="90" cy="65" r="5" fill="#f59e0b"/>
                        <circle cx="110" cy="65" r="5" fill="#10b981"/>
                        
                        <!-- Code Lines -->
                        <rect x="80" y="100" width="60" height="3" rx="1.5" fill="#06b6d4"/>
                        <rect x="150" y="100" width="80" height="3" rx="1.5" fill="#10b981"/>
                        <rect x="240" y="100" width="40" height="3" rx="1.5" fill="#f59e0b"/>
                        
                        <rect x="80" y="120" width="40" height="3" rx="1.5" fill="#f59e0b"/>
                        <rect x="130" y="120" width="100" height="3" rx="1.5" fill="#64748b"/>
                        
                        <rect x="80" y="140" width="80" height="3" rx="1.5" fill="#10b981"/>
                        <rect x="170" y="140" width="60" height="3" rx="1.5" fill="#06b6d4"/>
                        
                        <rect x="80" y="160" width="120" height="3" rx="1.5" fill="#64748b"/>
                        
                        <rect x="80" y="180" width="50" height="3" rx="1.5" fill="#ef4444"/>
                        <rect x="140" y="180" width="90" height="3" rx="1.5" fill="#06b6d4"/>
                        
                        <rect x="80" y="200" width="70" height="3" rx="1.5" fill="#10b981"/>
                        <rect x="160" y="200" width="80" height="3" rx="1.5" fill="#f59e0b"/>
                        
                        <!-- Cursor -->
                        <rect x="250" y="198" width="2" height="8" fill="#ffffff">
                            <animate attributeName="opacity" values="1;0;1" dur="1s" repeatCount="indefinite"/>
                        </rect>
                        
                        <!-- Floating Code Elements -->
                        <text x="200" y="40" font-family="monospace" font-size="12" fill="url(#codeGrad1)" opacity="0.7">&lt;/&gt;</text>
                        <text x="30" y="150" font-family="monospace" font-size="10" fill="#10b981" opacity="0.6">{}</text>
                        <text x="360" y="180" font-family="monospace" font-size="10" fill="#f59e0b" opacity="0.6">[]</text>
                        <text x="370" y="120" font-family="monospace" font-size="8" fill="#06b6d4" opacity="0.5">()</text>
                    </svg>
                </div>
            </div>
            
            <!-- System Information -->
            <div class="system-info" data-aos="fade-up">
                <h3><i class="fas fa-info-circle me-2"></i>System Information</h3>
                <div class="system-info-grid">
                    <div class="system-info-item">
                        <div class="system-info-icon">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="system-info-text">
                            <div class="system-info-label">Current User</div>
                            <div class="system-info-value">IT24102137</div>
                        </div>
                    </div>
                    <div class="system-info-item">
                        <div class="system-info-icon">
                            <i class="fas fa-calendar"></i>
                        </div>
                        <div class="system-info-text">
                            <div class="system-info-label">Current Date</div>
                            <div class="system-info-value" id="currentDate">
                                2025-06-26
                            </div>
                        </div>
                    </div>
                    <div class="system-info-item">
                        <div class="system-info-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="system-info-text">
                            <div class="system-info-label">Current Time (UTC)</div>
                            <div class="system-info-value" id="currentTime">
                                16:57:40
                            </div>
                        </div>
                    </div>
                    <div class="system-info-item">
                        <div class="system-info-icon">
                            <i class="fas fa-server"></i>
                        </div>
                        <div class="system-info-text">
                            <div class="system-info-label">Server Status</div>
                            <div class="system-info-value">
                                <span class="status-online">
                                    <i class="fas fa-circle me-1"></i>Online
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="system-info-item">
                        <div class="system-info-icon">
                            <i class="fas fa-database"></i>
                        </div>
                        <div class="system-info-text">
                            <div class="system-info-label">Database</div>
                            <div class="system-info-value">MySQL Connected</div>
                        </div>
                    </div>
                    <div class="system-info-item">
                        <div class="system-info-icon">
                            <i class="fas fa-code"></i>
                        </div>
                        <div class="system-info-text">
                            <div class="system-info-label">Version</div>
                            <div class="system-info-value">TaskFlow Pro v1.0</div>
                        </div>
                    </div>
                    <div class="system-info-item">
                        <div class="system-info-icon">
                            <i class="fas fa-laptop-code"></i>
                        </div>
                        <div class="system-info-text">
                            <div class="system-info-label">Platform</div>
                            <div class="system-info-value">Java Web Application</div>
                        </div>
                    </div>
                    <div class="system-info-item">
                        <div class="system-info-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <div class="system-info-text">
                            <div class="system-info-label">Security</div>
                            <div class="system-info-value">
                                <span style="color: var(--success-color);">
                                    <i class="fas fa-check me-1"></i>Protected
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Statistics Section -->
    <section class="stats-section">
        <div class="container">
            <div class="row text-center" data-aos="fade-up">
                <div class="col-lg-12">
                    <h2 class="section-title mb-5">Why Choose TaskFlow Pro?</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="stat-item">
                        <div class="stat-icon">
                            <i class="fas fa-rocket"></i>
                        </div>
                        <div class="stat-number">99.9%</div>
                        <div class="stat-label">Uptime Reliability</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="stat-item">
                        <div class="stat-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-number">10K+</div>
                        <div class="stat-label">Active Users</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="stat-item">
                        <div class="stat-icon">
                            <i class="fas fa-tasks"></i>
                        </div>
                        <div class="stat-number">1M+</div>
                        <div class="stat-label">Tasks Completed</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="400">
                    <div class="stat-item">
                        <div class="stat-icon">
                            <i class="fas fa-star"></i>
                        </div>
                        <div class="stat-number">4.9/5</div>
                        <div class="stat-label">User Rating</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Call to Action Section -->
    <section class="cta-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8 text-center" data-aos="fade-up">
                    <h2 class="cta-title">Ready to Transform Your Productivity?</h2>
                    <p class="cta-description">
                        Join thousands of users who have already revolutionized their task management 
                        with TaskFlow Pro. Start your journey to better productivity today.
                    </p>
                    <div class="cta-buttons">
                        <a href="views/todoList.jsp" class="btn-hero btn-primary-hero me-3">
                            <i class="fas fa-play me-2"></i>
                            Start Managing Tasks
                        </a>
                        <a href="#features" class="btn-hero btn-secondary-hero">
                            <i class="fas fa-question-circle me-2"></i>
                            Learn More
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <h3 class="footer-title">
                    <i class="fas fa-tasks me-2"></i>
                    TaskFlow Pro
                </h3>
                <p>Advanced Todo Management System for Modern Productivity</p>
                <p class="mb-4">Empowering individuals and teams to achieve more through intelligent task organization.</p>
                
                <div class="footer-links">
                    <a href="views/todoList.jsp" class="footer-link">
                        <i class="fas fa-home me-1"></i>Dashboard
                    </a>
                    <a href="#features" class="footer-link">
                        <i class="fas fa-star me-1"></i>Features
                    </a>
                    <a href="#about" class="footer-link">
                        <i class="fas fa-info me-1"></i>About
                    </a>
                    <a href="mailto:it24102137@my.sliit.lk" class="footer-link">
                        <i class="fas fa-envelope me-1"></i>Contact
                    </a>
                    <a href="#" class="footer-link">
                        <i class="fas fa-file-alt me-1"></i>Documentation
                    </a>
                    <a href="#" class="footer-link">
                        <i class="fas fa-life-ring me-1"></i>Support
                    </a>
                </div>
                
                <div class="social-links">
                    <a href="#" class="social-link" title="GitHub">
                        <i class="fab fa-github"></i>
                    </a>
                    <a href="#" class="social-link" title="LinkedIn">
                        <i class="fab fa-linkedin"></i>
                    </a>
                    <a href="#" class="social-link" title="Twitter">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a href="#" class="social-link" title="Email">
                        <i class="fas fa-envelope"></i>
                    </a>
                </div>
                
                <div class="footer-copyright">
                    <p>&copy; 2025 TaskFlow Pro. Created by IT24102137. All rights reserved.</p>
                    <p>Built with ❤️ using Java Servlets, JSP, Bootstrap & Modern Web Technologies</p>
                    <p class="footer-timestamp">
                        Last updated: <%= LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) %> UTC
                    </p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scroll to Top Button -->
    <button class="scroll-top" id="scrollTop" aria-label="Scroll to top">
        <i class="fas fa-chevron-up"></i>
    </button>

    <!-- Bootstrap 5.3 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- AOS Animation JS -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    
    <!-- Custom JavaScript -->
    <script src="assets/js/index.js"></script>
    
    <!-- Additional Styles for New Sections -->
    <style>
        /* Statistics Section */
        .stats-section {
            padding: 5rem 0;
            background: var(--card-bg);
            transition: var(--transition);
        }
        
        .stat-item {
            text-align: center;
            padding: 2rem 1rem;
            border-radius: var(--radius-lg);
            transition: var(--transition);
            cursor: pointer;
        }
        
        .stat-item:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }
        
        .stat-icon {
            width: 80px;
            height: 80px;
            background: var(--gradient-primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 2rem;
            color: white;
            transition: var(--transition);
        }
        
        .stat-item:hover .stat-icon {
            transform: scale(1.1);
            box-shadow: var(--shadow-glow);
        }
        
        .stat-number {
            font-size: 3rem;
            font-weight: 700;
            color: var(--primary-color);
            font-family: 'Poppins', sans-serif;
            margin-bottom: 0.5rem;
        }
        
        .stat-label {
            font-size: 1.1rem;
            color: var(--text-secondary);
            font-weight: 500;
        }
        
        /* Call to Action Section */
        .cta-section {
            padding: 5rem 0;
            background: var(--gradient-primary);
            color: white;
            position: relative;
            overflow: hidden;
        }
        
        .cta-section::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: float 10s ease-in-out infinite;
        }
        
        .cta-title {
            font-size: clamp(2rem, 5vw, 3rem);
            font-weight: 700;
            margin-bottom: 1.5rem;
            position: relative;
            z-index: 2;
        }
        
        .cta-description {
            font-size: 1.25rem;
            margin-bottom: 2.5rem;
            opacity: 0.95;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
            position: relative;
            z-index: 2;
        }
        
        .cta-buttons {
            position: relative;
            z-index: 2;
        }
        
        /* Social Links */
        .social-links {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin: 2rem 0;
        }
        
        .social-link {
            width: 50px;
            height: 50px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #94a3b8;
            font-size: 1.25rem;
            text-decoration: none;
            transition: var(--transition);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .social-link:hover {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            transform: translateY(-3px);
        }
        
        /* Scroll to Top Button */
        .scroll-top {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            width: 50px;
            height: 50px;
            background: var(--gradient-primary);
            border: none;
            border-radius: 50%;
            color: white;
            font-size: 1.25rem;
            cursor: pointer;
            box-shadow: var(--shadow-lg);
            transition: var(--transition);
            z-index: 1000;
            opacity: 0;
            visibility: hidden;
        }
        
        .scroll-top.visible {
            opacity: 1;
            visibility: visible;
        }
        
        .scroll-top:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-xl);
        }
        
        .footer-timestamp {
            font-size: 0.8rem;
            color: #6b7280;
            margin-top: 1rem;
        }
        
        /* Dark mode adjustments for new sections */
        [data-theme="dark"] .stats-section {
            background: var(--card-bg);
        }
        
        [data-theme="dark"] .stat-number {
            color: var(--accent-color);
        }
        
        [data-theme="dark"] .stat-item:hover {
            background: rgba(255, 255, 255, 0.05);
        }
    </style>
</body>
</html>