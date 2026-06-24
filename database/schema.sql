-- BloodBond Database Schema
-- MySQL | Designed by Resha Naik
-- Project: Blood Bond - Donor Recipient Matching Platform

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    contact_no VARCHAR(15) NOT NULL,
    -- aadhar_id VARCHAR(12) -- store hashed in production (bcrypt/SHA-256)
    age INT CHECK (age >= 18 AND age <= 65),
    sex ENUM('M', 'F', 'Other') NOT NULL,
    blood_group ENUM('A+','A-','B+','B-','AB+','AB-','O+','O-') NOT NULL,
    city VARCHAR(100),
    pincode VARCHAR(10),
    state VARCHAR(50),
    is_eligible BOOLEAN DEFAULT TRUE,
    last_donation_date DATE DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE pets (
    pet_id INT AUTO_INCREMENT PRIMARY KEY,
    owner_id INT NOT NULL,
    pet_name VARCHAR(50),
    species ENUM('Dog', 'Cat') NOT NULL,
    blood_type VARCHAR(20) NOT NULL,
    weight DECIMAL(5,2),
    sex ENUM('M', 'F') NOT NULL,
    age INT,
    vaccination_status BOOLEAN DEFAULT FALSE,
    licence_no VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE hospitals (
    hospital_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    address TEXT NOT NULL,
    pincode VARCHAR(10) NOT NULL,
    city VARCHAR(100),
    state VARCHAR(50) NOT NULL,
    contact_no VARCHAR(50),
    type ENUM('Hospital', 'Blood Bank', 'Veterinary') NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE blood_inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    hospital_id INT NOT NULL,
    blood_type VARCHAR(20) NOT NULL,
    subject_type ENUM('Human', 'Pet') NOT NULL,
    quantity_units INT NOT NULL DEFAULT 0,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (hospital_id) REFERENCES hospitals(hospital_id) ON DELETE CASCADE
);

CREATE TABLE requests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    request_type ENUM('Donate', 'Accept') NOT NULL,
    subject_type ENUM('Human', 'Pet') NOT NULL,
    pet_id INT DEFAULT NULL,
    blood_type VARCHAR(20) NOT NULL,
    pincode VARCHAR(10),
    state VARCHAR(50),
    urgency ENUM('Normal', 'Urgent', 'Critical') DEFAULT 'Normal',
    status ENUM('Pending', 'Fulfilled', 'Cancelled') DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (pet_id) REFERENCES pets(pet_id) ON DELETE SET NULL
);

CREATE TABLE donations (
    donation_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    hospital_id INT NOT NULL,
    subject_type ENUM('Human', 'Pet') NOT NULL,
    pet_id INT DEFAULT NULL,
    blood_type VARCHAR(20) NOT NULL,
    units INT NOT NULL DEFAULT 1,
    donation_date DATE NOT NULL,
    next_eligible_date DATE GENERATED ALWAYS AS (DATE_ADD(donation_date, INTERVAL 56 DAY)) STORED,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (hospital_id) REFERENCES hospitals(hospital_id) ON DELETE CASCADE,
    FOREIGN KEY (pet_id) REFERENCES pets(pet_id) ON DELETE SET NULL
);
