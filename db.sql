-- TG-Twitter Poster Database Schema
-- SQLite database structure for managing users, invitations, and applications
-- Author: TG-Twitter Poster Team
-- License: MIT

-- Enable foreign key constraints
PRAGMA foreign_keys = ON;

-- Users table - stores registered users
CREATE TABLE IF NOT EXISTS users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    telegram_id INTEGER NOT NULL UNIQUE,
    username TEXT,
    first_name TEXT,
    last_name TEXT,
    twitter_handle TEXT,
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    is_admin BOOLEAN DEFAULT FALSE,
    last_seen DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Invitations table - manages invitation system
CREATE TABLE IF NOT EXISTS invitations (
    invitation_id INTEGER PRIMARY KEY AUTOINCREMENT,
    code TEXT NOT NULL UNIQUE,
    invited_by INTEGER,
    invited_user INTEGER,
    status TEXT DEFAULT 'pending', -- pending, used, expired
    expires_at DATETIME,
    used_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (invited_by) REFERENCES users(user_id),
    FOREIGN KEY (invited_user) REFERENCES users(user_id)
);

-- Applications table - stores application registrations
CREATE TABLE IF NOT EXISTS applications (
    application_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    app_name TEXT NOT NULL,
    description TEXT,
    telegram_bot_token TEXT,
    twitter_api_key TEXT,
    twitter_api_secret TEXT,
    twitter_access_token TEXT,
    twitter_access_secret TEXT,
    status TEXT DEFAULT 'pending', -- pending, approved, rejected
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    approved_at DATETIME,
    approved_by INTEGER,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (approved_by) REFERENCES users(user_id)
);

-- Posts table - tracks posted messages
CREATE TABLE IF NOT EXISTS posts (
    post_id INTEGER PRIMARY KEY AUTOINCREMENT,
    application_id INTEGER NOT NULL,
    telegram_message_id INTEGER,
    twitter_tweet_id TEXT,
    content TEXT NOT NULL,
    post_type TEXT DEFAULT 'text', -- text, photo, video, document
    status TEXT DEFAULT 'pending', -- pending, posted, failed
    error_message TEXT,
    posted_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (application_id) REFERENCES applications(application_id)
);

-- Settings table - application settings
CREATE TABLE IF NOT EXISTS settings (
    setting_id INTEGER PRIMARY KEY AUTOINCREMENT,
    application_id INTEGER NOT NULL,
    setting_key TEXT NOT NULL,
    setting_value TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (application_id) REFERENCES applications(application_id),
    UNIQUE(application_id, setting_key)
);

-- Logs table - application logs
CREATE TABLE IF NOT EXISTS logs (
    log_id INTEGER PRIMARY KEY AUTOINCREMENT,
    application_id INTEGER,
    log_level TEXT NOT NULL, -- DEBUG, INFO, WARNING, ERROR
    message TEXT NOT NULL,
    details TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (application_id) REFERENCES applications(application_id)
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_users_telegram_id ON users(telegram_id);
CREATE INDEX IF NOT EXISTS idx_invitations_code ON invitations(code);
CREATE INDEX IF NOT EXISTS idx_invitations_status ON invitations(status);
CREATE INDEX IF NOT EXISTS idx_applications_user_id ON applications(user_id);
CREATE INDEX IF NOT EXISTS idx_applications_status ON applications(status);
CREATE INDEX IF NOT EXISTS idx_posts_application_id ON posts(application_id);
CREATE INDEX IF NOT EXISTS idx_posts_status ON posts(status);
CREATE INDEX IF NOT EXISTS idx_logs_application_id ON logs(application_id);
CREATE INDEX IF NOT EXISTS idx_logs_created_at ON logs(created_at);

-- Insert default admin user (optional)
-- INSERT OR IGNORE INTO users (telegram_id, username, first_name, is_admin)
-- VALUES (123456789, 'admin', 'Admin', TRUE);

-- Insert sample invitation codes (optional)
-- INSERT OR IGNORE INTO invitations (code, expires_at)
-- VALUES ('WELCOME2024', datetime('now', '+30 days'));

COMMIT;
