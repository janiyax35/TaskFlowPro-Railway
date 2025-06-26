/**
 * TaskFlow Pro - Index Page JavaScript
 * Normal cursor with dark/light mode functionality
 * Author: IT24102137
 * Date: 2025-06-26 16:51:23
 */

class IndexApp {
    constructor() {
        this.currentTheme = 'light';
        this.particles = [];
        this.init();
    }

    /**
     * Initialize the application
     */
    init() {
        this.initTheme();
        this.createThemeToggle();
        this.initAOS();
        this.initSmoothScrolling();
        this.initButtonEffects();
        this.initTimeUpdates();
        this.initParticleSystem();
        this.initTypingEffect();
        this.initScrollEffects();
        this.bindEvents();
        
        console.log('TaskFlow Pro Index Page Loaded Successfully');
        console.log('Current User: IT24102137');
        console.log('Current Date: 2025-06-26 16:51:23');
    }

    /**
     * Initialize theme system
     */
    initTheme() {
        // Check for saved theme preference or default to 'light'
        const savedTheme = localStorage.getItem('taskflow-theme') || 'light';
        this.setTheme(savedTheme);
    }

    /**
     * Create theme toggle button
     */
    createThemeToggle() {
        const themeToggle = document.createElement('button');
        themeToggle.className = 'theme-toggle';
        themeToggle.setAttribute('aria-label', 'Toggle dark/light mode');
        themeToggle.innerHTML = `
            <i class="fas fa-sun theme-icon-light"></i>
            <i class="fas fa-moon theme-icon-dark"></i>
        `;
        
        themeToggle.addEventListener('click', () => {
            this.toggleTheme();
        });
        
        document.body.appendChild(themeToggle);
    }

    /**
     * Toggle between light and dark themes
     */
    toggleTheme() {
        const newTheme = this.currentTheme === 'light' ? 'dark' : 'light';
        this.setTheme(newTheme);
        
        // Add animation feedback
        const themeToggle = document.querySelector('.theme-toggle');
        themeToggle.style.transform = 'scale(0.8)';
        setTimeout(() => {
            themeToggle.style.transform = 'scale(1)';
        }, 150);
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
            metaThemeColor.setAttribute('content', theme === 'dark' ? '#111827' : '#1e3a8a');
        } else {
            const meta = document.createElement('meta');
            meta.name = 'theme-color';
            meta.content = theme === 'dark' ? '#111827' : '#1e3a8a';
            document.head.appendChild(meta);
        }
        
        console.log(`Theme switched to: ${theme}`);
    }

    /**
     * Initialize AOS animations
     */
    initAOS() {
        AOS.init({
            duration: 800,
            easing: 'ease-in-out',
            once: true,
            offset: 100,
            delay: 100
        });
    }

    /**
     * Initialize smooth scrolling
     */
    initSmoothScrolling() {
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', (e) => {
                e.preventDefault();
                const target = document.querySelector(anchor.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    }

    /**
     * Initialize button effects
     */
    initButtonEffects() {
        // Get Started button effect
        const getStartedBtn = document.querySelector('.btn-primary-hero');
        if (getStartedBtn) {
            getStartedBtn.addEventListener('click', (e) => {
                e.preventDefault();
                
                const btn = e.currentTarget;
                const originalText = btn.innerHTML;
                
                // Add loading state
                btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Loading...';
                btn.style.pointerEvents = 'none';
                btn.classList.add('loading');
                
                // Simulate loading and redirect
                setTimeout(() => {
                    window.location.href = btn.href;
                }, 1000);
            });
        }

        // Add ripple effect to all buttons
        const buttons = document.querySelectorAll('.btn-hero, .feature-card');
        buttons.forEach(button => {
            button.addEventListener('click', (e) => {
                this.createRipple(e, button);
            });
        });
    }

    /**
     * Create ripple effect
     */
    createRipple(event, element) {
        const ripple = document.createElement('span');
        const rect = element.getBoundingClientRect();
        const size = Math.max(rect.width, rect.height);
        const x = event.clientX - rect.left - size / 2;
        const y = event.clientY - rect.top - size / 2;
        
        ripple.style.cssText = `
            position: absolute;
            width: ${size}px;
            height: ${size}px;
            left: ${x}px;
            top: ${y}px;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            transform: scale(0);
            animation: ripple 0.6s ease-out;
            pointer-events: none;
            z-index: 1000;
        `;
        
        element.style.position = 'relative';
        element.style.overflow = 'hidden';
        element.appendChild(ripple);
        
        setTimeout(() => {
            ripple.remove();
        }, 600);
    }

    /**
     * Initialize time updates
     */
    initTimeUpdates() {
        this.updateDateTime();
        setInterval(() => {
            this.updateDateTime();
        }, 1000);
    }

    /**
     * Update date and time display
     */
    updateDateTime() {
        const now = new Date();
        
        // Format date as YYYY-MM-DD
        const dateString = now.toISOString().split('T')[0];
        
        // Format time as HH:MM:SS
        const timeString = now.toTimeString().split(' ')[0];
        
        const dateElement = document.getElementById('currentDate');
        const timeElement = document.getElementById('currentTime');
        
        if (dateElement) {
            dateElement.textContent = dateString;
        }
        
        if (timeElement) {
            timeElement.textContent = timeString;
        }
    }

    /**
     * Initialize particle system
     */
    initParticleSystem() {
        this.createParticleStyles();
        
        // Create particles periodically
        setInterval(() => {
            this.createParticle();
        }, 2000);
        
        // Create initial particles
        for (let i = 0; i < 5; i++) {
            setTimeout(() => {
                this.createParticle();
            }, i * 400);
        }
    }

    /**
     * Create particle styles
     */
    createParticleStyles() {
        const style = document.createElement('style');
        style.textContent = `
            @keyframes particleFloat {
                0% {
                    opacity: 0;
                    transform: translateY(100vh) rotate(0deg);
                }
                10% {
                    opacity: 1;
                }
                50% {
                    opacity: 0.8;
                    transform: translateY(50vh) rotate(180deg);
                }
                90% {
                    opacity: 0.3;
                }
                100% {
                    opacity: 0;
                    transform: translateY(-100px) rotate(360deg);
                }
            }
            
            @keyframes ripple {
                0% {
                    transform: scale(0);
                    opacity: 1;
                }
                100% {
                    transform: scale(2);
                    opacity: 0;
                }
            }
            
            .particle {
                position: fixed;
                pointer-events: none;
                z-index: 1;
                border-radius: 50%;
            }
            
            .loading {
                opacity: 0.8;
                transform: scale(0.98);
            }
        `;
        document.head.appendChild(style);
    }

    /**
     * Create floating particle
     */
    createParticle() {
        const heroSection = document.querySelector('.hero-section');
        if (!heroSection) return;

        const particle = document.createElement('div');
        const size = Math.random() * 8 + 4;
        const colors = ['rgba(30, 58, 138, 0.3)', 'rgba(8, 145, 178, 0.3)', 'rgba(6, 182, 212, 0.3)'];
        const color = colors[Math.floor(Math.random() * colors.length)];
        
        particle.className = 'particle';
        particle.style.cssText = `
            width: ${size}px;
            height: ${size}px;
            background: ${color};
            left: ${Math.random() * 100}%;
            top: 100vh;
            animation: particleFloat ${8 + Math.random() * 4}s linear infinite;
            animation-delay: ${Math.random() * 2}s;
        `;
        
        heroSection.appendChild(particle);
        
        // Remove particle after animation
        setTimeout(() => {
            if (particle.parentNode) {
                particle.parentNode.removeChild(particle);
            }
        }, 12000);
    }

    /**
     * Initialize typing effect
     */
    initTypingEffect() {
        setTimeout(() => {
            const heroTitle = document.querySelector('.hero-title');
            if (heroTitle) {
                const text = heroTitle.textContent;
                const icon = heroTitle.querySelector('i');
                
                if (icon) {
                    const iconHTML = icon.outerHTML;
                    const textContent = text.replace(icon.textContent, '').trim();
                    
                    heroTitle.innerHTML = iconHTML + ' ';
                    this.typeWriter(heroTitle, textContent, 100);
                }
            }
        }, 1500);
    }

    /**
     * Type writer effect
     */
    typeWriter(element, text, speed) {
        const currentHTML = element.innerHTML;
        let i = 0;
        
        const type = () => {
            if (i < text.length) {
                element.innerHTML = currentHTML + text.charAt(i);
                i++;
                setTimeout(type, speed);
            } else {
                // Add blinking cursor
                element.innerHTML += '<span class="typing-cursor">|</span>';
                
                // Remove cursor after 2 seconds
                setTimeout(() => {
                    const cursor = element.querySelector('.typing-cursor');
                    if (cursor) cursor.remove();
                }, 2000);
            }
        };
        
        type();
        
        // Add cursor blinking style
        const style = document.createElement('style');
        style.textContent = `
            .typing-cursor {
                animation: blink 1s infinite;
                color: rgba(255, 255, 255, 0.8);
            }
            
            @keyframes blink {
                0%, 50% { opacity: 1; }
                51%, 100% { opacity: 0; }
            }
        `;
        document.head.appendChild(style);
    }

    /**
     * Initialize scroll effects
     */
    initScrollEffects() {
        let lastScrollY = window.scrollY;
        
        window.addEventListener('scroll', () => {
            const currentScrollY = window.scrollY;
            const heroSection = document.querySelector('.hero-section');
            
            if (heroSection) {
                // Parallax effect for hero section
                const scrolled = currentScrollY;
                const parallax = scrolled * 0.5;
                heroSection.style.transform = `translateY(${parallax}px)`;
            }
            
            // Update stats on scroll
            if (currentScrollY > lastScrollY) {
                this.animateStatsOnScroll();
            }
            
            lastScrollY = currentScrollY;
        });
    }

    /**
     * Animate stats on scroll
     */
    animateStatsOnScroll() {
        const statsElements = document.querySelectorAll('.hero-stat-number');
        
        statsElements.forEach((element, index) => {
            if (this.isElementInViewport(element)) {
                element.style.animation = `pulse 0.6s ease-in-out ${index * 0.2}s`;
                
                setTimeout(() => {
                    element.style.animation = '';
                }, 1000);
            }
        });
    }

    /**
     * Check if element is in viewport
     */
    isElementInViewport(element) {
        const rect = element.getBoundingClientRect();
        return (
            rect.top >= 0 &&
            rect.left >= 0 &&
            rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
            rect.right <= (window.innerWidth || document.documentElement.clientWidth)
        );
    }

    /**
     * Bind additional events
     */
    bindEvents() {
        // Keyboard shortcuts
        document.addEventListener('keydown', (e) => {
            // Space bar to scroll to features
            if (e.code === 'Space' && e.target === document.body) {
                e.preventDefault();
                const featuresSection = document.getElementById('features');
                if (featuresSection) {
                    featuresSection.scrollIntoView({ behavior: 'smooth' });
                }
            }
            
            // 'T' key to toggle theme
            if (e.key === 't' || e.key === 'T') {
                if (e.target === document.body) {
                    this.toggleTheme();
                }
            }
            
            // Enter key on focused links
            if (e.code === 'Enter' && e.target.tagName === 'A') {
                e.target.click();
            }
        });

        // Add focus effects
        document.addEventListener('focusin', (e) => {
            if (e.target.matches('a, button')) {
                e.target.style.outline = '3px solid rgba(6, 182, 212, 0.5)';
                e.target.style.outlineOffset = '3px';
            }
        });

        document.addEventListener('focusout', (e) => {
            if (e.target.matches('a, button')) {
                e.target.style.outline = '';
                e.target.style.outlineOffset = '';
            }
        });

        // Window resize handler
        window.addEventListener('resize', () => {
            this.handleResize();
        });

        // Visibility change handler
        document.addEventListener('visibilitychange', () => {
            if (document.hidden) {
                this.pauseAnimations();
            } else {
                this.resumeAnimations();
            }
        });
    }

    /**
     * Handle window resize
     */
    handleResize() {
        // Update particle system for new window size
        const particles = document.querySelectorAll('.particle');
        particles.forEach(particle => {
            if (Math.random() > 0.5) {
                particle.style.left = Math.random() * 100 + '%';
            }
        });
    }

    /**
     * Pause animations when tab is not visible
     */
    pauseAnimations() {
        const animatedElements = document.querySelectorAll('[style*="animation"]');
        animatedElements.forEach(element => {
            element.style.animationPlayState = 'paused';
        });
    }

    /**
     * Resume animations when tab becomes visible
     */
    resumeAnimations() {
        const animatedElements = document.querySelectorAll('[style*="animation"]');
        animatedElements.forEach(element => {
            element.style.animationPlayState = 'running';
        });
    }

    /**
     * Get current timestamp in required format
     */
    getCurrentTimestamp() {
        const now = new Date();
        const year = now.getFullYear();
        const month = String(now.getMonth() + 1).padStart(2, '0');
        const day = String(now.getDate()).padStart(2, '0');
        const hour = String(now.getHours()).padStart(2, '0');
        const minute = String(now.getMinutes()).padStart(2, '0');
        const second = String(now.getSeconds()).padStart(2, '0');
        
        return `${year}-${month}-${day} ${hour}:${minute}:${second}`;
    }
}

// Initialize the application when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    const app = new IndexApp();
    
    // Make app globally accessible for debugging
    window.indexApp = app;
    
    // Add smooth loading effect
    document.body.style.opacity = '0';
    document.body.style.transition = 'opacity 0.5s ease-in-out';
    
    setTimeout(() => {
        document.body.style.opacity = '1';
    }, 100);
});

// Handle page unload
window.addEventListener('beforeunload', () => {
    console.log('TaskFlow Pro Index Page Unloading');
});