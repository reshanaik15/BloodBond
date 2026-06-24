-- BloodBond Practice Queries
-- MySQL | Designed by Resha Naik

-- =====================
-- JOINS
-- =====================

-- Q1: Show all donations with user name and hospital name
SELECT u.username, d.blood_type, d.donation_date, d.next_eligible_date, h.name AS hospital
FROM donations d
INNER JOIN users u ON d.user_id = u.user_id
INNER JOIN hospitals h ON d.hospital_id = h.hospital_id;

-- Q2: Show all users and their donations (including users who never donated)
SELECT u.username, u.blood_group, d.donation_date, d.next_eligible_date
FROM users u
LEFT JOIN donations d ON u.user_id = d.user_id
ORDER BY u.username;

-- Q3: Show all pet donations with owner name and pet name
SELECT u.username AS owner, p.pet_name, p.species, d.blood_type, d.donation_date, h.name AS hospital
FROM donations d
INNER JOIN users u ON d.user_id = u.user_id
INNER JOIN pets p ON d.pet_id = p.pet_id
INNER JOIN hospitals h ON d.hospital_id = h.hospital_id
WHERE d.subject_type = 'Pet';

-- =====================
-- GROUP BY + HAVING
-- =====================

-- Q4: Count donations per user
SELECT u.username, COUNT(d.donation_id) AS total_donations
FROM users u
LEFT JOIN donations d ON u.user_id = d.user_id
GROUP BY u.user_id, u.username
ORDER BY total_donations DESC;

-- Q5: Total blood units per hospital
SELECT h.name, SUM(bi.quantity_units) AS total_units
FROM hospitals h
INNER JOIN blood_inventory bi ON h.hospital_id = bi.hospital_id
GROUP BY h.hospital_id, h.name
ORDER BY total_units DESC;

-- Q6: Show only hospitals with more than 10 total units
SELECT h.name, SUM(bi.quantity_units) AS total_units
FROM hospitals h
INNER JOIN blood_inventory bi ON h.hospital_id = bi.hospital_id
GROUP BY h.hospital_id, h.name
HAVING total_units > 10
ORDER BY total_units DESC;

-- Q7: Blood type popularity across all requests
SELECT blood_type, request_type, COUNT(*) AS total_requests
FROM requests
GROUP BY blood_type, request_type
ORDER BY total_requests DESC;

-- =====================
-- SUBQUERIES
-- =====================

-- Q8: Find users who have never donated
SELECT username, blood_group, city
FROM users
WHERE user_id NOT IN (
    SELECT DISTINCT user_id FROM donations
);

-- Q9: Find hospitals with more than average blood inventory units
SELECT h.name, SUM(bi.quantity_units) AS total_units
FROM hospitals h
INNER JOIN blood_inventory bi ON h.hospital_id = bi.hospital_id
GROUP BY h.hospital_id, h.name
HAVING total_units > (
    SELECT AVG(quantity_units) FROM blood_inventory
);

-- Q10: Find users currently ineligible to donate (within 56 days)
SELECT u.username, u.blood_group, d.donation_date, d.next_eligible_date
FROM users u
INNER JOIN donations d ON u.user_id = d.user_id
WHERE d.next_eligible_date > CURDATE()
AND d.subject_type = 'Human';

-- Q11: Show pending requests for blood types currently out of stock
SELECT r.request_id, r.blood_type, r.subject_type, r.urgency, u.username
FROM requests r
INNER JOIN users u ON r.user_id = u.user_id
WHERE r.blood_type NOT IN (
    SELECT blood_type FROM blood_inventory
    WHERE quantity_units > 0
    AND subject_type = r.subject_type
)
AND r.status = 'Pending';

-- =====================
-- AGGREGATES
-- =====================

-- Q12: Most needed blood type (highest accept requests)
SELECT blood_type, COUNT(*) AS demand
FROM requests
WHERE request_type = 'Accept'
GROUP BY blood_type
ORDER BY demand DESC
LIMIT 1;

-- Q13: State-wise eligible donor count
SELECT state, COUNT(*) AS total_donors
FROM users
WHERE is_eligible = TRUE
GROUP BY state
ORDER BY total_donors DESC;

-- Q14: Eligible donors matching pending accept requests by blood type
SELECT 
    r.request_id,
    r.blood_type,
    r.urgency,
    u_requester.username AS requester,
    u_donor.username AS potential_donor,
    u_donor.city AS donor_city
FROM requests r
INNER JOIN users u_requester ON r.user_id = u_requester.user_id
INNER JOIN users u_donor ON u_donor.blood_group = r.blood_type
WHERE r.request_type = 'Accept'
AND r.status = 'Pending'
AND u_donor.is_eligible = TRUE
AND u_donor.user_id != r.user_id;

-- Q15: Hospital inventory summary by blood type for human vs pet
SELECT 
    subject_type,
    blood_type,
    SUM(quantity_units) AS total_available,
    COUNT(DISTINCT hospital_id) AS available_at_hospitals
FROM blood_inventory
GROUP BY subject_type, blood_type
ORDER BY subject_type, total_available DESC;
