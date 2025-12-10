CREATE DATABASE IF NOT EXISTS student_management;
USE student_management;

DROP TABLE IF EXISTS remember_tokens;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    role ENUM('admin', 'user') DEFAULT 'user',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    INDEX idx_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE remember_tokens (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    token VARCHAR(255) UNIQUE NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_token (token),
    INDEX idx_expires_at (expires_at),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO users (username, password, full_name, role, is_active) VALUES
('admin', '$2a$10$UBvWInCwyjXjNCI6uBi0a.JxY4BBkn6jTu3UCb4P2E6Z3s2RdYFfi', 'Administrator', 'admin', TRUE),
('john', '$2a$10$UBvWInCwyjXjNCI6uBi0a.JxY4BBkn6jTu3UCb4P2E6Z3s2RdYFfi', 'John Doe', 'user', TRUE),
('jane', '$2a$10$UBvWInCwyjXjNCI6uBi0a.JxY4BBkn6jTu3UCb4P2E6Z3s2RdYFfi', 'Jane Smith', 'user', TRUE);

SELECT id, username, full_name, role, is_active, created_at FROM users;

-- ============================================
-- Test Credentials:
-- ============================================
-- Admin:
--   Username: admin
--   Password: password123
--   Role: admin
--
-- Regular Users:
--   Username: john
--   Password: password123
--   Role: user
--
--   Username: jane
--   Password: password123
--   Role: user
-- ============================================
