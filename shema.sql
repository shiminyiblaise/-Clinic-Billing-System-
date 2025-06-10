
-- Sample SQL Schema for a Medical Billing System
-- This schema includes tables for patients, medical histories, treatments, invoices, and invoice items.

-- Drop tables if they exist (for re-runs)
DROP TABLE IF EXISTS invoice_items, invoices, treatments, medical_histories, patients CASCADE;

-- =============================
-- Table: patients
-- =============================
CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE
);

-- =============================
-- Table: medical_histories
-- =============================
CREATE TABLE medical_histories (
    id SERIAL PRIMARY KEY,
    admitted_at TIMESTAMP NOT NULL,
    patient_id INT NOT NULL,
    status VARCHAR(50),
    CONSTRAINT fk_medical_history_patient
        FOREIGN KEY (patient_id)
        REFERENCES patients(id)
        ON DELETE CASCADE
);

-- Create index for FK
CREATE INDEX idx_medical_histories_patient_id ON medical_histories(patient_id);

-- =============================
-- Table: treatments
-- =============================
CREATE TABLE treatments (id SERIAL PRIMARY KEY, type VARCHAR(50), name VARCHAR(100));

-- =============================
-- Table: invoices
-- =============================
CREATE TABLE invoices (
    id SERIAL PRIMARY KEY,
    total_amount DECIMAL(10, 2),
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT NOT NULL,
    CONSTRAINT fk_invoice_medical_history
        FOREIGN KEY (medical_history_id)
        REFERENCES medical_histories(id)
        ON DELETE CASCADE
);

-- Create index for FK
CREATE INDEX idx_invoices_medical_history_id ON invoices(medical_history_id);

-- =============================
-- Table: invoice_items
-- =============================
CREATE TABLE invoice_items (
    id SERIAL PRIMARY KEY,
    unit_price DECIMAL(10, 2),
    quantity INT,
    total_price DECIMAL(10, 2),
    invoice_id INT NOT NULL,
    treatment_id INT NOT NULL,
    CONSTRAINT fk_invoice_item_invoice
        FOREIGN KEY (invoice_id)
        REFERENCES invoices(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_invoice_item_treatment
        FOREIGN KEY (treatment_id)
        REFERENCES treatments(id)
        ON DELETE CASCADE
);

-- Create indexes for FKs
CREATE INDEX idx_invoice_items_invoice_id ON invoice_items(invoice_id);
CREATE INDEX idx_invoice_items_treatment_id ON invoice_items(treatment_id);
