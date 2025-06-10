
-- Sample Data Inserts
-- ======================================

-- Insert Patients
INSERT INTO patients (name, date_of_birth) VALUES
('John Doe', '1990-01-01'),
('Jane Smith', '1985-06-15');

-- Insert Medical Histories
INSERT INTO medical_histories (admitted_at, patient_id, status) VALUES
(NOW(), 1, 'admitted'),
(NOW(), 2, 'discharged');

-- Insert Treatments
INSERT INTO treatments (type, name) VALUES
('surgery', 'Appendectomy'),
('medication', 'Antibiotics');

-- Insert Invoices
INSERT INTO invoices (total_amount, generated_at, payed_at, medical_history_id) VALUES
(1500.00, NOW(), NULL, 1),
(200.00, NOW(), NOW(), 2);

-- Insert Invoice Items
INSERT INTO invoice_items (unit_price, quantity, total_price, invoice_id, treatment_id) VALUES
(1500.00, 1, 1500.00, 1, 1),
(100.00, 2, 200.00, 2, 2);

-- ======================================
-- Sample Queries
-- ======================================

-- Get all patients and their medical histories
SELECT p.name, mh.status, mh.admitted_at
FROM patients p
JOIN medical_histories mh ON p.id = mh.patient_id;

-- Get all treatments applied to a specific patient
SELECT p.name AS patient_name, t.name AS treatment_name, t.type
FROM patients p
JOIN medical_histories mh ON p.id = mh.patient_id
JOIN invoices i ON mh.id = i.medical_history_id
JOIN invoice_items ii ON i.id = ii.invoice_id
JOIN treatments t ON ii.treatment_id = t.id
WHERE p.id = 1;

-- Get total amount billed per patient
SELECT p.name, SUM(i.total_amount) AS total_billed
FROM patients p
JOIN medical_histories mh ON p.id = mh.patient_id
JOIN invoices i ON mh.id = i.medical_history_id
GROUP BY p.name;
