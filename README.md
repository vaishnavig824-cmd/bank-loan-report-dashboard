# Bank Loan Report Dashboard

## Description / Purpose

This project is an end-to-end business intelligence dashboard built for a bank to track, analyze, and monitor its loan portfolio. The goal is to help management understand loan application volume, funded and received amounts, loan quality (good vs bad loans), and repayment performance so they can make faster, data-driven lending decisions.

The raw loan data was first loaded and queried in SQL Server for cleaning, exploration, and KPI calculation, and then connected to Power BI to build an interactive, multi-page dashboard with drill-down visuals, filters, and KPI cards.

## Tech Stack

**SQL (MS SQL Server)**
- Creating database and tables
- SELECT, DISTINCT, ORDER BY, GROUP BY, LIMIT
- DATENAME, DATEPART, CAST, DECIMAL, MONTH, HOUR, QUARTER, DAY functions
- CTE (Common Table Expressions)
- Window functions / PARTITION
- COUNT and aggregate calculations

**Power BI**
- Connecting Power BI to SQL Server
- Power Query for data cleaning and data processing
- Data modeling
- Date tables and time intelligence functions
- DAX (Data Analysis Expressions)
- Date, text, and filter functions
- CALCULATE, SUM, SUMX
- Creating KPI cards and new card visuals
- Building charts and formatting visuals
- Creating DAX measures and functions
- Page navigation buttons

## Data Source

The dataset used for this project is a bank loan dataset sourced from **Kaggle**. It contains loan-level records including loan ID, purpose, home ownership, grade, sub-grade, issue date, funded amount, interest rate, installment, amount received, DTI, and loan status.

## Features / Highlights

### Business Problem
The bank did not have a consolidated way to view its lending performance. Loan officers and management needed a single source of truth to answer questions like: How many loans are being issued? How much money is funded versus recovered? What percentage of loans are performing well versus defaulting? Which states, terms, and borrower profiles carry the most risk?

### Goal of the Dashboard
To build a 3-page interactive Power BI report that gives the bank real-time visibility into loan applications, funded and received amounts, interest rates, DTI, and good vs bad loan performance, along with the ability to filter by state, grade, and loan purpose.

### Walkthrough of Key Visuals

**Page 1 â€” Summary**
- KPI cards for Total Loan Applications, Total Funded Amount, Total Amount Received, Average Interest Rate, and Average DTI, each with MTD (Month-to-Date) and MoM (Month-over-Month) change indicators
- Good Loan vs Bad Loan donut charts showing application percentage, funded amount, and received amount for each category
- A Loan Status grid view summarizing Total Loan Applications, Total Funded Amount, Total Amount Received, MTD Funded Amount, MTD Amount Received, Average Interest Rate, and Average DTI, broken down by Charged Off, Current, and Fully Paid status

**Page 2 â€” Overview**
- Line chart of Total Loan Applications by Month to identify seasonality and long-term lending trends
- Filled map of Total Loan Applications by State to spot regions with high lending activity
- Donut chart of Total Loan Applications by Term (36 vs 60 months)
- Bar chart of Total Loan Applications by Employee Length to see how loan activity varies with borrower tenure
- Bar chart of Total Funded Amount by Purpose (debt consolidation, credit card, home improvement, etc.)
- Tree map of Total Funded Amount by Home Ownership (rent, mortgage, own)

**Page 3 â€” Details**
- A comprehensive data grid showing loan-level details: ID, Purpose, Home Ownership, Grade, Sub Grade, Issue Date, Funded Amount, Interest Rate, Installment, and Amount Received
- Acts as a one-stop view for anyone who wants to inspect individual loan records rather than aggregated numbers

All three pages share common slicers for State, Grade, Purpose, and Good vs Bad Loan, along with a consistent navigation panel for easy switching between pages.

## Business Impact and Insights

- Out of 38.6K total loan applications, 86.2% are classified as good loans and only 13.8% as bad loans, showing a generally healthy loan book
- Total funded amount stands at $435.8M against a total amount received of $473.1M, indicating positive overall repayment performance
- The average interest rate across the portfolio is 12.0% and the average DTI is 13.3%, giving the bank a quick benchmark for portfolio risk
- Fully Paid loans make up the majority of applications (32,145 out of 38,576), while Charged Off loans (5,333) represent the main area of credit risk to monitor
- Debt consolidation is by far the leading loan purpose, followed by credit card and other purposes, helping the bank understand borrower demand
- Borrowers with 10+ years of employment history submit the highest number of applications, suggesting employment tenure could be a useful factor in risk assessment
- The dashboard enables the bank to monitor MTD and MoM trends on every core KPI, allowing faster reaction to month-over-month changes in lending performance

## Snapshots of the Dashboard
(https://github.com/vaishnavig824-cmd/bank-loan-report-dashboard/blob/main/Snapshots%20of%20the%20Dashboard/Screenshot%201%20(Summary).png)

