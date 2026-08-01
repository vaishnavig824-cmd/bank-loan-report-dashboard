/* ===================================================================
   BANK LOAN REPORT - SQL QUERIES
   ===================================================================
   Purpose : All SQL queries used to build the KPIs, comparisons, and
             dimensional breakdowns for the Power BI Bank Loan Report
             (Summary page + Overview page).
   Table   : loan_data
   =================================================================== */


/* ===================================================================
   SECTION 1: SUMMARY PAGE - KEY PERFORMANCE INDICATORS (KPIs)
   Includes Month-to-Date (MTD) and Previous-Month-to-Date (PMTD)
   values used to build month-over-month indicators in Power BI.
   =================================================================== */

-- 1. Total Loan Applications
SELECT COUNT(id) AS Total_Loan_Applications
FROM loan_data;

-- 1a. MTD Loan Applications
SELECT COUNT(id) AS MTD_Total_Loan_Applications
FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12
  AND EXTRACT(YEAR FROM issue_date) = 2021;

-- 1b. PMTD Loan Applications (Previous Month to Date)
SELECT COUNT(id) AS PMTD_Total_Loan_Applications
FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11
  AND EXTRACT(YEAR FROM issue_date) = 2021;


-- 2. Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM loan_data;

-- 2a. MTD Funded Amount
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12
  AND EXTRACT(YEAR FROM issue_date) = 2021;

-- 2b. PMTD Funded Amount
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount
FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11
  AND EXTRACT(YEAR FROM issue_date) = 2021;


-- 3. Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected
FROM loan_data;

-- 3a. MTD Amount Received
SELECT SUM(total_payment) AS MTD_Total_Amount_Received
FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12
  AND EXTRACT(YEAR FROM issue_date) = 2021;

-- 3b. PMTD Amount Received
SELECT SUM(total_payment) AS PMTD_Total_Amount_Received
FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11
  AND EXTRACT(YEAR FROM issue_date) = 2021;


-- 4. Average Interest Rate
SELECT ROUND(AVG(int_rate), 2) * 100 AS Avg_Interest_Rate
FROM loan_data;

-- 4a. MTD Average Interest Rate
SELECT ROUND(AVG(int_rate), 2) * 100 AS MTD_Avg_Interest_Rate
FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12;

-- 4b. PMTD Average Interest Rate
SELECT AVG(int_rate) * 100 AS PMTD_Avg_Interest_Rate
FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11;


-- 5. Average Debt-to-Income Ratio (DTI)
SELECT AVG(dti) * 100 AS Avg_DTI
FROM loan_data;

-- 5a. MTD Average DTI
SELECT AVG(dti) * 100 AS MTD_Avg_DTI
FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12;

-- 5b. PMTD Average DTI
SELECT AVG(dti) * 100 AS PMTD_Avg_DTI
FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11;


/* ===================================================================
   SECTION 2: SUMMARY PAGE - GOOD LOAN vs BAD LOAN ANALYSIS
   Classifies loans as "Good" (Fully Paid / Current) or "Bad"
   (Charged Off) to measure portfolio risk.
   =================================================================== */


-- Good Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0)
    / COUNT(id) AS Good_Loan_Percentage
FROM loan_data;

-- Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications
FROM loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_Amount_Received
FROM loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';


/* -------------------- BAD LOAN ISSUED -------------------- */

-- Bad Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0)
    / COUNT(id) AS Bad_Loan_Percentage
FROM loan_data;

-- Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications
FROM loan_data
WHERE loan_status = 'Charged Off';

-- Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount
FROM loan_data
WHERE loan_status = 'Charged Off';

-- Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_Amount_Received
FROM loan_data
WHERE loan_status = 'Charged Off';


/* -------------------- LOAN STATUS BREAKDOWN -------------------- */

-- Full breakdown by loan status (feeds the Loan Status grid/table visual)
SELECT
    loan_status,
    COUNT(id)                  AS Loan_Count,
    SUM(total_payment)         AS Total_Amount_Received,
    SUM(loan_amount)           AS Total_Funded_Amount,
    AVG(int_rate * 100)        AS Interest_Rate,
    AVG(dti * 100)             AS DTI
FROM loan_data
GROUP BY loan_status;


/* ===================================================================
   SECTION 3: OVERVIEW PAGE - DIMENSIONAL ANALYSIS
   Breaks down applications, funded amount, and amount received by
   month, state, term, employment length, purpose, and home ownership.
   =================================================================== */


-- By Month (trend line / area chart)
SELECT
    EXTRACT(MONTH FROM issue_date)         AS Month_Number,
    TO_CHAR(issue_date, 'Month')           AS Month_Name,
    COUNT(id)                              AS Total_Loan_Applications,
    SUM(loan_amount)                       AS Total_Funded_Amount,
    SUM(total_payment)                     AS Total_Amount_Received
FROM loan_data
GROUP BY EXTRACT(MONTH FROM issue_date), TO_CHAR(issue_date, 'Month')
ORDER BY EXTRACT(MONTH FROM issue_date);


-- By State (filled map / bar chart)
SELECT
    address_state                          AS State,
    COUNT(id)                              AS Total_Loan_Applications,
    SUM(loan_amount)                       AS Total_Funded_Amount,
    SUM(total_payment)                     AS Total_Amount_Received
FROM loan_data
GROUP BY address_state
ORDER BY address_state;


-- By Loan Term (donut / bar chart)
SELECT
    term                                    AS Term,
    COUNT(id)                              AS Total_Loan_Applications,
    SUM(loan_amount)                       AS Total_Funded_Amount,
    SUM(total_payment)                     AS Total_Amount_Received
FROM loan_data
GROUP BY term
ORDER BY term;


-- By Employee Length (bar chart)
SELECT
    emp_length                              AS Employee_Length,
    COUNT(id)                              AS Total_Loan_Applications,
    SUM(loan_amount)                       AS Total_Funded_Amount,
    SUM(total_payment)                     AS Total_Amount_Received
FROM loan_data
GROUP BY emp_length
ORDER BY emp_length;


-- By Loan Purpose (bar chart)
SELECT
    purpose                                 AS Purpose,
    COUNT(id)                              AS Total_Loan_Applications,
    SUM(loan_amount)                       AS Total_Funded_Amount,
    SUM(total_payment)                     AS Total_Amount_Received
FROM loan_data
GROUP BY purpose
ORDER BY purpose;


-- By Home Ownership (bar chart)
SELECT
    home_ownership                          AS Home_Ownership,
    COUNT(id)                              AS Total_Loan_Applications,
    SUM(loan_amount)                       AS Total_Funded_Amount,
    SUM(total_payment)                     AS Total_Amount_Received
FROM loan_data
GROUP BY home_ownership
ORDER BY home_ownership;
