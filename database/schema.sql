-- ============================================================
-- Child Vaccination Tool - Database Schema (PostgreSQL)
-- Run this entire file once on your Postgres database before
-- starting the application (locally, or on Render's managed Postgres).
--
-- NOTE: unlike MySQL, Postgres does not let you "CREATE DATABASE"
-- from inside a script the normal way when Render already creates
-- one for you. So this file assumes the database itself already
-- exists (Render creates it when you provision a Postgres instance;
-- locally, create one first with: createdb child_vaccination_db)
-- and only creates the TABLES inside it.
-- ============================================================

-- ---------------------------------------------------------------
-- Admin table (the tool owner / staff who manage vaccine master data)
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS admin (
    admin_id   SERIAL PRIMARY KEY,
    username   VARCHAR(50)  NOT NULL UNIQUE,
    password   VARCHAR(255) NOT NULL,   -- BCrypt hash, never plain text
    email      VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------------------------------------------------
-- Users table (parents / guardians)
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    user_id    SERIAL PRIMARY KEY,
    full_name  VARCHAR(100) NOT NULL,
    email      VARCHAR(100) NOT NULL UNIQUE,
    phone      VARCHAR(15)  NOT NULL,
    password   VARCHAR(255) NOT NULL,   -- BCrypt hash
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------------------------------------------------
-- Vaccines master table (managed by Admin)
-- recommended_age_days = how many days after birth this dose is due
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS vaccines (
    vaccine_id            SERIAL PRIMARY KEY,
    vaccine_name          VARCHAR(100) NOT NULL,
    description           TEXT,
    recommended_age_days  INT NOT NULL,
    dose_number            INT DEFAULT 1,
    price                  DECIMAL(10,2) DEFAULT 0.00,
    created_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------------------------------------------------
-- Children table (each belongs to one user/parent)
-- Postgres has no MySQL-style ENUM shorthand, so we use a CHECK
-- constraint instead - same validation effect.
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS children (
    child_id   SERIAL PRIMARY KEY,
    user_id    INT NOT NULL,
    child_name VARCHAR(100) NOT NULL,
    dob        DATE NOT NULL,
    gender     VARCHAR(10) NOT NULL CHECK (gender IN ('Male','Female','Other')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_children_user FOREIGN KEY (user_id)
        REFERENCES users(user_id) ON DELETE CASCADE
);

-- ---------------------------------------------------------------
-- Vaccine log table -> which vaccine was given to which child, when
-- (a vaccine can only be logged once per child -> unique constraint)
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS vaccine_log (
    log_id      SERIAL PRIMARY KEY,
    child_id    INT NOT NULL,
    vaccine_id  INT NOT NULL,
    date_given  DATE NOT NULL,
    notes       VARCHAR(255),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_log_child   FOREIGN KEY (child_id)   REFERENCES children(child_id)  ON DELETE CASCADE,
    CONSTRAINT fk_log_vaccine FOREIGN KEY (vaccine_id) REFERENCES vaccines(vaccine_id) ON DELETE CASCADE,
    CONSTRAINT unique_child_vaccine UNIQUE (child_id, vaccine_id)
);

-- ---------------------------------------------------------------
-- Seed data
-- ---------------------------------------------------------------

-- NOTE: The default admin account (username: admin, password: Admin@123) is
-- created AUTOMATICALLY the first time the app starts (see AppInitListener.java),
-- so its password is properly BCrypt-hashed at runtime instead of being pasted
-- here as plain SQL. You do not need to insert an admin row manually.

-- Standard Indian infant immunization schedule (simplified, editable by admin later)
-- NOTE: only run this INSERT once - re-running schema.sql a second time would
-- duplicate these rows since there's no unique constraint on vaccine_name.
INSERT INTO vaccines (vaccine_name, description, recommended_age_days, dose_number, price) VALUES
('BCG', 'Bacillus Calmette-Guerin - protects against Tuberculosis', 0, 1, 150.00),
('Hepatitis B - Birth Dose', 'First dose of Hepatitis B vaccine', 0, 1, 200.00),
('OPV - 0', 'Oral Polio Vaccine, birth dose', 0, 1, 100.00),
('OPV - 1', 'Oral Polio Vaccine, first dose', 42, 1, 100.00),
('DTP - 1', 'Diphtheria, Tetanus, Pertussis - first dose', 42, 1, 300.00),
('Hepatitis B - 1', 'Second dose of Hepatitis B vaccine', 42, 2, 200.00),
('OPV - 2', 'Oral Polio Vaccine, second dose', 70, 2, 100.00),
('DTP - 2', 'Diphtheria, Tetanus, Pertussis - second dose', 70, 2, 300.00),
('OPV - 3', 'Oral Polio Vaccine, third dose', 98, 3, 100.00),
('DTP - 3', 'Diphtheria, Tetanus, Pertussis - third dose', 98, 3, 300.00),
('Measles - 1', 'First dose of Measles vaccine', 270, 1, 250.00),
('MMR - 1', 'Measles, Mumps, Rubella - first dose', 365, 1, 400.00),
('DTP Booster - 1', 'First DTP booster dose', 548, 1, 300.00),
('MMR - 2', 'Measles, Mumps, Rubella - second dose', 548, 2, 400.00);
