-- BloodBond Sample Data
-- MySQL | Designed by Resha Naik

INSERT INTO users (username, email, password_hash, contact_no, age, sex, blood_group, city, pincode, state, is_eligible, last_donation_date) VALUES
('resha_naik', 'resha@gmail.com', 'hashed_pwd_1', '9876543210', 22, 'F', 'O+', 'Mumbai', '400088', 'Maharashtra', TRUE, NULL),
('arjun_mehta', 'arjun@gmail.com', 'hashed_pwd_2', '9823456781', 25, 'M', 'A+', 'Mumbai', '400077', 'Maharashtra', FALSE, '2026-05-01'),
('priya_sharma', 'priya@gmail.com', 'hashed_pwd_3', '9812345678', 28, 'F', 'B+', 'Delhi', '110001', 'Delhi', TRUE, '2025-12-01'),
('rahul_das', 'rahul@gmail.com', 'hashed_pwd_4', '9834567890', 30, 'M', 'AB+', 'Kolkata', '700001', 'West Bengal', TRUE, NULL),
('sneha_iyer', 'sneha@gmail.com', 'hashed_pwd_5', '9845678901', 24, 'F', 'O-', 'Mumbai', '400050', 'Maharashtra', FALSE, '2026-04-15'),
('amit_patil', 'amit@gmail.com', 'hashed_pwd_6', '9856789012', 35, 'M', 'A-', 'Pune', '411001', 'Maharashtra', TRUE, NULL),
('kavya_nair', 'kavya@gmail.com', 'hashed_pwd_7', '9867890123', 27, 'F', 'B-', 'Mumbai', '400051', 'Maharashtra', TRUE, '2025-10-10'),
('rohan_joshi', 'rohan@gmail.com', 'hashed_pwd_8', '9878901234', 32, 'M', 'O+', 'Mumbai', '400014', 'Maharashtra', FALSE, '2026-05-20');

INSERT INTO hospitals (name, address, pincode, city, state, contact_no, type) VALUES
('ACTREC Blood Bank', '2nd Floor, Jussawala Shodika, Dept of Transfusion Medicine, ACTREC, Tata Memorial Centre, Sector 22, Kharghar', '410210', 'Navi Mumbai', 'Maharashtra', '022-27405073', 'Blood Bank'),
('Anviksha Pathological Laboratory Blood Bank', '1st floor, Paras Darshan, Above Titan Showroom, M.G. Road, Ghatkopar (E)', '400077', 'Mumbai', 'Maharashtra', '022-21026290', 'Blood Bank'),
('Arpan Blood Bank', 'Aniraj Tower, 2nd Floor, Opp. Janta Market, L.B.S. Marg, Bhandup (W)', '400078', 'Mumbai', 'Maharashtra', '022-25951044', 'Blood Bank'),
('Ashirwad Blood Bank', 'Imperial Mahal, 2nd Floor, Khodadad Circle, Dr. B.A. Ambedkar Road, Dadar TT', '400014', 'Mumbai', 'Maharashtra', '022-24154826', 'Blood Bank'),
('Asian Heart Institute Blood Bank', '1st Floor, Asian Heart Institute, Opp. ICICI Tower, Bandra Kurla Complex', '400051', 'Mumbai', 'Maharashtra', '022-66986570', 'Blood Bank'),
('B.D. Petit Parsee General Hospital Blood Bank', 'Old Bldg., 1st Floor, B.D. Petit Road, Cumballa Hill', '400036', 'Mumbai', 'Maharashtra', '022-23685350', 'Hospital'),
('Bombay Hospital Trust Blood Bank', 'Ground Floor, New Wing, 12-New Marine Lines, Dhobitalao', '400020', 'Mumbai', 'Maharashtra', '022-22067676', 'Hospital'),
('Borivali Blood Bank', '1st Floor, Vithal Apartment, Mandpeshwar Road, SVP Flyover, Borivali (W)', '400103', 'Mumbai', 'Maharashtra', '022-28936203', 'Blood Bank'),
('Paws & Claws Veterinary Centre', 'Shop 4, Linking Road, Bandra (W)', '400050', 'Mumbai', 'Maharashtra', '9820012345', 'Veterinary'),
('Mumbai Pet Hospital', '15, Hill Road, Bandra (W)', '400050', 'Mumbai', 'Maharashtra', '9821023456', 'Veterinary');

INSERT INTO blood_inventory (hospital_id, blood_type, subject_type, quantity_units) VALUES
(1, 'A+', 'Human', 10),
(1, 'O+', 'Human', 8),
(1, 'B+', 'Human', 5),
(2, 'A+', 'Human', 12),
(2, 'AB+', 'Human', 3),
(2, 'O-', 'Human', 6),
(3, 'B+', 'Human', 7),
(3, 'A-', 'Human', 4),
(4, 'O+', 'Human', 9),
(4, 'AB-', 'Human', 2),
(5, 'A+', 'Human', 15),
(5, 'B-', 'Human', 3),
(7, 'O+', 'Human', 20),
(7, 'O-', 'Human', 11),
(7, 'AB+', 'Human', 4),
(8, 'A+', 'Human', 6),
(8, 'B+', 'Human', 8),
(9, 'DEA 1.1', 'Pet', 4),
(9, 'DEA 1.2', 'Pet', 3),
(9, 'A', 'Pet', 5),
(10, 'DEA 1.1', 'Pet', 6),
(10, 'DEA 4', 'Pet', 2),
(10, 'B', 'Pet', 4);

INSERT INTO pets (owner_id, pet_name, species, blood_type, weight, sex, age, vaccination_status, licence_no) VALUES
(1, 'Bruno', 'Dog', 'DEA 1.1', 28.50, 'M', 4, TRUE, 'MH-DOG-2023-001'),
(1, 'Whiskers', 'Cat', 'A', 4.20, 'F', 2, TRUE, 'MH-CAT-2023-002'),
(3, 'Max', 'Dog', 'DEA 1.2', 32.00, 'M', 5, TRUE, 'DL-DOG-2022-015'),
(4, 'Luna', 'Cat', 'B', 3.80, 'F', 3, FALSE, 'WB-CAT-2023-008'),
(6, 'Rocky', 'Dog', 'DEA 4', 25.00, 'M', 6, TRUE, 'MH-DOG-2021-033'),
(7, 'Mimi', 'Cat', 'AB', 4.50, 'F', 1, TRUE, 'MH-CAT-2024-011');

INSERT INTO requests (user_id, request_type, subject_type, pet_id, blood_type, pincode, state, urgency, status) VALUES
(1, 'Donate', 'Human', NULL, 'O+', '400088', 'Maharashtra', 'Normal', 'Pending'),
(3, 'Donate', 'Human', NULL, 'B+', '110001', 'Delhi', 'Normal', 'Fulfilled'),
(6, 'Donate', 'Human', NULL, 'A-', '411001', 'Maharashtra', 'Normal', 'Pending'),
(2, 'Accept', 'Human', NULL, 'A+', '400077', 'Maharashtra', 'Urgent', 'Pending'),
(4, 'Accept', 'Human', NULL, 'AB+', '700001', 'West Bengal', 'Critical', 'Fulfilled'),
(8, 'Accept', 'Human', NULL, 'O+', '400014', 'Maharashtra', 'Normal', 'Cancelled'),
(1, 'Donate', 'Pet', 1, 'DEA 1.1', '400088', 'Maharashtra', 'Normal', 'Fulfilled'),
(6, 'Donate', 'Pet', 5, 'DEA 4', '411001', 'Maharashtra', 'Normal', 'Pending'),
(3, 'Accept', 'Pet', 3, 'DEA 1.2', '110001', 'Delhi', 'Urgent', 'Pending'),
(7, 'Accept', 'Pet', 6, 'AB', '400051', 'Maharashtra', 'Critical', 'Fulfilled');

INSERT INTO donations (user_id, hospital_id, subject_type, pet_id, blood_type, units, donation_date) VALUES
(2, 3, 'Human', NULL, 'A+', 1, '2026-05-01'),
(5, 5, 'Human', NULL, 'O-', 1, '2026-04-15'),
(3, 1, 'Human', NULL, 'B+', 1, '2025-12-01'),
(7, 2, 'Human', NULL, 'B-', 1, '2025-10-10'),
(8, 4, 'Human', NULL, 'O+', 1, '2026-05-20'),
(1, 9, 'Pet', 1, 'DEA 1.1', 1, '2025-11-15'),
(6, 10, 'Pet', 5, 'DEA 4', 1, '2025-09-20');
