CREATE DATABASE digital_loan_analysis;

USE digital_loan_analysis;

CREATE TABLE loans (
    id INT,
    address_state VARCHAR(10),
    application_type VARCHAR(50),
    emp_length VARCHAR(50),
    emp_title VARCHAR(255),
    grade VARCHAR(5),
    home_ownership VARCHAR(50),
    issue_date DATE,
    last_credit_pull_date DATE,
    last_payment_date DATE,
    next_payment_date DATE,
    loan_status VARCHAR(50),
    member_id INT,
    purpose VARCHAR(100),
    sub_grade VARCHAR(5),
    term INT,
    verification_status VARCHAR(50),
    annual_income DECIMAL(15,2),
    dti DECIMAL(10,4),
    installment DECIMAL(10,2),
    int_rate DECIMAL(10,4),
    loan_amount DECIMAL(12,2),
    total_acc INT,
    total_payment DECIMAL(12,2)
);

ALTER TABLE loans
MODIFY issue_date VARCHAR(20),
MODIFY last_credit_pull_date VARCHAR(20),
MODIFY last_payment_date VARCHAR(20),
MODIFY next_payment_date VARCHAR(20);

ALTER TABLE loans
MODIFY term VARCHAR(20);

SELECT COUNT(*) AS total_records
FROM loans;

SELECT COUNT(*) AS total_records
FROM loans;

DESCRIBE loans;

SELECT *
FROM loans
LIMIT 5;

SELECT loan_status, COUNT(*) AS total_loans
FROM loans
GROUP BY loan_status
ORDER BY total_loans DESC;

SELECT 
    SUM(loan_amount) AS total_loan_amount,
    AVG(loan_amount) AS average_loan_amount,
    MIN(loan_amount) AS minimum_loan_amount,
    MAX(loan_amount) AS maximum_loan_amount
FROM loans;

SELECT 
    grade,
    COUNT(*) AS total_loans,
    SUM(loan_amount) AS total_loan_amount,
    AVG(int_rate) AS average_interest_rate
FROM loans
GROUP BY grade
ORDER BY grade;

SELECT 
    grade,
    COUNT(*) AS charged_off_loans
FROM loans
WHERE loan_status = 'Charged Off'
GROUP BY grade
ORDER BY charged_off_loans DESC;

SELECT
    grade,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS charged_off_loans,
    ROUND(
        SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS charge_off_rate
FROM loans
GROUP BY grade
ORDER BY charge_off_rate DESC;

SELECT
    purpose,
    COUNT(*) AS total_loans,
    SUM(loan_amount) AS total_loan_amount,
    ROUND(AVG(loan_amount), 2) AS average_loan_amount
FROM loans
GROUP BY purpose
ORDER BY total_loan_amount DESC;

SELECT
    term,
    COUNT(*) AS total_loans,
    SUM(loan_amount) AS total_loan_amount,
    ROUND(AVG(int_rate) * 100, 2) AS average_interest_rate
FROM loans
GROUP BY term
ORDER BY term;

SELECT
    grade,
    COUNT(*) AS charged_off_loans
FROM loans
WHERE loan_status = 'Charged Off'
GROUP BY grade
HAVING COUNT(*) > 500
ORDER BY charged_off_loans DESC;

SELECT
    id,
    loan_amount,
    grade,
    purpose,
    loan_status
FROM loans
ORDER BY loan_amount DESC
LIMIT 10;

SELECT
    id,
    loan_amount,
    annual_income,
    dti,
    grade,
    loan_status
FROM loans
WHERE dti > 0.20
ORDER BY dti DESC
LIMIT 10;

SELECT
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS charged_off_loans,
    ROUND(
        SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS charge_off_rate
FROM loans;